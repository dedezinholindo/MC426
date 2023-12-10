import unittest
import app
# import sqlite3

# clear_complaints = True

class TestComplaints(unittest.TestCase):

    def setUp(self) -> None:
        # global clear_complaints
        
        # if clear_complaints:
        #     conn = sqlite3.connect('complaints.db')
        #     cursor = conn.cursor()

        #     cursor.execute("DELETE FROM complaints")
        #     conn.commit()
        #     conn.close()
        #     clear_complaints = False
        
        # Configurar o cliente de teste Flask
        self.app = app.create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()

    def test_create_complaint_success(self):
        response = self.client.post(
            '/complaints',
            json={
                "title": "Minha denúncia",
                "description": "Descrição da minha denúncia.",
                "address": "Endereço da Denúncia",
                "isAnonymous": False}
        )
        # Verifica se a resposta é 201 Created
        self.assertEqual(response.status_code, 201)

    def test_create_complaint_missing_title(self):
        response = self.client.post(
            '/complaints',
            json={
                "description": "Descrição da minha denúncia.",
                "address": "Endereço da Denúncia",
                "isAnonymous": False}
        )
        # Verifica se a resposta é 400 Bad Request
        self.assertEqual(response.status_code, 400)

    def test_create_complaint_missing_isanonymous(self):
        response = self.client.post(
            '/complaints',
            json={
                "title": "Título",
                "description": "Descrição da minha denúncia.",
                "address": "Endereço da Denúncia",
            }
        )
        # Verifica se a resposta é 400 Bad Request
        self.assertEqual(response.status_code, 400)

    def test_number_of_complaints_equal_3(self):
        # Add 2 correct complaints and 1 wrong
        self.client.post(
            '/complaints',
            json={
                "title": "Denúncia",
                "description": "Descrição.",
                "address": "Endereço",
                "isAnonymous": True}
        )
        self.client.post(
            '/complaints',
            json={
                "title": "Denúncia",
                "description": "Descrição.",
                "address": "Endereço",
                "isAnonymous": True}
        )
        self.client.post(
            '/complaints',
            json={
                "title1": "Denúncia", # typed incorrectly
                "description": "Descrição.",
                "address": "Endereço",
                "isAnonymous": True}
        )
        #
        response = self.client.get('/complaints')
        self.assertEqual(len(response.json['complaints']), 3)

    def test_like_complaint_not_found(self):
        complaint_id = 4
        response = self.client.post(f'/complaints/{complaint_id}/like')

        self.assertEqual(response.status_code, 404)

    def test_like_complaint_1(self):
        complaint_id = 1
        response = self.client.post(f'/complaints/{complaint_id}/like')

        self.assertEqual(response.status_code, 200)

    def test_get_likes_complaint_not_found(self):
        complaint_id = 5
        response = self.client.get(f'/complaints/{complaint_id}/likes')

        self.assertEqual(response.status_code, 404)

    def test_likes_complaint1_equal_2(self):
        # Add another unlike on complaint 0
        complaint_id = 1
        response = self.client.post(f'/complaints/{complaint_id}/like')

        # Retrieves number of likes of complaint 0
        response = self.client.get(f'/complaints/{complaint_id}/likes')
        self.assertEqual(response.json['likes'], 2)

    def test_unlike_complaint_1(self):
        complaint_id = 1
        response = self.client.post(f'/complaints/{complaint_id}/unlike')

        self.assertEqual(response.status_code, 200)

    def test_unlikes_complaint1_equal_3(self):
        # Add other 2 unlikes on complaint 0
        complaint_id = 1
        response = self.client.post(f'/complaints/{complaint_id}/unlike')
        response = self.client.post(f'/complaints/{complaint_id}/unlike')

        # Retrieves number of likes of complaint 0
        response = self.client.get(f'/complaints/{complaint_id}/unlikes')
        self.assertEqual(response.json['unlikes'], 3)


if __name__ == '__main__':
    unittest.main()
