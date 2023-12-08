import unittest
import json
from login_registration import app

class AppTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def tearDown(self):
        pass

    def test_registration_success(self):
        # Test successful user registration
        data = {
            "name": "John Doe",
            "username": "john_doe",
            "email": "john.doe@example.com",
            "age": "25",
            "phone": "12345678901",
            "password": "securepassword",
            "address": "123 Main St",
            "photo": "profile.jpg",
            "safetyNumber": "98765432101"
        }

        response = self.app.post('/registration', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 201)
        self.assertIn("User registered successfully", result["message"])

    def test_registration_missing_fields(self):
        # Test registration with missing required fields
        data = {
            "name": "John Doe",
            "email": "john.doe@example.com",
            "age": "25",
            "phone": "12345678901",
            "password": "securepassword",
            "address": "123 Main St",
            "photo": "profile.jpg",
            "safetyNumber": "98765432101"
        }

        response = self.app.post('/registration', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 400)
        self.assertIn("Missing required fields", result["message"])

    def test_login_success(self):
        # Test successful user login
        data = {
            "username": "john_doe",
            "password": "securepassword"
        }

        response = self.app.post('/login', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 200)
        self.assertIn("Authentication successful", result["message"])

    def test_login_invalid_credentials(self):
        # Test login with invalid credentials
        data = {
            "username": "john_doe",
            "password": "wrong_password"
        }

        response = self.app.post('/login', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 401)
        self.assertIn("Invalid username or password", result["message"])

    def test_forget_password_success(self):
        # Test successful "Forget My Password" functionality
        data = {
            "email": "john.doe@example.com"
        }

        response = self.app.post('/forget_password', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 200)
        self.assertIn("reset link was successfully sent", result["message"])

    def test_forget_password_invalid_email(self):
        # Test "Forget My Password" with an invalid email
        data = {
            "email": "invalid_email"
        }

        response = self.app.post('/forget_password', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 400)
        self.assertIn("Invalid email address", result["message"])

    def test_forget_password_missing_email(self):
        # Test "Forget My Password" with missing email
        data = {}

        response = self.app.post('/forget_password', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 400)
        self.assertIn("Invalid request", result["message"])

    def test_forget_password_email_not_found(self):
        # Test "Forget My Password" with an email that is not in the database
        data = {
            "email": "nonexistent_email@example.com"
        }

        response = self.app.post('/forget_password', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 404)
        self.assertIn("Email not found", result["message"])

    def test_forget_password_invalid_request(self):
        # Test "Forget My Password" with an invalid request (missing email key)
        data = {
            "invalid_key": "john.doe@example.com"
        }

        response = self.app.post('/forget_password', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 400)
        self.assertIn("Invalid request", result["message"])

    def test_forget_password_success_case_insensitive_email(self):
        # Test successful "Forget My Password" with case-insensitive email
        data = {
            "email": "John.Doe@example.com"
        }

        response = self.app.post('/forget_password', json=data)
        result = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 200)
        self.assertIn("reset link was successfully sent", result["message"])

if __name__ == '__main__':
    unittest.main()
