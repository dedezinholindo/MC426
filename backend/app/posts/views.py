from flask import Blueprint, request, jsonify
import sqlite3

posts_bp = Blueprint('posts', __name__)

# Complaint database
conn = sqlite3.connect('press2safe.db', check_same_thread=False)

cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS complaints (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        address TEXT NOT NULL,
        isAnonymous BOOLEAN NOT NULL,
        likes INTEGER NOT NULL,
        unlikes INTEGER NOT NULL
    )
''')
conn.commit()

# API routes

@posts_bp.route('/complaints', methods=['POST'])
# Posting and requesting of complaints.
def create_complaint():
    """
    Creates a new complaint post.

    :param title: Complaint's title.
    :param description: Complaint's description.
    :param address: Complaint's address.
    :param isAnonymous: True if the complaint mode is anonymous.
    :return: Success or error message.
    """

    # TODO: get user info

    data = request.get_json()
    title = data.get('title')
    description = data.get('description')
    address = data.get('address')
    isAnonymous = data.get('isAnonymous')

     # Checks missing 
    missing = []

    if not title:
        missing.append('title')
    if not description:
        missing.append('description')
    if not address:
        missing.append('address')
    if isAnonymous == None:
        missing.append('isAnonymous')

    if missing:
        if len(missing) == 1:
            error_msg = f"O campo {missing[0]} é obrigatório."
        elif len(missing) == 2:
            error_msg = f"Os campos {missing[0]} e {missing[1]} são obrigatórios."
        else:
            fields_str = ', '.join(missing[:-1])
            error_msg = f"Os campos {fields_str} e {missing[-1]} são obrigatórios."

        return jsonify({'error': error_msg}), 400

    # Saves the new complaint in DB
    cursor.execute('''
    INSERT INTO complaints (title, description, address, isAnonymous, likes, unlikes)
    VALUES (?, ?, ?, ?, ?, ?)
    ''', (title, description, address, isAnonymous, 0, 0))
    conn.commit()

    return jsonify({'message': 'Complaint created successfully'}), 201

# TODO: Create route to retrive a complaint by id

@posts_bp.route('/complaints', methods=['GET'])
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
            'isAnonymous': bool(c[4]),
            'likes': c[5],
            'unlikes': c[6]
        } for c in complaints
    ]
    return jsonify({'complaints': complaints})

# Implementation of complaint likes.
@posts_bp.route('/complaints/<int:complaint_id>/like', methods=['POST'])
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

@posts_bp.route('/complaints/<int:complaint_id>/likes', methods=['GET'])
def get_complaint_likes(complaint_id):
    cursor.execute("SELECT likes FROM complaints WHERE id = ?", (complaint_id,))
    current_likes = cursor.fetchone()
    
    if current_likes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_likes = current_likes[0]  

    return jsonify({'likes': current_likes}), 200

# Implementation of complaint unlikes.
@posts_bp.route('/complaints/<int:complaint_id>/unlike', methods=['POST'])
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

@posts_bp.route('/complaints/<int:complaint_id>/unlikes', methods=['GET'])
def get_complaint_unlikes(complaint_id):
    cursor.execute("SELECT unlikes FROM complaints WHERE id = ?", (complaint_id,))
    current_unlikes = cursor.fetchone()
    
    if current_unlikes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_unlikes = current_unlikes[0]  

    return jsonify({'unlikes': current_unlikes}), 200


if __name__ == '__main__':
    print(posts_bp)
