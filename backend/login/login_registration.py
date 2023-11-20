from flask import Flask, request, jsonify, make_response
import json
import uuid  # Import the UUID module

app = Flask(__name__)

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

# Route for user registration (registration)
@app.route('/registration', methods=['POST'])
def registration():
    user_data = request.json
    if not user_data:
        return jsonify({"message": "Invalid request"}), 400

    required_fields = ["name", "username", "email", "age", "phone", "password", "address", "photo", "safetyNumber"]

    for field in required_fields:
        if (field not in user_data) or user_data[f'{field}'] == "":
            return jsonify({"message": f"Missing required fields"}), 400

    name = user_data.get("name")
    username = user_data.get("username")
    email = user_data.get("email")
    age = user_data.get("age")
    phone = user_data.get("phone")
    password = user_data.get("password")
    address = user_data.get("address")
    photo = user_data.get("photo")
    safety_number = user_data.get("safetyNumber")

    # Check specific criteria for each field
    if not (1 <= len(name) <= 50):
        return jsonify({"message": "Name must be between 1 and 50 characters"}), 400

    if not (3 <= len(username) <= 20):
        return jsonify({"message": "Username must be between 3 and 20 characters"}), 400

    if not email or '@' not in email or '.' not in email:
        return jsonify({"message": "Invalid email address"}), 400

    if not age.isdigit() or not (1 <= int(age) <= 150):
        return jsonify({"message": "Age must be a number between 1 and 150"}), 400

    if not phone.isdigit() or len(phone) != 11:
        return jsonify({"message": "Phone number must be an 11-digit number"}), 400
    
    if not safety_number.isdigit() or len(safety_number) != 11:
        return jsonify({"message": "Safety number must be an 11-digit number"}), 400

    if not (8 <= len(password) <= 20):
        return jsonify({"message": "Password must be between 8 and 20 characters"}), 400

    if not address:
        return jsonify({"message": "Address is required"}), 400

    users = read_users_from_file() #change this for database

    # Check if the username already exists
    for user in users:
        if user['username'] == username:
            return jsonify({"message": "Username already exists"}), 400

    # Generate a unique ID for the new user
    user_id = str(uuid.uuid4())

    new_user = {
        "id": user_id,
        "name": name,
        "username": username,
        "email": email,
        "age": age,
        "phone": phone,
        "password": password,
        "address": address,
        "photo": photo,
        "safetyNumber": safety_number
    }

    users.append(new_user)
    write_users_to_file(users)

    response = make_response(jsonify({"message": "User registered successfully", "id": user_id}), 201)
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
            response = make_response(jsonify({"message": "Authentication successful", "id": user['id']}), 200)
            response.set_cookie('username', username)
            return response

    return jsonify({"message": "Invalid username or password"}), 401

if __name__ == '__main__':
    app.run(debug=True)
