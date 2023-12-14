import json
from flask import Blueprint, jsonify
from geopy.geocoders import Nominatim
from ..database import DatabaseManager

map_bp = Blueprint('map', __name__)
geolocator = Nominatim(user_agent="Press2Safe")
db = DatabaseManager()

# Function to convert address to coordinates (geocoding)

def geocode_address(address):
    try:
        location = geolocator.geocode(address)
        return {"latitude": location.latitude, "longitude": location.longitude}
    except:
        return None

# Function to get map coordinates
def get_coordinates_address():
    db.cursor.execute( "SELECT address FROM complaints")

    return db.cursor.fetchall()


# Route for getting the list of coordinates

@map_bp.route('/geocode', methods=['GET'])
def get_coordinates():
    coordinates = get_coordinates_address()

    coordinates = [
        result for c in coordinates if (result := geocode_address(c)) is not None
    ]

    return jsonify(coordinates)


if __name__ == '__main__':
    print(map_bp)
