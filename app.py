from flask import Flask, jsonify
from main.routes import main
from contact.routes import contact
from cicd.routes import cicd
import platform
import os
import time

from models.models import db  # <-- Import SQLAlchemy db instance

# Load environment variables
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)
app.secret_key = "devops-is-awesome"

# SQLAlchemy Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///cicd.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

# Create database tables
with app.app_context():
    db.create_all()

# Register Blueprints
app.register_blueprint(main)
app.register_blueprint(contact)
app.register_blueprint(cicd)

# Track uptime
start_time = time.time()

# System Info Route
@app.route('/sysinfo')
def sysinfo():
    uptime = time.time() - start_time
    try:
        container_id = open("/etc/hostname").read().strip()
    except Exception:
        container_id = "Unavailable"

    info = {
        "hostname": platform.node(),
        "system": platform.system(),
        "release": platform.release(),
        "python_version": platform.python_version(),
        "uptime_seconds": round(uptime),
        "container_id": container_id
    }
    return jsonify(info)

# Run App
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)