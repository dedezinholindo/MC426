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
                "email": "test_user1@example.com",
                "phone": "12345678901",
                "address": "Test Address 1",
                "photo": "test1.jpg",
                "safetyNumber": "12345678901"
            },
            {
                "id": "2",
                "username": "test_user2",
                "password": "test_password2",
                "name": "Test User 2",
                "age": "25",
                "email": "test_user2@example.com",
                "phone": "23456789012",
                "address": "Test Address 2",
                "photo": "test2.jpg",
                "safetyNumber": "23456789012"
            },
            {
                "id": "3",
                "username": "test_user3",
                "password": "test_password3",
                "name": "Test User 3",
                "age": "40",
                "email": "test_user3@example.com",
                "phone": "34567890123",
                "address": "Test Address 3",
                "photo": "test3.jpg",
                "safetyNumber": "34567890123"
            }
        ]
        write_users_to_file(mock_users)

    def tearDown(self):
        # Close and remove the temporary file
        self.tempfile.close()

    def test_edit_profile(self):
        # Test case 1: Edit profile successfully
        response = self.app.put('/edit_profile', json={
            "username": "test_user1",
            "name": "New Name",
            "age": "25",
            "email": "new@email.com",
            "phone": "12345678901",
            "address": "New Address",
            "photo": "new.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Test case 2: User not found
        response = self.app.put('/edit_profile', json={
            "username": "non_existing_user",
            "name": "New Name",
            "age": "25",
            "email": "new@email.com",
            "phone": "12345678901",
            "address": "New Address",
            "photo": "new.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 404)
        self.assertEqual(data["message"], "User not found")

        # Test case 3: Invalid request (missing fields)
        response = self.app.put('/edit_profile', json={
            "name": "New Name",
            "age": "25"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Missing required fields")

        # Test case 4: Edit profile for another user successfully
        response = self.app.put('/edit_profile', json={
            "username": "test_user2",
            "name": "Updated Name",
            "age": "28",
            "email": "updated@email.com",
            "phone": "23456789012",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "23456789012"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Test case 5: Edit profile with non-numeric age
        response = self.app.put('/edit_profile', json={
            "username": "test_user3",
            "name": "Updated Name",
            "age": "Invalid",
            "email": "updated@email.com",
            "phone": "34567890123",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "34567890123"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Age must be a number between 1 and 150")

        # Test case 6: Edit profile with non-numeric phone
        response = self.app.put('/edit_profile', json={
            "username": "test_user1",
            "name": "Updated Name",
            "age": "25",
            "email": "updated@email.com",
            "phone": "Invalid",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Phone number must be an 11-digit number")

        # Test case 7: Edit profile with invalid phone length
        response = self.app.put('/edit_profile', json={
            "username": "test_user1",
            "name": "Updated Name",
            "age": "25",
            "email": "updated@email.com",
            "phone": "123",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Phone number must be an 11-digit number")

        # Test case 8: Edit profile with non-numeric safetyNumber
        response = self.app.put('/edit_profile', json={
            "username": "test_user1",
            "name": "Updated Name",
            "age": "25",
            "email": "updated@email.com",
            "phone": "12345678901",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "Invalid"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Safety number must be an 11-digit number")

        # Test case 9: Edit profile with invalid safetyNumber length
        response = self.app.put('/edit_profile', json={
            "username": "test_user1",
            "name": "Updated Name",
            "age": "25",
            "email": "updated@email.com",
            "phone": "12345678901",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "123"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Safety number must be an 11-digit number")

if __name__ == '__main__':
    unittest.main()
