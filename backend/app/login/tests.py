import unittest
import app

class FlaskAppTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    def register_user(self, username, password, name, age, email):
        user_data = {
            "username": username,
            "password": password,
            "name": name,
            "age": age,
            "email": email
        }
        response = self.client.post('/registration', json=user_data)
        return response

    def login_user(self, username, password):
        user_data = {
            "username": username,
            "password": password
        }
        response = self.client.post('/login', json=user_data)
        return response

    def test_registration(self):
        response = self.register_user("testuser1", "password123", "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

        response = self.register_user("", "password123", "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Missing required fields", response.data)


    def test_login(self):
        self.register_user("testuser2", "password123", "Test User", "25", "test@example.com")
        response = self.login_user("testuser2", "password123")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Authentication successful", response.data)

        response = self.login_user("invaliduser", "password123")
        self.assertEqual(response.status_code, 401)
        self.assertIn(b"Invalid username or password", response.data)

        response = self.login_user("testuser2", "invalidpassword")
        self.assertEqual(response.status_code, 401)
        self.assertIn(b"Invalid username or password", response.data)

    def test_registration_invalid_age(self):
        response = self.register_user("testuser3", "password123", "Test User", "invalid_age", "test@example.com")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Age must contain only numbers", response.data)

    def test_registration_short_password(self):
        response = self.register_user("testuser4", "123", "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Password must be between 8 and 20 characters", response.data)

    def test_registration_long_password(self):
        long_password = "a" * 21
        response = self.register_user("testuser5", long_password, "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Password must be between 8 and 20 characters", response.data)

    def test_registration_duplicate_username(self):
        self.register_user("testuser6", "password123", "Test User", "25", "test@example.com")
        response = self.register_user("testuser6", "anotherpassword", "Another User", "30", "another@example.com")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Username already exists", response.data)

    def test_login_missing_username(self):
        response = self.login_user("", "password123")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Missing required fields", response.data)

    def test_login_missing_password(self):
        response = self.login_user("testuser7", "")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Missing required fields", response.data)

    def test_login_nonexistent_username(self):
        response = self.login_user("nonexistentuser", "password123")
        self.assertEqual(response.status_code, 401)
        self.assertIn(b"Invalid username or password", response.data)

    def test_login_incorrect_password(self):
        self.register_user("testuser8", "password123", "Test User", "25", "test@example.com")
        response = self.login_user("testuser8", "incorrectpassword")
        self.assertEqual(response.status_code, 401)
        self.assertIn(b"Invalid username or password", response.data)

    def test_registration_valid_data(self):
        response = self.register_user("testuser9", "password123", "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

    def test_login_valid_credentials(self):
        self.register_user("testuser10", "password123", "Test User", "25", "test@example.com")
        response = self.login_user("testuser10", "password123")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Authentication successful", response.data)

    def test_registration_maximum_password_length(self):
        long_password = "a" * 20
        response = self.register_user("testuser11", long_password, "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

    def test_registration_minimum_age(self):
        response = self.register_user("testuser12", "password123", "Test User", "0", "test@example.com")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

    def test_login_maximum_username_length(self):
        long_username = "a" * 255
        response = self.register_user(long_username, "password123", "Test User", "25", "test@example.com")
        self.assertEqual(response.status_code, 201)
        response = self.login_user(long_username, "password123")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Authentication successful", response.data)


if __name__ == '__main__':
    unittest.main()




