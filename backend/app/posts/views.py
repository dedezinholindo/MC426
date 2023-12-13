from flask import Blueprint, request, jsonify
import sqlite3

posts_bp = Blueprint('posts', __name__)

# Complaint database
conn = sqlite3.connect('press2safe.db', check_same_thread=False)

# Inicia tabela de complaints
cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS complaints (
        id INTEGER PRIMARY KEY,
        user_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        address TEXT NOT NULL,
        isAnonymous BOOLEAN NOT NULL,
        likes INTEGER NOT NULL,
        unlikes INTEGER NOT NULL
    )
''')
conn.commit()

# Inicia tabela de likes
cursor.execute('''
    CREATE TABLE IF NOT EXISTS likes (
        id INTEGER PRIMARY KEY,
        complaint_id INTEGER,
        user_id TEXT,
        is_like BOOLEAN,
        FOREIGN KEY (complaint_id) REFERENCES complaints(id)
    )
''')
conn.commit()

#pega os posts do usuário 
def get_complaints_by_id(user_id):
    cursor.execute("SELECT * FROM complaints WHERE user_id=?", (user_id,))

    user = cursor.fetchall()

    return user

def get_user_by_id(user_id):
    cursor.execute("SELECT name, photo FROM users WHERE id=?", (user_id,))

    user = cursor.fetchone()

    return user

# API routes


@posts_bp.route('/complaints/<string:user_id>', methods=['POST'])
# Posting and requesting of complaints.
def create_complaint(user_id: str):
    """
    Creates a new complaint post.

    :param user_id: Complaint's user identification. 

    :param title: Complaint's title.
    :param description: Complaint's description.
    :param address: Complaint's address.
    :param isAnonymous: True if the complaint mode is anonymous.
    :return: Success or error message.
    """

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
    if isAnonymous == True:
        cursor.execute('''
        INSERT INTO complaints (user_id, title, description, address, isAnonymous, likes, unlikes)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', ("anonymous", title, description, address, isAnonymous, 0, 0))
    else:
        cursor.execute('''
        INSERT INTO complaints (user_id, title, description, address, isAnonymous, likes, unlikes)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', (user_id, title, description, address, isAnonymous, 0, 0))
    conn.commit()

    return jsonify({'message': 'Complaint created successfully'}), 201

# TODO: Create route to retrive a complaint by id


@posts_bp.route('/complaints/<string:user_id>', methods=['GET'])
def get_complaints(user_id):
    '''
    Retrieve all complaints of a user

    :return: All complaints in JSON format.
    '''
    
    complaints = get_complaints_by_id(user_id)
    user = get_user_by_id(user_id)

    user = {
        'name': user[0],
        'photo': user[1]
    }

    complaints = [
        {
            'id': c[0],
            'title': c[2],
            'description': c[3],
            'address': c[4],
            'likes': c[6],
            'unlikes': c[7]
        } for c in complaints
    ]
    return jsonify({'complaints': complaints, 'header': user})

# Implementation of complaint likes.


@posts_bp.route('/complaints/<int:complaint_id>/like/<string:user_id>', methods=['POST'])
def like_complaint(complaint_id, user_id):

    # Checar se o post existe
    cursor.execute("SELECT likes, unlikes FROM complaints WHERE id = ?",
                   (complaint_id,))
    likes = cursor.fetchone()
    if likes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    # Se o post existir checar o like
    cursor.execute('''
        SELECT * FROM likes
        WHERE complaint_id = ? AND user_id = ?
    ''', (complaint_id, user_id))
    like = cursor.fetchone()

    like_inc = 0
    unlike_inc = 0
    # Se não deu like:
    if like is None:
        # Adiciona o like
        cursor.execute('''
        INSERT INTO likes (complaint_id, user_id, is_like)
        VALUES (?, ?, ?)
        ''', (complaint_id, user_id, True))
        like_inc = 1
        message = 'Complaint liked successfully'

    # Se o usuário deu like:
    elif like[3]:
        # Se for like retira o like

        cursor.execute('''
        DELETE FROM likes
        WHERE id = ?
        ''', (like[0],))
        like_inc = -1
        message = f'Like from user {user_id} has been removed!'

    else:
        # Se for unlike, transforma em like
        cursor.execute('''
        UPDATE likes
        SET is_like = ?
        WHERE id = ?
        ''', (True, like[0]))
        like_inc = 1
        unlike_inc = -1
        message = f'Unlike from user {user_id} turned into like!'

    current_likes = likes[0]
    current_unlikes = likes[1]
    cursor.execute("UPDATE complaints SET likes = ?, unlikes = ? WHERE id = ?",
                   (current_likes + like_inc, current_unlikes + unlike_inc, complaint_id))
    conn.commit()

    return jsonify({'message': message}), 200


@posts_bp.route('/complaints/<int:complaint_id>/likes', methods=['GET'])
def get_complaint_likes(complaint_id):
    cursor.execute("SELECT likes FROM complaints WHERE id = ?",
                   (complaint_id,))
    current_likes = cursor.fetchone()

    if current_likes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_likes = current_likes[0]

    return jsonify({'likes': current_likes}), 200

# Implementation of complaint unlikes.

@posts_bp.route('/complaints/<int:complaint_id>/unlike/<string:user_id>', methods=['POST'])
def unlike_complaint(complaint_id, user_id):

    # Checar se o post existe
    cursor.execute("SELECT likes, unlikes FROM complaints WHERE id = ?",
                   (complaint_id,))
    likes = cursor.fetchone()
    if likes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    # Se o post existir checar o unlike
    cursor.execute('''
        SELECT * FROM likes
        WHERE complaint_id = ? AND user_id = ?
    ''', (complaint_id, user_id))
    like = cursor.fetchone()

    like_inc = 0
    unlike_inc = 0
    # Se não deu unlike:
    if like is None:
        # Adiciona o unlike
        cursor.execute('''
        INSERT INTO likes (complaint_id, user_id, is_like)
        VALUES (?, ?, ?)
        ''', (complaint_id, user_id, False))
        unlike_inc = 1
        message = 'Complaint unliked successfully'

    # Se o usuário deu unlike:
    elif like[3] == False:
        # Se for like retira o unlike

        cursor.execute('''
        DELETE FROM likes
        WHERE id = ?
        ''', (like[0],))
        unlike_inc = -1
        message = f'Unlike from user {user_id} has been removed!'

    else:
        # Se for like, transforma em unlike
        cursor.execute('''
        UPDATE likes
        SET is_like = ?
        WHERE id = ?
        ''', (False, like[0]))
        like_inc = -1
        unlike_inc = 1
        message = f'Like from user {user_id} turned into unlike!'

    current_likes = likes[0]
    current_unlikes = likes[1]
    cursor.execute("UPDATE complaints SET likes = ?, unlikes = ? WHERE id = ?",
                   (current_likes + like_inc, current_unlikes + unlike_inc, complaint_id))
    conn.commit()

    return jsonify({'message': message}), 200


@posts_bp.route('/complaints/<int:complaint_id>/unlikes', methods=['GET'])
def get_complaint_unlikes(complaint_id):
    cursor.execute(
        "SELECT unlikes FROM complaints WHERE id = ?", (complaint_id,))
    current_unlikes = cursor.fetchone()

    if current_unlikes is None:
        return jsonify({'error': 'Complaint not found'}), 404

    current_unlikes = current_unlikes[0]

    return jsonify({'unlikes': current_unlikes}), 200


if __name__ == '__main__':
    print(posts_bp)
