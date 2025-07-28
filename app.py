from flask import Flask, jsonify
from main.routes import main
from contact.routes import contact
import platform
import os
import time

app = Flask(__name__)
app.secret_key = "devops-is-awesome"

# Register Blueprints
app.register_blueprint(main)
app.register_blueprint(contact)

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