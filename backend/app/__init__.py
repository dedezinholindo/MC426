from flask import Flask

def create_app():
    app = Flask(__name__)

    # Registrar Blueprints
    from app.login.views import login_bp

    app.register_blueprint(login_bp)

    return app