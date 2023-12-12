from flask import Blueprint, jsonify, request
import sqlite3

home_bp = Blueprint('home', __name__)


def setup_home_db():
    conn = sqlite3.connect('press2safe.db', check_same_thread=False)
    cursor = conn.cursor()

    return conn, cursor


conn, cursor = setup_home_db()

# Rotas


@home_bp.route('/home/<string:user_id>/safety_number', methods=['GET'])
def get_home(user_id:  str):
    '''
    Returns the user's safety number.

    :param user_id: User's identification;
    '''

    consulta = """
        SELECT 
            safetyNumber
        FROM users
        WHERE id = ?
    """

    cursor.execute(consulta, (user_id,))

    user_return = cursor.fetchone()

    if user_return is None:
        return jsonify({'error': 'User not found, check the user ID.'}), 404

    safety_number = user_return[0]

    return jsonify({'safety_number': safety_number}), 200


@home_bp.route('/home/<string:user_id>/username', methods=['GET'])
def get_username(user_id:  str):
    '''
    Returns the username.

    :param user_id: User's identification;
    '''

    consulta = """
        SELECT 
            username
        FROM users
        WHERE id = ?
    """

    cursor.execute(consulta, (user_id,))

    user_return = cursor.fetchone()

    if user_return is None:
        return jsonify({'error': 'User not found, check the user ID.'}), 404

    username = user_return[0]

    return jsonify({'username': username}), 200

@home_bp.route('/home/<string:user_id>/photo', methods=['GET'])
def get_photo(user_id:  str):
    '''
    Returns the user's photo.

    :param user_id: User's identification;
    '''

    consulta = """
        SELECT 
            photo
        FROM users
        WHERE id = ?
    """

    cursor.execute(consulta, (user_id,))

    user_return = cursor.fetchone()

    if user_return is None:
        return jsonify({'error': 'User not found, check the user ID.'}), 404

    photo = user_return[0]

    return jsonify({'photo': photo}), 200

@home_bp.route('/home/<string:user_id>/number_of_posts', methods=['GET'])
def get_number_of_posts(user_id:  str):
    '''
    Returns the user's number of posts.

    :param user_id: User's identification;
    '''

    consulta = """
        SELECT 
            COUNT(*)
        FROM complaints
        WHERE user_id = ?
    """

    cursor.execute(consulta, (user_id,))

    number_of_posts = cursor.fetchone()[0]

    return jsonify({'number_of_posts': number_of_posts}), 200
