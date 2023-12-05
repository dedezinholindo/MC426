import unittest
from login_registration import app 

class FlaskAppTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def register_user(self, username, password, name, age, email, phone, address, photo, safety_number):
        user_data = {
            "username": username,
            "password": password,
            "name": name,
            "age": age,
            "email": email,
            "phone": phone,
            "address": address,
            "photo": photo,
            "safetyNumber": safety_number
        }
        response = self.app.post('/registration', json=user_data)
        return response

    def login_user(self, username, password):
        user_data = {
            "username": username,
            "password": password
        }
        response = self.app.post('/login', json=user_data)
        return response

    def test_registration(self):
        # Valid registration
        response = self.register_user("testuser1", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

        # Missing required fields
        response = self.register_user("", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Missing required fields", response.data)

        # Invalid phone number (less than 11 digits)
        response = self.register_user("testuser2", "password123", "Test User", "25", "test@example.com", "123", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Phone number must be an 11-digit number", response.data)

        # Invalid safetyNumber (less than 11 digits)
        response = self.register_user("testuser3", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "123")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Safety number must be an 11-digit number", response.data)

        # Duplicate username
        self.register_user("testuser4", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        response = self.register_user("testuser4", "anotherpassword", "Another User", "30", "another@example.com", "98765432109", "Another Address", "another.jpg", "78901234567")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Username already exists", response.data)

        # Invalid email format
        response = self.register_user("testuser5", "password123", "Test User", "25", "invalidemail", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Invalid email address", response.data)

        # Invalid age format
        response = self.register_user("testuser6", "password123", "Test User", "invalid_age", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Age must be a number between 1 and 150", response.data)

        # Short password
        response = self.register_user("testuser7", "123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Password must be between 8 and 20 characters", response.data)

        # Long password
        long_password = "a" * 21
        response = self.register_user("testuser8", long_password, "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Password must be between 8 and 20 characters", response.data)
        
    def test_forget_password(self):
        # Valid forget password request
        self.register_user("testuser15", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        response = self.app.post('/forget_password', json={"email": "test@example.com"})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"If your email exists in our database the reset link was successfully sent", response.data)

        # Nonexistent email
        response = self.app.post('/forget_password', json={"email": "nonexistent@example.com"})
        self.assertEqual(response.status_code, 404)
        self.assertIn(b"Email not found", response.data)

        # Invalid request (missing email)
        response = self.app.post('/forget_password', json={})
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Invalid request", response.data)

    def test_login(self):
        # Valid login
        self.register_user("testuser9", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        response = self.login_user("testuser9", "password123")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Authentication successful", response.data)

        # Nonexistent username
        response = self.login_user("nonexistentuser", "password123")
        self.assertEqual(response.status_code, 401)
        self.assertIn(b"Invalid username or password", response.data)

        # Incorrect password
        response = self.login_user("testuser9", "incorrectpassword")
        self.assertEqual(response.status_code, 401)
        self.assertIn(b"Invalid username or password", response.data)

        # Missing username
        response = self.login_user("", "password123")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Missing required fields", response.data)

        # Missing password
        response = self.login_user("testuser10", "")
        self.assertEqual(response.status_code, 400)
        self.assertIn(b"Missing required fields", response.data)

    def test_registration_valid_data(self):
        # Valid registration with all fields
        response = self.register_user("testuser11", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

    def test_login_valid_credentials(self):
        # Valid login with all fields
        self.register_user("testuser12", "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        response = self.login_user("testuser12", "password123")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Authentication successful", response.data)

    def test_registration_maximum_password_length(self):
        # Valid registration with maximum password length
        long_password = "a" * 20
        response = self.register_user("testuser13", long_password, "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

    def test_registration_minimum_age(self):
        # Valid registration with minimum age
        response = self.register_user("testuser14", "password123", "Test User", "1", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 201)
        self.assertIn(b"User registered successfully", response.data)

    def test_login_maximum_username_length(self):
        # Valid registration and login with maximum username length
        long_username = "a" * 20
        response = self.register_user(long_username, "password123", "Test User", "25", "test@example.com", "12345678901", "Test Address", "test.jpg", "12345678901")
        self.assertEqual(response.status_code, 201)
        response = self.login_user(long_username, "password123")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Authentication successful", response.data)


if __name__ == '__main__':
    unittest.main()
