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
        response = self.app.post('/edit_profile', json={
            "id": "1",
            "name": "New Name",
            "phone": "12345678901",
            "address": "New Address",
            "photo": "new.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Test case 2: User not found
        response = self.app.post('/edit_profile', json={
            "id": "non_existing_user",
            "name": "New Name",
            "phone": "12345678901",
            "address": "New Address",
            "photo": "new.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 404)
        self.assertEqual(data["message"], "User not found")

        # Test case 3: Invalid request (missing fields)
        response = self.app.post('/edit_profile', json={
            "name": "New Name",
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Missing required fields")

        # Test case 4: Edit profile for another user successfully
        response = self.app.post('/edit_profile', json={
            "id": "2",
            "name": "Updated Name",
            "phone": "23456789012",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "23456789012"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Test case 6: Edit profile with non-numeric phone
        response = self.app.post('/edit_profile', json={
            "id": "1",
            "name": "Updated Name",
            "phone": "Invalid",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Phone number must be an 11-digit number")

        # Test case 7: Edit profile with invalid phone length
        response = self.app.post('/edit_profile', json={
            "id": "1",
            "name": "Updated Name",
            "phone": "123",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "12345678901"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Phone number must be an 11-digit number")

        # Test case 8: Edit profile with non-numeric safetyNumber
        response = self.app.post('/edit_profile', json={
            "id": "1",
            "name": "Updated Name",
            "phone": "12345678901",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "Invalid"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Safety number must be an 11-digit number")

        # Test case 9: Edit profile with invalid safetyNumber length
        response = self.app.post('/edit_profile', json={
            "id": "1",
            "name": "Updated Name",
            "phone": "12345678901",
            "address": "Updated Address",
            "photo": "updated.jpg",
            "safetyNumber": "123"
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Safety number must be an 11-digit number")

    def test_get_profile(self):
        # Test case 1: User not found
        response = self.app.post('/get_profile', json={"id": "non_existing_user"})
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 404)
        self.assertEqual(data["message"], "User not found")
        
        # Test case 2: Get profile successfully
        response = self.app.post('/get_profile', json={"id": "1"})
        data = json.loads(response.get_data(as_text=True))
        expected_profile = {
            "id": "1",
            "name": "Test User 1",
            "age": "30",
            "phone": "12345678901",
            "address": "Test Address 1",
            "photo": "test1.jpg",
            "safetyNumber": "12345678901"
        }
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data, expected_profile)



if __name__ == '__main__':
    unittest.main()
