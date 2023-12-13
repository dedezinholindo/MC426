import unittest
from unittest.mock import patch
import app

class TestComplaints(unittest.TestCase):

    def setUp(self) -> None:
        # Configurar o cliente de teste Flask
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    def test_create_complaint_success(self):

        userid = '1'
        response = self.client.post(
            f'/complaints/{userid}',
            json={
                "title": "Minha denúncia",
                "description": "Descrição da minha denúncia.",
                "address": "Endereço da Denúncia",
                "isAnonymous": False}
        )
        # Verifica se a resposta é 201 Created
        self.assertEqual(response.status_code, 201)

    def test_create_complaint_missing_title(self):
        userid = '1'
        response = self.client.post(
            f'/complaints/{userid}',
            json={
                "description": "Descrição da minha denúncia.",
                "address": "Endereço da Denúncia",
                "isAnonymous": False}
        )
        # Verifica se a resposta é 400 Bad Request
        self.assertEqual(response.status_code, 400)

    def test_create_complaint_missing_isanonymous(self):
        userid = '1'
        response = self.client.post(
            f'/complaints/{userid}',
            json={
                "title": "Título",
                "description": "Descrição da minha denúncia.",
                "address": "Endereço da Denúncia",
            }
        )
        # Verifica se a resposta é 400 Bad Request
        self.assertEqual(response.status_code, 400)

    @patch('app.posts.views.cursor')
    def test_get_complaints(self, mock_cursor):
        userid = '1'

        # Configura o retorno desejado para fetchall()
        mock_cursor.fetchall.return_value = [
            (1, 1, 'Title 1', 'Description 1', 'Address 1', False, 10, 5),
            (2, 2, 'Title 2', 'Description 2', 'Address 2', True, 5, 2)
        ]

        mock_cursor.fetchone.return_value = ("name", "photo")

        # Chama a rota usando o cliente de teste
        response = self.client.get(f'/complaints/{userid}')

        mock_cursor.fetchall.assert_called_once()

        mock_cursor.execute.assert_called_with(
            "SELECT name, photo FROM users WHERE id=?", ('1',))
        mock_cursor.fetchone.assert_called_once()

        # Verificar o status da resposta
        self.assertEqual(response.status_code, 200)

        # Verificar o conteúdo da resposta
        expected_response = {
            'complaints': [
                {
                    'id': 1,
                    'title': 'Title 1',
                    'description': 'Description 1',
                    'address': 'Address 1',
                    'likes': 10,
                    'unlikes': 5
                },
                {
                    'id': 2,
                    'title': 'Title 2',
                    'description': 'Description 2',
                    'address': 'Address 2',
                    'likes': 5,
                    'unlikes': 2
                }
            ],
            'header': {
                'name': 'name',
                'photo': 'photo'
            },
        }
        self.assertDictEqual(response.json, expected_response)

    @patch('app.posts.views.cursor')
    def test_likes_complaint1_equal_7(self, mock_cursor):
        # Configurar mocks para o cursor
        mock_cursor.fetchone.return_value = (7,)

        # Chama a rota usando o cliente de teste
        complaint_id = 1
        response = self.client.get(f'/complaints/{complaint_id}/likes')

        # Verifica chamadas ao banco de dados
        mock_cursor.execute.assert_called_with(
            "SELECT likes FROM complaints WHERE id = ?", (1,))
        mock_cursor.fetchone.assert_called_once()

        # Verifica resposta
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['likes'], 7)

    @patch('app.posts.views.cursor')
    def test_get_likes_complaint_not_found(self, mock_cursor):
        # Configurar mocks para o cursor
        mock_cursor.fetchone.return_value = None

        # Chama a rota usando o cliente de teste
        complaint_id = 5
        response = self.client.get(f'/complaints/{complaint_id}/likes')

        # Verifica chamadas ao banco de dados
        mock_cursor.execute.assert_called_with(
            "SELECT likes FROM complaints WHERE id = ?", (complaint_id,))
        mock_cursor.fetchone.assert_called_once()

        # Verifica resposta
        self.assertEqual(response.status_code, 404)

    @patch('app.posts.views.cursor')
    def test_unlikes_complaint1_equal_3(self, mock_cursor):
        # Mock para retorno do banco de dados
        mock_cursor.fetchone.return_value = (3,)

        # Chamar a função a ser testada
        complaint_id = 1
        response = self.client.get(f'/complaints/{complaint_id}/unlikes')

        # Verificar chamadas ao banco de dados
        mock_cursor.execute.assert_any_call(
            "SELECT unlikes FROM complaints WHERE id = ?", (complaint_id,))

        # Verificar resposta
        self.assertEqual(response.status_code, 200)
        # Retrieves number of likes of complaint 0
        self.assertEqual(response.json['unlikes'], 3)


if __name__ == '__main__':
    unittest.main()
