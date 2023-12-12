import json
from flask import Blueprint, request, jsonify
from geopy.geocoders import Nominatim

map_bp = Blueprint('map', __name__)
geolocator = Nominatim(user_agent="Press2Safe")

# Function to convert address to coordinates (geocoding)


def geocode_address(address):
    try:
        location = geolocator.geocode(address)
        return {"latitude": location.latitude, "longitude": location.longitude}
    except:
        return {"message": "Address not found"}

# Function to convert coordinates to address (reverse geocoding)


def reverse_geocode_coordinates(latitude, longitude):
    location = geolocator.reverse((latitude, longitude), language='en')
    if location:
        return {"address": location.address}
    else:
        return {"message": "Coordinates not found"}

# Function to read user data from a local JSON file


def read_coordinates_from_file():
    try:
        with open("coordinates.txt", "r") as file:
            coordinates = json.load(file)
    except FileNotFoundError:
        coordinates = []
    return coordinates

# Function to save user data to a local JSON file


def save_coordinates_to_file(id, latitude, longitude):
    # Load existing coordinates or create an empty list
    coordinates = read_coordinates_from_file()

    # Add the new coordinates to the list
    new_coord = {"id": id, "latitude": latitude, "longitude": longitude}
    coordinates.append(new_coord)

    # Save the updated list to the file
    with open("coordinates.txt", "w") as file:
        json.dump(coordinates, file)

    return {"message": "Coordinates saved successfully"}


def get_coordinates_address(id):
    coordinates = read_coordinates_from_file()
    for coord in coordinates:
        if coord['id'] == id:
            return coord.get("address")
    return None

# Route for geocoding (address to coordinates)


@map_bp.route('/geocode', methods=['POST'])
def geocode():
    data = request.json
    if not data or 'id' not in data:
        return jsonify({"message": "Invalid request"}), 400

    id = data['id']
    coordinates_address = get_coordinates_address(id)

    if not coordinates_address:
        return jsonify({"message": "Coordinates not found or address not available"}), 404

    result = geocode_address(coordinates_address)
    return jsonify(result)

# Route for reverse geocoding (coordinates to address)


@map_bp.route('/reverse_geocode', methods=['POST'])
def reverse_geocode():
    data = request.json
    if not data or 'latitude' not in data or 'longitude' not in data:
        return jsonify({"message": "Invalid request"}), 400

    latitude = data['latitude']
    longitude = data['longitude']
    result = reverse_geocode_coordinates(latitude, longitude)

    return jsonify(result)

# Route for saving user data


@map_bp.route('/save_coordinates', methods=['POST'])
def save_coordinates():
    data = request.json
    if not data or 'id' not in data or 'latitude' not in data or 'longitude' not in data:
        return jsonify({"message": "Invalid request"}), 400

    id = data['id']
    latitude = data['latitude']
    longitude = data['longitude']

    result = save_coordinates_to_file(id, latitude, longitude)
    return jsonify(result)

# Route for getting the list of users


@map_bp.route('/get_coordinates', methods=['GET'])
def get_coordinates():
    coordinates = read_coordinates_from_file()
    return jsonify(coordinates)


if __name__ == '__main__':
    print(map_bp)
