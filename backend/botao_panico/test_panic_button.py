import unittest
import json
from panic_button import app

# Mock data for testing
valid_data = {'id': '123'}
invalid_data = {}

class TestPanicButton(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_valid_request(self):
        response = self.app.post('/panic_button', json=valid_data)
        data = json.loads(response.data.decode('utf-8'))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data['message'], 'Panic button activated. Police number: 190.')

    def test_missing_id(self):
        response = self.app.post('/panic_button', json=invalid_data)
        data = json.loads(response.data.decode('utf-8'))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data['error'], "Missing 'id' in the request body.")

    def test_invalid_method(self):
        response = self.app.get('/panic_button')
        self.assertEqual(response.status_code, 405)

        # Check for the presence of the 'error' key without decoding JSON
        self.assertIn('Method Not Allowed', response.data.decode('utf-8'))


    def test_large_id(self):
        large_data = {'id': '12345678901234567890123456789012345678901234567890'}
        response = self.app.post('/panic_button', json=large_data)
        data = json.loads(response.data.decode('utf-8'))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data['message'], 'Panic button activated. Police number: 190.')


if __name__ == '__main__':
    unittest.main()
