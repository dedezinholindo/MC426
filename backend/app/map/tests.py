import unittest
import tempfile
import json
from unittest.mock import patch
from app.map import get_coordinates_address
import app


class TestGeocodingApp(unittest.TestCase):

    def setUp(self):
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    def test_save_coordinates(self):
        mock_coordinates = [
            {"id": "existing_user", "latitude": 37.7749, "longitude": -122.4194}
        ]

        with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_file:
            temp_file.write(json.dumps(mock_coordinates))

        with patch('map.read_coordinates_from_file', return_value=mock_coordinates):
            response = self.client.post(
                '/save_coordinates', json={"id": "existing_user", "latitude": 40.7128, "longitude": -74.0060})

        expected_result = {"message": "Coordinates saved successfully"}
        self.assertEqual(response.get_json(), expected_result)

    def test_geocode_coordinates_not_found(self):
        response = self.client.post(
            '/geocode', json={"id": "nonexistent_user"})
        expected_result = {
            "message": "Coordinates not found or address not available"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 404)

    def test_reverse_geocode_invalid_request(self):
        response = self.client.post(
            '/reverse_geocode', json={"latitude": 37.4217636})
        expected_result = {"message": "Invalid request"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 400)

    def test_geocode_invalid_request_missing_id(self):
        response = self.client.post(
            '/geocode', json={"address": "1600 Amphitheatre Pkwy, Mountain View, CA"})
        expected_result = {"message": "Invalid request"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 400)

    def test_geocode_invalid_request_empty_data(self):
        response = self.client.post('/geocode', json={})
        expected_result = {"message": "Invalid request"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 400)

    def test_save_coordinates(self):
        response = self.client.post(
            '/save_coordinates', json={"id": "new_user", "latitude": 40.7128, "longitude": -74.0060})
        expected_result = {"message": "Coordinates saved successfully"}
        self.assertEqual(response.get_json(), expected_result)

    def test_get_coordinates(self):
        mock_coordinates = [
            {"id": "user1", "latitude": 37.4217636, "longitude": -122.084614},
            {"id": "user2", "latitude": 37.4838, "longitude": -122.1503},
            {"id": "user3", "latitude": 37.7749, "longitude": -122.4194}
        ]

        with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_file:
            temp_file.write(json.dumps(mock_coordinates))

        with patch('app.map.views.read_coordinates_from_file', return_value=mock_coordinates):
            response = self.client.get('/get_coordinates')

        self.assertEqual(response.get_json(), mock_coordinates)

    def test_get_coordinates_address(self):
        mock_coordinates = [
            {"id": "user1", "address": "1600 Amphitheatre Pkwy, Mountain View, CA"},
            {"id": "user2", "address": "1 Hacker Way, Menlo Park, CA"},
            {"id": "user3", "address": "1355 Market St, San Francisco, CA"}
        ]

        with patch('app.map.views.read_coordinates_from_file', return_value=mock_coordinates):
            address = get_coordinates_address("user2")
        
        expected_address = "1 Hacker Way, Menlo Park, CA"
        self.assertEqual(address, expected_address)


if __name__ == '__main__':
    unittest.main()
