from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

# Save the application's posts.
# TODO: Save and retrieve from a file.

# Complaint database
conn = sqlite3.connect('complaints.db', check_same_thread=False)

cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS complaints (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        address TEXT NOT NULL,
        is_anonymous BOOLEAN NOT NULL,
        likes INTEGER NOT NULL,
        unlikes INTEGER NOT NULL
    )
''')
conn.commit()

complaint_id = 0

# API routes

@app.route("/", methods=["GET"])
def healthcheck():
    """
    If the route is working, returns a 'healthy!' string.
    """
    return "healthy!"

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

    # Saves the new complaint in DB
    cursor.execute('''
    INSERT INTO complaints (title, description, address, is_anonymous, likes, unlikes)
    VALUES (?, ?, ?, ?, ?, ?)
    ''', (title, description, address, is_anonymous, 0, 0))
    conn.commit()

    return jsonify({'message': 'Complaint created successfully'}), 201

# TODO: Create route to retrive a complaint by id

@app.route('/complaints', methods=['GET'])
def get_complaints():
    '''
    Retrieve all complaints.

    :return: All complaints in JSON format.
    '''

    cursor.execute('SELECT * FROM complaints')
    complaints = cursor.fetchall()
    complaints = [
        {
            'id': c[0],
            'title': c[1],
            'description': c[2],
            'address': c[3],
            'is_anonymous': bool(c[4]),
            'likes': c[5],
            'unlikes': c[6]
        } for c in complaints
    ]
    return jsonify({'complaints': complaints})

# Implementation of complaint likes.
@app.route('/complaints/<int:complaint_id>/like', methods=['POST'])
def like_complaint(complaint_id):
    cursor.execute("SELECT likes FROM complaints WHERE id = ?", (complaint_id,))
    current_likes = cursor.fetchone()
    
    if current_likes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_likes = current_likes[0]  
    new_likes = current_likes + 1
    cursor.execute("UPDATE complaints SET likes = ? WHERE id = ?", (new_likes, complaint_id))
    conn.commit()

    return jsonify({'message': 'Complaint liked successfully'}), 200

@app.route('/complaints/<int:complaint_id>/likes', methods=['GET'])
def get_complaint_likes(complaint_id):
    cursor.execute("SELECT likes FROM complaints WHERE id = ?", (complaint_id,))
    current_likes = cursor.fetchone()
    
    if current_likes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_likes = current_likes[0]  

    return jsonify({'likes': current_likes}), 200

# Implementation of complaint unlikes.
@app.route('/complaints/<int:complaint_id>/unlike', methods=['POST'])
def unlike_complaint(complaint_id):
    cursor.execute("SELECT unlikes FROM complaints WHERE id = ?", (complaint_id,))
    current_unlikes = cursor.fetchone()
    
    if current_unlikes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_unlikes = current_unlikes[0]  
    new_unlikes = current_unlikes + 1
    cursor.execute("UPDATE complaints SET unlikes = ? WHERE id = ?", (new_unlikes, complaint_id))
    conn.commit()

    return jsonify({'message': 'Complaint unliked successfully'}), 200

@app.route('/complaints/<int:complaint_id>/unlikes', methods=['GET'])
def get_complaint_unlikes(complaint_id):
    cursor.execute("SELECT unlikes FROM complaints WHERE id = ?", (complaint_id,))
    current_unlikes = cursor.fetchone()
    
    if current_unlikes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_unlikes = current_unlikes[0]  

    return jsonify({'unlikes': current_unlikes}), 200


if __name__ == '__main__':
    app.run(debug=True)
