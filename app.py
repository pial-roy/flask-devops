from flask import Flask, jsonify
from main.routes import main
from contact.routes import contact
from cicd.routes import cicd
import platform
import os
import time

from models.models import db  # <-- Import SQLAlchemy db instance
from dotenv import load_dotenv
load_dotenv()

# ⬇️ NEW: Prometheus & psutil
from prometheus_flask_exporter import PrometheusMetrics
from prometheus_client import Gauge
import psutil

app = Flask(__name__)
app.secret_key = "devops-is-awesome"

# Setup Prometheus metrics
metrics = PrometheusMetrics(app)  # Adds default metrics at /metrics

# Custom resource usage metrics
memory_percent_gauge = Gauge('flask_memory_usage_percent', 'Memory usage percent')
cpu_percent_gauge = Gauge('flask_cpu_usage_percent', 'CPU usage percent')

# Update custom metrics on each request
@app.before_request
def update_resource_metrics():
    memory_percent_gauge.set(psutil.virtual_memory().percent)
    cpu_percent_gauge.set(psutil.cpu_percent(interval=None))

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

    memory = psutil.virtual_memory()
    cpu_percent = psutil.cpu_percent(interval=0.5)

    info = {
        "hostname": platform.node(),
        "system": platform.system(),
        "release": platform.release(),
        "python_version": platform.python_version(),
        "uptime_seconds": round(uptime),
        "container_id": container_id,
        "memory_total_MB": round(memory.total / (1024 ** 2)),
        "memory_used_MB": round(memory.used / (1024 ** 2)),
        "memory_percent": memory.percent,
        "cpu_percent": cpu_percent
    }
    return jsonify(info)

# Run App
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
