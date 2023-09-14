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

    def test_number_of_posts_equal_3(self):
        # Add 2 correct posts and 1 wrong
        self.client.post('/posts', json={"title": "Meu Post", "content": "Conteúdo do meu post."})
        self.client.post('/posts', json={"title": "Meu Post", "content": "Conteúdo do meu post."})
        self.client.post('/posts', json={'content': 'Conteúdo do post.'})
        # 
        response = self.client.get('/posts')
        self.assertEqual(len(response.json['posts']), 3)

    def test_like_post_not_found(self):
        post_id = 4
        response = self.client.post(f'/posts/{post_id}/like')

        self.assertEqual(response.status_code, 404)

    def test_like_post_0(self):
        post_id = 0
        response = self.client.post(f'/posts/{post_id}/like')

        self.assertEqual(response.status_code, 200)
    
    def test_likes_post0_equal_2(self):
        # Add another like on post 0
        post_id = 0
        self.client.post(f'/posts/{post_id}/like')
        
        # Retrieves post 0
        response = self.client.get('/posts')
        post0_likes = [p for p in response.json['posts'] if p['id'] == 0][0]['likes']
        self.assertEqual(post0_likes, 2)

    

if __name__ == '__main__':
    unittest.main()