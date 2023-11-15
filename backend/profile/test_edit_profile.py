import unittest
import json
import tempfile
from edit_profile import app, write_users_to_file

class TestFlaskApp(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

        # Create a temporary file with mock user data
        self.tempfile = tempfile.NamedTemporaryFile(mode='w', delete=False)
        mock_users = [
            {
                "id": "1",
                "username": "test_user1",
                "password": "test_password1",
                "name": "Test User 1",
                "age": "30",
                "email": "test_user1@example.com"
            },
            {
                "id": "2",
                "username": "test_user2",
                "password": "test_password2",
                "name": "Test User 2",
                "age": "25",
                "email": "test_user2@example.com"
            },
            {
                "id": "3",
                "username": "test_user3",
                "password": "test_password3",
                "name": "Test User 3",
                "age": "40",
                "email": "test_user3@example.com"
            }
        ]
        write_users_to_file(mock_users)

    def tearDown(self):
        # Close and remove the temporary file
        self.tempfile.close()

    def test_edit_profile(self):
        # Test case 1: Edit profile successfully
        response = self.app.put('/edit_profile', json={"username": "test_user1", "name": "New Name", "age": "25", "email": "new@email.com"})
        print(response.get_data(as_text=True))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Test case 2: User not found
        response = self.app.put('/edit_profile', json={"username": "non_existing_user", "name": "New Name", "age": "25", "email": "new@email.com"})
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 404)
        self.assertEqual(data["message"], "User not found")

        # Test case 3: Invalid request (missing fields)
        response = self.app.put('/edit_profile', json={"name": "New Name", "age": "25"})
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Missing required fields")

        # Test case 4: Edit profile for another user successfully
        response = self.app.put('/edit_profile', json={"username": "test_user2", "name": "Updated Name", "age": "28", "email": "updated@email.com"})
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Test case 5: Edit profile with non-numeric age
        response = self.app.put('/edit_profile', json={"username": "test_user3", "name": "Updated Name", "age": "Invalid", "email": "updated@email.com"})
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Age must contain only numbers")

if __name__ == '__main__':
    unittest.main()
