import unittest
import app
from unittest.mock import patch

class TestGeocodingApp(unittest.TestCase):

    def setUp(self):
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    @patch('app.map.views.cursor')
    def test_get_coordinates_address(self, mock_cursor):
        mock_cursor.fetchall.return_value = [
            "1600 Amphitheatre Pkwy, Mountain View, CA",
            "1 Hacker Way, Menlo Park, CA",
            "1355 Market St, San Francisco, CA"
        ]

        response = self.client.get("/geocode")

        mock_cursor.fetchall.assert_called_once()

        self.assertEqual(response.status_code, 200)


if __name__ == '__main__':
    unittest.main()
