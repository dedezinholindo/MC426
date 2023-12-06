import json
from flask import Flask, request, jsonify, make_response
from geopy.geocoders import Nominatim

app = Flask(__name__)
geolocator = Nominatim(user_agent="Press2Safe")

# Function to convert address to coordinates (geocoding)
def geocode_address(address):
    location = geolocator.geocode(address)
    if location:
        return {"latitude": location.latitude, "longitude": location.longitude}
    else:
        return {"message": "Address not found"}

# Function to convert coordinates to address (reverse geocoding)
def reverse_geocode_coordinates(latitude, longitude):
    location = geolocator.reverse((latitude, longitude), language='en')
    if location:
        return {"address": location.address}
    else:
        return {"message": "Coordinates not found"}
    
# Function to read and write user data to a local text file
def read_users_from_file():
    try:
        with open("users.txt", "r") as file:
            users = json.load(file)
    except FileNotFoundError:
        users = []
    return users

def get_user_address(username):
    users = read_users_from_file()
    for user in users:
        if user['username'] == username:
            return user.get("address")
    return None

# Route for geocoding (address to coordinates)
@app.route('/geocode', methods=['POST'])
def geocode():
    data = request.json
    if not data or 'username' not in data:
        return jsonify({"message": "Invalid request"}), 400

    username = data['username']
    user_address = get_user_address(username)

    if not user_address:
        return jsonify({"message": "User not found or address not available"}), 404

    result = geocode_address(user_address)
    return jsonify(result)

# Route for reverse geocoding (coordinates to address)
@app.route('/reverse_geocode', methods=['POST'])
def reverse_geocode():
    data = request.json
    if not data or 'latitude' not in data or 'longitude' not in data:
        return jsonify({"message": "Invalid request"}), 400

    latitude = data['latitude']
    longitude = data['longitude']
    result = reverse_geocode_coordinates(latitude, longitude)

    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True)