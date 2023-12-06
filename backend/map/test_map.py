import unittest
import tempfile
import json
from unittest.mock import patch
from map import app, read_users_from_file

class TestGeocodingApp(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()

    def tearDown(self):
        pass

    def test_geocode_valid_user(self):
        mock_users = [
            {"id": "user1", "address": "1600 Amphitheatre Pkwy, Mountain View, CA"},
            {"id": "user2", "address": "1 Hacker Way, Menlo Park, CA"},
            {"id": "user3", "address": "1355 Market St, San Francisco, CA"}
        ]

        with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_file:
            temp_file.write(json.dumps(mock_users))

        with patch('map.read_users_from_file', return_value=mock_users):
            response = self.app.post('/geocode', json={"id": "user1"})

        expected_result = {"latitude": 37.4217636, "longitude": -122.084614}
        self.assertEqual(response.get_json(), expected_result)

    def test_geocode_user_not_found(self):
        response = self.app.post('/geocode', json={"id": "nonexistent_user"})
        expected_result = {"message": "User not found or address not available"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 404)

    def test_reverse_geocode_invalid_request(self):
        response = self.app.post('/reverse_geocode', json={"latitude": 37.4217636})
        expected_result = {"message": "Invalid request"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 400)

    def test_geocode_invalid_request_missing_id(self):
        response = self.app.post('/geocode', json={"address": "1600 Amphitheatre Pkwy, Mountain View, CA"})
        expected_result = {"message": "Invalid request"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 400)

    def test_geocode_invalid_request_empty_data(self):
        response = self.app.post('/geocode', json={})
        expected_result = {"message": "Invalid request"}
        self.assertEqual(response.get_json(), expected_result)
        self.assertEqual(response.status_code, 400)

if __name__ == '__main__':
    unittest.main()