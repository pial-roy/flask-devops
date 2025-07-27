from flask import Flask
from main.routes import main
from contact.routes import contact

app = Flask(__name__)
app.secret_key = "devops-is-awesome"

app.register_blueprint(main)
app.register_blueprint(contact)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
