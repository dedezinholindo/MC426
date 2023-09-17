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
        # Verifica se a resposta é 201 Created
        self.assertEqual(response.status_code, 201)

    def test_create_post_missing_data(self):
        response = self.client.post(
            '/posts',
            json={"title": "Meu Post"}
        )
        # Verifica se a resposta é 400 Bad Request
        self.assertEqual(response.status_code, 400)

    def test_number_of_posts_equal_3(self):
        # Add 2 correct posts and 1 wrong
        self.client.post(
            '/posts', json={"title": "Meu Post", "content": "Conteúdo do meu post."})
        self.client.post(
            '/posts', json={"title": "Meu Post", "content": "Conteúdo do meu post."})
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

    def test_get_likes_post_not_found(self):
        post_id = 4
        response = self.client.get(f'/posts/{post_id}/likes')

        self.assertEqual(response.status_code, 404)

    def test_likes_post0_equal_2(self):
        # Add another like on post 0
        post_id = 0
        response = self.client.post(f'/posts/{post_id}/like')

        # Retrieves number of likes of post 0
        response = self.client.get(f'/posts/{post_id}/likes')
        self.assertEqual(response.json['likes'], 2)


if __name__ == '__main__':
    unittest.main()
