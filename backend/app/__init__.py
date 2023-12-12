from flask import Flask

def create_app():
    app = Flask(__name__)

    # Registrar Blueprints
    from app.login.views import login_bp
    from app.posts.views import posts_bp
    from app.map.views import map_bp
    from app.profile.views import profile_bp

    app.register_blueprint(login_bp)
    app.register_blueprint(posts_bp)
    app.register_blueprint(map_bp)
    app.register_blueprint(profile_bp)

    return app