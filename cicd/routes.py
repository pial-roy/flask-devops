from flask import Blueprint, render_template, jsonify
import os
import requests

cicd = Blueprint("cicd", __name__)

@cicd.route("/cicd")
def cicd_dashboard():
    return render_template("cicd.html")

@cicd.route("/api/workflows")
def github_workflows():
    token = os.getenv("TOKEN_GITHUB")
    headers = {"Authorization": f"token {token}"} if token else {}
    url = "https://api.github.com/repos/pial-roy/flask-devops/actions/runs"
    try:
        response = requests.get(url, headers=headers)
        return jsonify(response.json()), response.status_code
    except Exception as e:
        return jsonify({"error": str(e)}), 500
