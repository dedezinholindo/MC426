from flask import Flask, request, jsonify, make_response
import json
import uuid

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

# Route for updating user information (edit profile)
@app.route('/edit_profile', methods=['PUT'])
def edit_profile():
    user_data = request.json
    if not user_data:
        return jsonify({"message": "Invalid request"}), 400

    username = user_data.get("username")
    new_name = user_data.get("name")
    new_age = user_data.get("age")
    new_email = user_data.get("email")

    if not (username and new_name and new_age and new_email):
        return jsonify({"message": "Missing required fields"}), 400

    users = read_users_from_file()

    # Check if the username exists
    for user in users:
        if user['username'] == username:
            # Update user information
            user['name'] = new_name
            user['age'] = new_age
            user['email'] = new_email
            
            if not new_age.isdigit():
                return jsonify({"message": "Age must contain only numbers"}), 400

            # Write updated user information to file
            write_users_to_file(users)

            return jsonify({"message": "Profile updated successfully"}), 200

    return jsonify({"message": "User not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)
