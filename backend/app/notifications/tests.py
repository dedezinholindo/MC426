import unittest
from unittest.mock import patch, MagicMock
import app

class NotificationsBlueprintTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    @patch('app.posts.views.db.cursor')
    def test_get_notifications_route(self, mock_cursor):
        # Simula a execução da consulta ao banco de dados
        mock_cursor.execute.return_value = MagicMock()
        mock_cursor.fetchall.return_value = [(1, 'Title', 'Description', 'Topic', True)]

        response = self.client.get('/notifications/1')

        # Verifica se a resposta tem o status code esperado
        self.assertEqual(response.status_code, 200)

    @patch('app.posts.views.db.cursor')
    def test_setup_notifications_route_success(self, mock_cursor):
        # Simula a execução da consulta ao banco de dados
        mock_cursor.execute.return_value = MagicMock()
        mock_cursor.rowcount = 1  # Simula uma linha afetada

        data = {'id': 1, 'user_id': '1', 'is_active': True}
        response = self.client.post('/notifications/', json=data)

        # Verifica se a resposta tem o status code esperado
        self.assertEqual(response.status_code, 200)

    @patch('app.posts.views.db.cursor')
    def test_setup_notifications_route_notification_not_found(self, mock_cursor):
        # Simula a execução da consulta ao banco de dados
        mock_cursor.execute.return_value = MagicMock()
        mock_cursor.rowcount = 0  # Simula nenhuma linha afetada

        data = {'id': 999, 'user_id': '1', 'is_active': True}
        response = self.client.post('/notifications/', json=data)

        # Verifica se a resposta tem o status code esperado
        self.assertEqual(response.status_code, 404)

if __name__ == '__main__':
    unittest.main()