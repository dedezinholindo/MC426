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
def get_notifications(user_id:  str):
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
