from flask import Flask, request, render_template_string, escape

app = Flask(__name__)

@app.route('/')
def index():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seu Site</title>
        <link rel="stylesheet" type="text/css" href="{{ url_for('static', filename='styles.css') }}">
    </head>
    <body>
        <div class="navbar">
            <div class="container">
                <h1>Seu Site</h1>
                <ul>
                    <li><a href="/">Página Inicial</a></li>
                    <li><a href="/xss">XSS</a></li>
                    <li><a href="/injection">Injeção</a></li>
                    <li><a href="/auth">Autenticação</a></li>
                    <li><a href="/directory_traversal">Travessia de Diretório</a></li>
                    <li><a href="/insecure_deserialization">Deserialização Insegura</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <h2>Página Inicial</h2>
            <p>Bem-vindo ao nosso site!</p>
        </div>
    </body>
    </html>
    """

@app.route('/xss')
def xss():
    input_usuario = request.args.get('input')
    input_usuario = escape(input_usuario)  # Escapa qualquer entrada do usuário para evitar XSS
    template = f"<p>{input_usuario}</p>"
    return template

@app.route('/injection')
def injection():
    user_input = request.args.get('input')
    try:
        result = eval(user_input)
        return f"Resultado: {result}"
    except Exception as e:
        return f"Erro: {str(e)}"

@app.route('/auth', methods=['GET', 'POST'])
def auth():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        if username == 'admin' and password == 'admin123':
            return "Autenticado como admin"
        else:
            return "Falha na autenticação"

    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Autenticação</title>
        <link rel="stylesheet" type="text/css" href="{{ url_for('static', filename='styles.css') }}">
    </head>
    <body>
        <div class="container">
            <h2>Autenticação</h2>
            <form method="post">
                <input type="text" name="username" placeholder="Usuário"><br>
                <input type="password" name="password" placeholder="Senha"><br>
                <input type="submit" value="Login">
            </form>
        </div>
    </body>
    </html>
    '''

@app.route('/directory_traversal')
def directory_traversal():
    # Adicione verificação de caminho de arquivo seguro aqui
    file_path = request.args.get('file')
    if ".." in file_path:
        return "Acesso não autorizado"
    
    try:
        with open(file_path, 'r') as file:
            content = file.read()
        return content
    except FileNotFoundError:
        return "Arquivo não encontrado"

@app.route('/insecure_deserialization', methods=['POST', 'GET'])
def insecure_deserialization():
    if request.method == 'POST':
        import pickle
        serialized_data = request.form.get('data')
        try:
            obj = pickle.loads(serialized_data)
            return f"Deserializado: {obj}"
        except Exception as e:
            return f"Erro ao desserializar: {str(e)}"

    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Deserialização Insegura</title>
        <link rel="stylesheet" type="text/css" href="{{ url_for('static', filename='styles.css') }}">
    </head>
    <body>
        <div class="container">
            <h2>Deserialização Insegura</h2>
            <form method="post">
                <textarea name="data" placeholder="Dados serializados"></textarea><br>
                <input type="submit" value="Deserializar">
            </form>
        </div>
    </body>
    </html>
    '''

if __name__ == '__main__':
    app.run(debug=True)
