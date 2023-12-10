import unittest
import json
import sqlite3
from app.profile import get_user_by_id
import app


class TestFlaskApp(unittest.TestCase):
    def setUp(self):
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

        # Function to initialize the database
        def init_db():
            conn = sqlite3.connect("press2safe.db")
            cursor = conn.cursor()

            # Create the users table if it does not exist
            # Create the users table if it doesn't exist
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS users (
                    id TEXT PRIMARY KEY,
                    name TEXT NOT NULL,
                    username TEXT NOT NULL UNIQUE,
                    email TEXT NOT NULL,
                    age INTEGER NOT NULL,
                    phone TEXT NOT NULL,
                    password TEXT NOT NULL,
                    address TEXT NOT NULL,
                    photo TEXT,
                    safetyNumber TEXT
                )
            ''')

            conn.commit()
            conn.close()

        # Function to insert a new user into the database
        def insert_user(id, name, username, email, age, phone, password, address, photo, safetyNumber):
            conn = sqlite3.connect("press2safe.db")
            cursor = conn.cursor()

            cursor.execute('''
                INSERT INTO users (id, name, username, email, age, phone, password, address, photo, safetyNumber)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (id, name, username, email, age, phone, password, address, photo, safetyNumber))

            user_id = cursor.lastrowid

            conn.commit()
            conn.close()

            return user_id

        # Initialize the database and insert mock user data
        init_db()
        users_data = [
            {
                "id": 1,
                "name": "Test User 1",
                "username": "user1",
                "email": "user1@example.com",
                "age": 18,
                "phone": "12345678901",
                "password": "default1",
                "address": "Test Address 1",
                "photo": "test1.jpg",
                "safetyNumber": "12345678901"
            },
            {
                "id": 2,
                "name": "Test User 2",
                "username": "user2",
                "email": "user2@example.com",
                "age": 19,
                "phone": "23456789012",
                "password": "default2",
                "address": "Test Address 2",
                "photo": "test2.jpg",
                "safetyNumber": "23456789012"
            },
            {
                "id": 3,
                "name": "Test User 3",
                "username": "user3",
                "email": "user3@example.com",
                "age": 28,
                "phone": "34567890123",
                "password": "default3",
                "address": "Test Address 3",
                "photo": "test3.jpg",
                "safetyNumber": "34567890123"
            }
        ]

        for user_data in users_data:
            insert_user(
                user_data["id"],
                user_data["name"],
                user_data["username"],
                user_data["email"],
                user_data['age'],
                user_data["phone"],
                user_data['password'],
                user_data["address"],
                user_data["photo"],
                user_data["safetyNumber"]
            )

    def tearDown(self):
        # Clean up the database
        conn = sqlite3.connect("press2safe.db")
        conn.execute("DELETE FROM users")
        conn.commit()
        conn.close()

    def test_edit_profile(self):

        # Test case 2: User not found
        response = self.client.post('/edit_profile', json={
            "id": 999,  # Non-existing user ID
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
        response = self.client.post('/edit_profile', json={
            "name": "New Name",
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Missing required fields")

    def test_get_profile(self):
        # Test case 1: User not found
        response = self.client.post(
            '/get_profile', json={"id": 999})  # Non-existing user ID
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 404)
        self.assertEqual(data["message"], "User not found")

    def test_edit_profile(self):
        # Test case 1: Edit profile successfully
        response = self.client.post('/edit_profile', json={
            "id": 1,  # Existing user ID
            "name": "New Name",
            "phone": "98765432109",  # Update phone number
            "address": "New Address",
            "photo": "new.jpg",
            "safetyNumber": "98765432109"  # Update safety number
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["message"], "Profile updated successfully")

        # Verify that the profile was updated in the database
        updated_user = get_user_by_id(1)
        self.assertIsNotNone(updated_user)
        self.assertEqual(updated_user[1], "New Name")
        self.assertEqual(updated_user[5], "98765432109")
        self.assertEqual(updated_user[7], "New Address")
        self.assertEqual(updated_user[8], "new.jpg")
        self.assertEqual(updated_user[9], "98765432109")

        # Test case 2: User not found
        response = self.client.post('/edit_profile', json={
            "id": 999,  # Non-existing user ID
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
        response = self.client.post('/edit_profile', json={
            "name": "New Name",
        })
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertEqual(data["message"], "Missing required fields")

    def test_get_profile(self):
        # Test case 1: Get profile successfully
        response = self.client.post(
            '/get_profile', json={"id": 1})  # Existing user ID
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["name"], "Test User 1")

        # Test case 2: User not found
        response = self.client.post(
            '/get_profile', json={"id": 999})  # Non-existing user ID
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 404)
        self.assertEqual(data["message"], "User not found")


if __name__ == '__main__':
    unittest.main()
