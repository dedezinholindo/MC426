from flask import Flask, request, jsonify, make_response
import logging
import json
import os

app = Flask(__name__)
gunicorn_info_logger = logging.getLogger("gunicorn.info")
app.logger.handlers.extend(gunicorn_info_logger.handlers)
app.logger.setLevel(logging.INFO)

# Function to read and write user data to a local text file
def read_users_from_file():
    try:
        with open("users.txt", "r") as file:
            users = json.load(file)
    except FileNotFoundError:
        users = []
    return users

def write_users_to_file(users):
    with open("users.txt", "w") as file:
        json.dump(users, file)

@app.route("/", methods=["GET"])
def healthcheck():
    """
    If the route is working, returns a 'healthy!' string.
    """
    return "healthy!"

# Route for user registration (registration)
@app.route('/registration', methods=['POST'])
def registration():
    user_data = request.json
    if not user_data:
        return jsonify({"message": "Invalid request"}), 400

    username = user_data.get("username")
    password = user_data.get("password")
    name = user_data.get("name")
    age = user_data.get("age")
    email = user_data.get("email")

    if not (username and password and name and age and email):
        return jsonify({"message": "Missing required fields"}), 400

    if not (8 <= len(password) <= 20):
        return jsonify({"message": "Password must be between 8 and 20 characters"}), 400

    if not age.isdigit():
        return jsonify({"message": "Age must contain only numbers"}), 400

    users = read_users_from_file()

    # Check if the username already exists
    for user in users:
        if user['username'] == username:
            return jsonify({"message": "Username already exists"}), 400

    new_user = {
        "username": username,
        "password": password,
        "name": name,
        "age": age,
        "email": email
    }

    users.append(new_user)
    write_users_to_file(users)

    response = make_response(jsonify({"message": "User registered successfully"}), 201)
    response.set_cookie('username', username)
    return response

# Route for user login (authentication)
@app.route('/login', methods=['POST'])
def login():
    user_data = request.json
    if not user_data:
        return jsonify({"message": "Invalid request"}), 400

    username = user_data.get("username")
    password = user_data.get("password")

    if not (username and password):
        return jsonify({"message": "Missing required fields"}), 400

    users = read_users_from_file()

    # Check if the username and password match a registered user
    for user in users:
        if user['username'] == username and user['password'] == password:
            response = make_response(jsonify({"message": "Authentication successful"}), 200)
            response.set_cookie('username', username)
            return response

    return jsonify({"message": "Invalid username or password"}), 401

if __name__ == '__main__':
    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 4010)),
        threaded=False,
        debug=True,
        )
