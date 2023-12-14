import unittest
from unittest.mock import MagicMock, patch
import app


class HomeBlueprintTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    @patch('app.posts.views.db.cursor')
    @patch('app.map.views.geocode_address')
    def test_get_home_successful_response(self, mock_geocode_address, mock_cursor):
        # Simula o retorno da função geocode_address
        mock_geocode_address.return_value = {'latitude': 123, 'longitude': 456}

        # Simula a consulta ao banco de dados
        mock_cursor.execute = MagicMock()
        mock_cursor.fetchone = MagicMock(return_value=('John Doe', 'photo.jpg', 'Avenida Santa Isabel, Campinas', 42))

        response = self.client.get('/home/1/')

        # Verifica se a resposta tem o status code esperado
        self.assertEqual(response.status_code, 200)

    @patch('app.posts.views.db.cursor')
    @patch('app.map.views.geocode_address')
    def test_get_home_user_not_found(self, mock_geocode_address, mock_cursor):
        # Simula o retorno da função geocode_address
        mock_geocode_address.return_value = {'latitude': 123, 'longitude': 456}

        # Simula a consulta ao banco de dados retornando None
        mock_cursor.execute = MagicMock()
        mock_cursor.fetchone = MagicMock(return_value=None)


        response = self.client.get('/home/1/')

        # Verifica se a resposta tem o status code esperado
        self.assertEqual(response.status_code, 404)

if __name__ == '__main__':
    unittest.main()