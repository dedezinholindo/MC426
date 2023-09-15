import unittest
import json
from cadastro_login import app

class TestApp(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_cadastro_sucesso(self):
        data = {
            "username": "novousuario",
            "senha": "senhasegura",
            "nome": "Novo Usuário",
            "idade": "25",
            "email": "novo@email.com"
        }

        response = self.app.post('/cadastro', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 201)
        self.assertEqual(data['mensagem'], 'Usuário cadastrado com sucesso')

    def test_cadastro_campos_obrigatorios_faltando(self):
        data = {
            "username": "novousuario",
            "senha": "senhasegura"
        }

        response = self.app.post('/cadastro', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 400)
        self.assertEqual(data['mensagem'], 'Campos obrigatórios faltando')

    def test_cadastro_senha_curta(self):
        data = {
            "username": "novousuario",
            "senha": "curta",
            "nome": "Novo Usuário",
            "idade": "25",
            "email": "novo@email.com"
        }

        response = self.app.post('/cadastro', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 400)
        self.assertEqual(data['mensagem'], 'A senha deve ter entre 8 e 20 caracteres')

    def test_cadastro_idade_nao_numerica(self):
        data = {
            "username": "novousuario",
            "senha": "senhasegura",
            "nome": "Novo Usuário",
            "idade": "vinte e cinco",
            "email": "novo@email.com"
        }

        response = self.app.post('/cadastro', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 400)
        self.assertEqual(data['mensagem'], 'A idade deve conter apenas números')

    def test_login_sucesso(self):
        data = {
            "username": "novousuario",
            "senha": "senhasegura"
        }

        response = self.app.post('/login', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 200)
        self.assertEqual(data['mensagem'], 'Autenticação bem-sucedida')

    def test_login_campos_obrigatorios_faltando(self):
        data = {
            "username": "novousuario"
        }

        response = self.app.post('/login', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 400)
        self.assertEqual(data['mensagem'], 'Campos obrigatórios faltando')

    def test_login_credenciais_invalidas(self):
        data = {
            "username": "novousuario",
            "senha": "senhaincorreta"
        }

        response = self.app.post('/login', json=data)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(response.status_code, 401)
        self.assertEqual(data['mensagem'], 'Nome de usuário ou senha inválidos')

if __name__ == '__main__':
    unittest.main()
