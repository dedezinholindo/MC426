from flask import Flask, request, jsonify, make_response

import sqlite3
import uuid

app = Flask(__name__)

# Function to initialize the database
def init_db():
    conn = sqlite3.connect('press2safe.db')
    cursor = conn.cursor()

    # Create the users table if it doesn't exist
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            username TEXT NOT NULL UNIQUE,
            email TEXT NOT NULL,
            age INTEGER NOT NULL,
            phone TEXT NOT NULL,
            password TEXT NOT NULL,
            address TEXT NOT NULL,
            photo TEXT,
            safetyNumber TEXT
        )
    ''')

    conn.commit()
    conn.close()

# Initialize the database
init_db()

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

    required_fields = ["name", "username", "email", "age", "phone", "password", "address", "photo", "safetyNumber"]

    for field in required_fields:
        if (field not in user_data) or user_data[f'{field}'] == "":
            return jsonify({"message": f"Missing required fields"}), 400

    name = user_data.get("name")
    username = user_data.get("username")
    email = (user_data.get("email")).lower()
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
    
    if safety_number is not None and (not safety_number.isdigit() or len(safety_number) != 11):
        return jsonify({"message": "Safety number must be an 11-digit number"}), 400

    if not (8 <= len(password) <= 20):
        return jsonify({"message": "Password must be between 8 and 20 characters"}), 400

    if not address:
        return jsonify({"message": "Address is required"}), 400

    conn = sqlite3.connect('press2safe.db')
    cursor = conn.cursor()

    # Check if the username already exists
    cursor.execute('SELECT * FROM users WHERE username = ?', (username,))
    existing_user = cursor.fetchone()
    if existing_user:
        conn.close()
        return jsonify({"message": "Username already exists"}), 400

    # Generate a unique ID for the new user
    user_id = str(uuid.uuid4())

    cursor.execute('''
        INSERT INTO users (id, name, username, email, age, phone, password, address, photo, safetyNumber)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (user_id, name, username, email, age, phone, password, address, photo, safety_number))

    conn.commit()
    conn.close()

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

    conn = sqlite3.connect('press2safe.db')
    cursor = conn.cursor()

    # Check if the username and password match a registered user
    cursor.execute('SELECT * FROM users WHERE username = ? AND password = ?', (username, password))
    user = cursor.fetchone()

    conn.close()

    if user:
        response = make_response(jsonify({"message": "Authentication successful", "id": user[0]}), 200)
        response.set_cookie('username', username)
        return response

    return jsonify({"message": "Invalid username or password"}), 401

# Route for "Forget My Password" functionality
@app.route('/forget_password', methods=['POST'])
def forget_password():
    user_data = request.json
    if not user_data or 'email' not in user_data:
        return jsonify({"message": "Invalid request"}), 400

    email = (user_data.get("email")).lower()
    if not email or '@' not in email or '.' not in email:
        return jsonify({"message": "Invalid email address"}), 400

    conn = sqlite3.connect('press2safe.db')
    cursor = conn.cursor()

    # Check if the email exists
    cursor.execute('SELECT * FROM users WHERE email = ?', (email,))
    user = cursor.fetchone()

    if user:
        # Generate a unique token for password reset
        #reset_token = str(uuid.uuid4())

        # Save the reset token to the user's data
        #cursor.execute('UPDATE users SET reset_token = ? WHERE email = ?', (reset_token, email))
        #conn.commit()
        #conn.close()

        return jsonify({"message": "If your email exists in our database, the reset link was successfully sent"}), 200

    conn.close()
    return jsonify({"message": "Email not found"}), 404

if __name__ == '__main__':
    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 5000)),
        threaded=False,
        debug=True,
        )
