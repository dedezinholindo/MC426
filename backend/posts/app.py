from flask import Flask, request, jsonify

app = Flask(__name__)

# Save the application's posts.
# TODO: Save and retrieve from a file.
posts = []
post_id = 0

# API routes


@app.route('/posts', methods=['POST'])
# Posting and requesting of posts.
def create_post():
    """
    Creates a new post.

    :param title: Post's title.
    :param content: Post's content.
    :return: Success or error message.
    """

    global post_id

    # TODO: get user info
    data = request.get_json()
    title = data.get('title')
    content = data.get('content')

    if not title or not content:
        return jsonify({'error': 'Title and content are required'}), 400

    post = {'title': title, 'content': content}
    post['id'] = post_id
    post_id += 1
    post['likes'] = 0
    post['unlikes'] = 0

    posts.append(post)

    return jsonify({'message': 'Post created successfully'}), 201


@app.route('/posts', methods=['GET'])
def get_posts():
    '''
    Retrieve all posts.

    :return: All posts in JSON format.
    '''
    return jsonify({'posts': posts})


# Implementation of post likes.
@app.route('/posts/<int:post_id>/like', methods=['POST'])
def like_post(post_id):
    post = next((p for p in posts if p['id'] == post_id), None)
    
    if post is None:
        return jsonify({'error': 'Post not found'}), 404

    post['likes'] += 1
    return jsonify({'message': 'Post liked successfully'}), 200

@app.route('/posts/<int:post_id>/likes', methods=['GET'])
def get_post_likes(post_id):
    post = next((p for p in posts if p['id'] == post_id), None)
    
    if post is None:
        return jsonify({'error': 'Post not found'}), 404

    return jsonify({'likes': post['likes']}), 200

# Implementation of post unlikes.
@app.route('/posts/<int:post_id>/unlike', methods=['POST'])
def unlike_post(post_id):
    post = next((p for p in posts if p['id'] == post_id), None)
    
    if post is None:
        return jsonify({'error': 'Post not found'}), 404

    post['unlikes'] += 1
    return jsonify({'message': 'Post unliked successfully'}), 200

@app.route('/posts/<int:post_id>/unlikes', methods=['GET'])
def get_post_unlikes(post_id):
    post = next((p for p in posts if p['id'] == post_id), None)
    
    if post is None:
        return jsonify({'error': 'Post not found'}), 404

    return jsonify({'unlikes': post['unlikes']}), 200


if __name__ == '__main__':
    app.run(debug=True)
