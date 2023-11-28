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
    new_phone = user_data.get("phone")
    new_address = user_data.get("address")
    new_photo = user_data.get("photo")
    new_safety_number = user_data.get("safetyNumber")

    if not (username and new_name and new_age and new_email and new_phone and new_address and new_photo and new_safety_number):
        return jsonify({"message": "Missing required fields"}), 400
    
    
    # Check specific criteria for each field
    if not (1 <= len(new_name) <= 50):
        return jsonify({"message": "Name must be between 1 and 50 characters"}), 400

    if not new_email or '@' not in new_email or '.' not in new_email:
        return jsonify({"message": "Invalid email address"}), 400

    if not new_age.isdigit() or not (1 <= int(new_age) <= 150):
        return jsonify({"message": "Age must be a number between 1 and 150"}), 400

    if not new_phone.isdigit() or len(new_phone) != 11:
        return jsonify({"message": "Phone number must be an 11-digit number"}), 400

    if not new_safety_number.isdigit() or len(new_safety_number) != 11:
        return jsonify({"message": "Safety number must be an 11-digit number"}), 400

    if not new_address:
        return jsonify({"message": "Address is required"}), 400

    users = read_users_from_file() #change for database

    for user in users:
        if user['username'] == username:
            # Update user information
            user['name'] = new_name
            user['age'] = new_age
            user['email'] = new_email
            user['phone'] = new_phone
            user['address'] = new_address
            user['photo'] = new_photo
            user['safetyNumber'] = new_safety_number
            
            if not (new_age.isdigit() and new_phone.isdigit() and len(new_phone) == 11 and len(new_safety_number) == 11):
                return jsonify({"message": "Invalid age, phone, or safetyNumber format"}), 400

            # Write updated user information to file
            write_users_to_file(users)

            return jsonify({"message": "Profile updated successfully"}), 200

    return jsonify({"message": "User not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)
