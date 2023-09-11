from flask import Flask, request, jsonify, make_response
import json

app = Flask(__name__)

# Função para ler e escrever dados de usuário em um arquivo de texto local
def ler_usuarios_do_arquivo():
    try:
        with open("usuarios.txt", "r") as arquivo:
            usuarios = json.load(arquivo)
    except FileNotFoundError:
        usuarios = []
    return usuarios

def escrever_usuarios_no_arquivo(usuarios):
    with open("usuarios.txt", "w") as arquivo:
        json.dump(usuarios, arquivo)

# Rota para o registro de usuário (cadastro)
@app.route('/cadastro', methods=['POST'])
def cadastro():
    dados_usuario = request.json
    if not dados_usuario:
        return jsonify({"mensagem": "Requisição inválida"}), 400

    username = dados_usuario.get("username")
    senha = dados_usuario.get("senha")
    nome = dados_usuario.get("nome")
    idade = dados_usuario.get("idade")
    email = dados_usuario.get("email")

    if not (username and senha and nome and idade and email):
        return jsonify({"mensagem": "Campos obrigatórios faltando"}), 400

    if not (8 <= len(senha) <= 20):
        return jsonify({"mensagem": "A senha deve ter entre 8 e 20 caracteres"}), 400

    if not idade.isdigit():
        return jsonify({"mensagem": "A idade deve conter apenas números"}), 400

    usuarios = ler_usuarios_do_arquivo()

    # Verificar se o nome de usuário já existe
    for usuario in usuarios:
        if usuario['username'] == username:
            return jsonify({"mensagem": "Nome de usuário já existe"}), 400

    novo_usuario = {
        "username": username,
        "senha": senha,
        "nome": nome,
        "idade": idade,
        "email": email
    }

    usuarios.append(novo_usuario)
    escrever_usuarios_no_arquivo(usuarios)

    resposta = make_response(jsonify({"mensagem": "Usuário cadastrado com sucesso"}), 201)
    resposta.set_cookie('username', username)
    return resposta

# Rota para o login de usuário (autenticação)
@app.route('/login', methods=['POST'])
def login():
    dados_usuario = request.json
    if not dados_usuario:
        return jsonify({"mensagem": "Requisição inválida"}), 400

    username = dados_usuario.get("username")
    senha = dados_usuario.get("senha")

    if not (username and senha):
        return jsonify({"mensagem": "Campos obrigatórios faltando"}), 400

    usuarios = ler_usuarios_do_arquivo()

    # Verificar se o nome de usuário e senha correspondem a um usuário registrado
    for usuario in usuarios:
        if usuario['username'] == username and usuario['senha'] == senha:
            resposta = make_response(jsonify({"mensagem": "Autenticação bem-sucedida"}), 200)
            resposta.set_cookie('username', username)
            return resposta

    return jsonify({"mensagem": "Nome de usuário ou senha inválidos"}), 401

if __name__ == '__main__':
    app.run(debug=True)
