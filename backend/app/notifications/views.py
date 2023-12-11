from flask import Blueprint, jsonify, request
import sqlite3

notifications_bp = Blueprint('notifications', __name__)

# Setup database for notifications


def setup_notifications_db():
    conn = sqlite3.connect('press2safe.db', check_same_thread=False)

    cursor = conn.cursor()
    cursor.execute('''
            CREATE TABLE IF NOT EXISTS notifications (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            topic_name TEXT NOT NULL)
    ''')
    conn.commit()

    cursor.execute(
        '''
        DELETE FROM notifications
        '''
    )
    conn.commit()

    cursor.execute('''
        INSERT INTO notifications (title, description, topic_name)
                VALUES ('Notificações de SOS', 
                'Notificação de pedidos de socorro de outros usuários, receba notificações quando algum usuário acionar o botão de pânico e ajude a comunidade', 
                'sos_message_topic')
        ''')
    conn.commit()

    cursor.execute('''
        INSERT INTO notifications  (title, description, topic_name)
                VALUES
                (
                'Notificações novas publicações',
                'Notificação de novas publicações de outros usuários, mantenha-se informado a respeito de novas publicações',
                'new_post_topic' 
                )
        ''')

    conn.commit()

    #

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS notifications_users (
            id INTEGER PRIMARY KEY,
            user_id TEXT NOT NULL,
            notification_id INTEGER NOT NULL,
            is_active BOOLEAN NOT NULL
            )
    ''')
    conn.commit()

    cursor.execute(
        '''
        CREATE TRIGGER IF NOT EXISTS trg_UserAdded
        BEFORE INSERT ON users
        FOR EACH ROW
        BEGIN
        INSERT INTO notifications_users (user_id, notification_id, is_active)
        SELECT
            NEW.id,
            n.id,
            True
        FROM
            notifications n;
        END
        '''
    )
    conn.commit()
    return conn, cursor


conn, cursor = setup_notifications_db()

# Rotas


@notifications_bp.route('/notifications/<string:user_id>', methods=['GET'])
def get_notifications(user_id:  str):
    '''
    Returns a list with notifications for the user.

    :param user_id: User's identification;

    :return: All notifications in JSON format.    
    '''

    consulta = """
        SELECT 
            notifications.id, 
            notifications.title, 
            notifications.description, 
            notifications.topic_name, 
            notifications_users.is_active
        FROM notifications
        JOIN notifications_users ON notifications.id = notifications_users.notification_id
        WHERE notifications_users.user_id = ?
    """

    cursor.execute(consulta, (user_id,))

    users_notifications = cursor.fetchall()

    users_notifications = [
        {
            'notification_id': n[0],
            'title': n[1],
            'description': n[2],
            'topic_name': n[3],
            'is_active': bool(n[4])
        } for n in users_notifications
    ]

    return jsonify({'notifications': users_notifications})

@notifications_bp.route('/notifications/', methods=['POST'])
def setup_notifications():
    '''
    Configures the notification for a user.

    :return: Success or error message.    
    '''

    data = request.get_json()
    notification_id = data.get('id')
    user_id = data.get('user_id')
    is_active = data.get('is_active')


    consulta = """
        UPDATE notifications_users
        SET is_active = ?
        WHERE user_id = ? AND notification_id = ?
    """

    cursor.execute(consulta, (is_active, user_id, notification_id,))

    affected = cursor.rowcount
    print(affected)

    conn.commit()

    if affected > 0:
        return jsonify({'message': 'Notification updated successfully!'}), 200
    else:
        return  jsonify({'error': 'Notification not found, check the ID or user ID.'}), 404
    