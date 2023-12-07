from flask import Flask
# from config import Config

# def create_app(config_class=Config):
def create_app():
    app = Flask(__name__)
    # app.config.from_object(config_class)

    # Registrar Blueprints
    from app.login.views import login_bp
    from app.posts.views import posts_bp

    app.register_blueprint(login_bp)
    app.register_blueprint(posts_bp)

    return app