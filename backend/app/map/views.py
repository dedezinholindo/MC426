import json
from flask import Blueprint, jsonify
from geopy.geocoders import Nominatim
import sqlite3

map_bp = Blueprint('map', __name__)
geolocator = Nominatim(user_agent="Press2Safe")

def setup_map_db():
    conn = sqlite3.connect('press2safe.db', check_same_thread=False)
    cursor = conn.cursor()

    return conn, cursor


conn, cursor = setup_map_db()

# Function to convert address to coordinates (geocoding)

def geocode_address(address):
    try:
        location = geolocator.geocode(address)
        return {"latitude": location.latitude, "longitude": location.longitude}
    except:
        return None

# Function to get map coordinates
def get_coordinates_address():
    cursor.execute( "SELECT address FROM complaints")

    return cursor.fetchall()


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
