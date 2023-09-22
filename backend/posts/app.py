from flask import Flask, request, jsonify

app = Flask(__name__)

# Save the application's posts.
# TODO: Save and retrieve from a file.
complaints = []
complaint_id = 0

# API routes


@app.route('/complaints', methods=['POST'])
# Posting and requesting of complaints.
def create_complaint():
    """
    Creates a new complaint post.

    :param title: Complaint's title.
    :param description: Complaint's description.
    :param address: Complaint's address.
    :param is_anonymous: True if the complaint mode is anonymous.
    :return: Success or error message.
    """

    global complaint_id

    # TODO: get user info
    data = request.get_json()
    title = data.get('title')
    description = data.get('description')
    address = data.get('address')
    is_anonymous = data.get('is_anonymous')

    # Checks missing 
    missing = []
    if title == None:
        missing.append('title')
    if description == None:
        missing.append('description')
    if address == None:
        missing.append('address')
    if is_anonymous == None:
        missing.append('is_anonymous')
    if missing != []:
        return jsonify({'error': f'Missing values: ' + ', '.join(missing)}), 400

    complaint = {
        'id': complaint_id,
        'title': title,
        'description': description,
        'address': address,
        'is_anonymous': is_anonymous,
        'likes': 0,
        'unlikes': 0,
    }
    complaint_id += 1

    complaints.append(complaint)

    return jsonify({'message': 'Complaint created successfully'}), 201

# TODO: Create route to retrive a complaint by id

@app.route('/complaints', methods=['GET'])
def get_complaints():
    '''
    Retrieve all complaints.

    :return: All complaints in JSON format.
    '''
    return jsonify({'complaints': complaints})


# Implementation of complaint likes.
@app.route('/complaints/<int:complaint_id>/like', methods=['POST'])
def like_complaint(complaint_id):
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if complaint is None:
        return jsonify({'error': 'Complaint not found'}), 404

    complaint['likes'] += 1
    return jsonify({'message': 'Complaint liked successfully'}), 200

@app.route('/complaints/<int:complaint_id>/likes', methods=['GET'])
def get_complaint_likes(complaint_id):
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if complaint is None:
        return jsonify({'error': 'Complaint not found'}), 404

    return jsonify({'likes': complaint['likes']}), 200

# Implementation of complaint unlikes.
@app.route('/complaints/<int:complaint_id>/unlike', methods=['POST'])
def unlike_complaint(complaint_id):
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if complaint is None:
        return jsonify({'error': 'Complaint not found'}), 404

    complaint['unlikes'] += 1
    return jsonify({'message': 'Complaint unliked successfully'}), 200

@app.route('/complaints/<int:complaint_id>/unlikes', methods=['GET'])
def get_complaint_unlikes(complaint_id):
    complaint = next((c for c in complaints if c['id'] == complaint_id), None)
    
    if complaint is None:
        return jsonify({'error': 'Complaint not found'}), 404

    return jsonify({'unlikes': complaint['unlikes']}), 200


if __name__ == '__main__':
    app.run(debug=True)
