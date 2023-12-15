from flask import Blueprint, jsonify
from app.map.views import geocode_address
from ..database import DatabaseManager

home_bp = Blueprint('home', __name__)

# Database
db = DatabaseManager()


@home_bp.route('/home/<string:user_id>/', methods=['GET'])
def get_home(user_id:  str):
    '''
    Returns home info.

    :param user_id: User's identification;
    '''

    # Get user info
    consulta = """
        SELECT
            username,
            photo,
            address, 
            safetyNumber
        FROM users
        WHERE id = ?
    """

    db.cursor.execute(consulta, (user_id,))

    user_return = db.cursor.fetchone()

    if user_return is None:
        return jsonify({'error': 'User not found, check the user ID.'}), 404

    username = user_return[0]
    photo = user_return[1]
    address = user_return[2]
    safetyNumber = user_return[3]

    # Get user number of posts
    consulta = """
        SELECT 
            COUNT(*)
        FROM complaints
        WHERE user_id = ?
    """

    db.cursor.execute(consulta, (user_id,))

    number_of_posts = db.cursor.fetchone()[0]

    # Get latitude and longitude
    location = geocode_address(address)

    # Get posts info
    # Get user number of posts
    consulta = """
        SELECT
            complaints.id,
            COALESCE(users.username, 'Anônimo') AS username,
            users.photo,
            complaints.description,
            complaints.likes,
            complaints.unlikes,
            complaints.address,
            complaints.isAnonymous,
            CASE WHEN likes.user_id IS NOT NULL THEN likes.is_like ELSE NULL END AS user_like,
            CASE WHEN complaints.user_id == ? THEN false ELSE true END AS can_vote
        FROM complaints
        LEFT JOIN users ON complaints.user_id = users.id
        LEFT JOIN likes ON complaints.id = likes.complaint_id AND likes.user_id = ?;

    """

    db.cursor.execute(consulta, (user_id, user_id))

    posts = db.cursor.fetchall()

    return jsonify({
        'user': {
            'username': username,
            'photo': photo,
            'address': address,
            'location': location,
            'safetyNumber': safetyNumber,
            'numberOfPosts': number_of_posts
        },

        'posts':  [
            {
                'post_id': p[0],
                'author_username': p[1],
                'author_photo': p[2],
                'post_description': p[3],
                'likes': p[4],
                'unlikes': p[5],
                'address': p[6],
                'isAnonymous': p[7],
                'user_like': p[8],
                'can_vote': p[9],
            }
            for p in posts
        ]

    }), 200
