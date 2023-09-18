import requests
import json

# Defina a URL do seu servidor Flask
BASE_URL = 'http://localhost:5000'  # Atualize isso com a URL do seu servidor Flask

def cadastro():
    print("Cadastro")
    username = input("Nome de usuário: ")
    senha = input("Senha: ")
    nome = input("Nome: ")
    idade = input("Idade: ")
    email = input("Email: ")

    dados_cadastro = {
        "username": username,
        "senha": senha,
        "nome": nome,
        "idade": idade,
        "email": email
    }

    resposta = requests.post(f"{BASE_URL}/cadastro", json=dados_cadastro)

    if resposta.status_code == 201:
        print("Usuário cadastrado com sucesso.")
    else:
        print(f"Erro: {resposta.status_code} - {resposta.json()['mensagem']}")

def login():
    print("Login")
    username = input("Nome de usuário: ")
    senha = input("Senha: ")

    dados_login = {
        "username": username,
        "senha": senha
    }

    resposta = requests.post(f"{BASE_URL}/login", json=dados_login)

    if resposta.status_code == 200:
        print("Autenticação bem-sucedida.")
    else:
        print(f"Erro: {resposta.status_code} - {resposta.json()['mensagem']}")

if __name__ == "__main__":
    while True:
        print("\nOpções:")
        print("1. Cadastro")
        print("2. Login")
        print("3. Sair")

        escolha = input("Escolha uma opção: ")

        if escolha == "1":
            cadastro()
        elif escolha == "2":
            login()
        elif escolha == "3":
            break
        else:
            print("Escolha inválida. Por favor, escolha uma opção válida.")
