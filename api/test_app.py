import unittest
import app

class TestPosts(unittest.TestCase):
    
    def setUp(self) -> None:
        # Configurar o cliente de teste Flask
        self.client = app.app.test_client()

    def test_create_post_success(self):
        response = self.client.post(
            '/posts',
            json={"title": "Meu Post", "content": "Conteúdo do meu post."}
        )
        self.assertEqual(response.status_code, 201)  # Verifica se a resposta é 201 Created

    def test_create_post_missing_data(self):
        response = self.client.post(
            '/posts',
            json={"title": "Meu Post"}
        )
        self.assertEqual(response.status_code, 400)  # Verifica se a resposta é 400 Bad Request

    def test_number_of_posts(self):
        # Add 2 correct posts and 1 wrong
        self.client.post('/posts', json={"title": "Meu Post", "content": "Conteúdo do meu post."})
        self.client.post('/posts', json={"title": "Meu Post", "content": "Conteúdo do meu post."})
        self.client.post('/posts', json={'content': 'Conteúdo do post.'})
        # 
        response = self.client.get('/posts')
        self.assertEqual(len(response.json['posts']), 3)
        

if __name__ == '__main__':
    unittest.main()