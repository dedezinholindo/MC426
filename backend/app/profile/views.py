from flask import Blueprint, request, jsonify
import sqlite3

profile_bp = Blueprint('profile', __name__)

# Function to update user information in the database
def update_user(user_id, new_name, new_phone, new_address, new_photo, new_safety_number):
    conn = sqlite3.connect("press2safe.db")
    cursor = conn.cursor()

    cursor.execute('''
        UPDATE users
        SET name=?, phone=?, address=?, photo=?, safetyNumber=?
        WHERE id=?
    ''', (new_name, new_phone, new_address, new_photo, new_safety_number, user_id))

    conn.commit()
    conn.close()

# Function to retrieve user information from the database by user ID
def get_user_by_id(user_id):
    conn = sqlite3.connect("press2safe.db")
    cursor = conn.cursor()

    cursor.execute('''
        SELECT * FROM users WHERE id=?
    ''', (user_id,))

    user = cursor.fetchone()

    conn.close()

    return user

# Route for updating user information (edit profile)
@app.route('/profile/<string:user_id>', methods=['POST'])
def edit_profile(user_id):
    user_data = request.json
    if not user_data:
        return jsonify({"message": "Invalid request"}), 400

    new_name = user_data.get("name")
    new_phone = user_data.get("phone")
    new_address = user_data.get("address")
    new_photo = user_data.get("photo")
    new_safety_number = user_data.get("safetyNumber")

    if not (user_id and new_name and new_phone and new_address and new_photo and new_safety_number):
        return jsonify({"message": "Missing required fields"}), 400

    # Check specific criteria for each field
    if not (1 <= len(new_name) <= 50):
        return jsonify({"message": "Name must be between 1 and 50 characters"}), 400

    if not new_phone.isdigit() or len(new_phone) != 11:
        return jsonify({"message": "Phone number must be an 11-digit number"}), 400

    if new_safety_number is not None and (not new_safety_number.isdigit() or len(new_safety_number) != 11):
        return jsonify({"message": "Safety number must be an 11-digit number"}), 400

    if not new_address:
        return jsonify({"message": "Address is required"}), 400

    user = get_user_by_id(user_id)

    if user:
        # Do not allow changing username or email
        update_user(user_id, new_name, new_phone, new_address, new_photo, new_safety_number)
        return jsonify({"message": "Profile updated successfully"}), 200
    else:
        return jsonify({"message": "User not found"}), 404

# Route for getting user profile by id
@app.route('/profile/<string:user_id>', methods=['GET'])
def get_profile(user_id):
    if not user_id:
        return jsonify({"message": "Missing required field: id"}), 400

    user = get_user_by_id(user_id)

    if user:
        user_info = {
            "name": user[1],
            "username": user[2],
            "email": user[3],
            "age": user[4],
            "phone": user[5],
            "address": user[7],
            "photo": user[8],
            "safetyNumber": user[9],
        }
        return jsonify(user_info), 200
    else:
        return jsonify({"message": "User not found"}), 404

if __name__ == '__main__':
    print(profile_bp)
