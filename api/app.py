from flask import Flask, request, jsonify

app = Flask(__name__)

# Save the application's posts.
# TODO: Save and retrieve from a file.
posts = []
post_id = 0

# API routes


@app.route('/posts', methods=['POST'])
def create_post():
    """
    Creates a new post.

    :param title: Post's title.
    :param content: Post's content.
    :return: Success or error message.
    """

    global post_id

    data = request.get_json()
    title = data.get('title')
    content = data.get('content')

    if not title or not content:
        return jsonify({'error': 'Title and content are required'}), 400

    post = {'title': title, 'content': content}
    post['id'] = post_id
    post_id += 1

    posts.append(post)

    return jsonify({'message': 'Post created successfully'}), 201


@app.route('/posts', methods=['GET'])
def get_posts():
    '''
    Retrieve all posts.

    :return: All posts in JSON format.
    '''
    return jsonify({'posts': posts})

if __name__ == '__main__':
    app.run(debug=True)