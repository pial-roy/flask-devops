#!/bin/bash

mkdir -p main contact templates static

# app.py
cat <<PY > app.py
from flask import Flask
from main.routes import main
from contact.routes import contact

app = Flask(__name__)
app.secret_key = "devops-is-awesome"

app.register_blueprint(main)
app.register_blueprint(contact)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
PY

# main blueprint
cat <<PY > main/__init__.py
# Placeholder for main blueprint
PY

cat <<PY > main/routes.py
from flask import Blueprint, render_template

main = Blueprint('main', __name__)

@main.route('/')
def home():
    return render_template("index.html")
PY

# contact blueprint
cat <<PY > contact/__init__.py
# Placeholder for contact blueprint
PY

cat <<PY > contact/routes.py
from flask import Blueprint, render_template, request, flash, redirect

contact = Blueprint('contact', __name__)

@contact.route('/contact', methods=["GET", "POST"])
def contact_form():
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        message = request.form.get("message")
        print(f"[Contact] Name: {name}, Email: {email}, Message: {message}")
        flash("Thanks for reaching out! I’ll get back to you soon.")
        return redirect("/contact")
    return render_template("contact.html")
PY

# templates/index.html
cat <<HTML > templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Pial Roy | DevOps Engineer</title>
  <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
</head>
<body>
  <div class="container">
    <header>
      <h1>Pial Roy</h1>
      <p class="title">DevOps Engineer</p>
      <p class="subtitle">Containerized for smooth delivery 🚀</p>
    </header>

    <nav>
      <a href="/">Home</a>
      <a href="/contact">Contact Me</a>
    </nav>

    <section class="summary">
      <h2>Professional Summary</h2>
      <p>
        I am a DevOps Engineer with over 3 years of experience in CI/CD pipeline design,
        automation, and infrastructure monitoring. Proficient in Docker, AWS, Jenkins, Python scripting.
      </p>
    </section>

    <section class="skills">
      <h2>Skills</h2>
      <p>AWS, Docker, Jenkins, Bash, Terraform, Ansible, Kubernetes, Python, CI/CD, Monitoring, SQL, Linux</p>
    </section>

    <section class="experience">
      <h2>Experience</h2>
      <h3>Persistent Systems (DevOps Engineer)</h3>
      <ul>
        <li>Built Jenkins CI/CD pipelines, reduced build times by 40%</li>
        <li>Created Docker images for microservices</li>
        <li>Automated deployments with Bash, Python, cron</li>
      </ul>
    </section>

    <section class="education">
      <h2>Education</h2>
      <p>B.Tech in Computer Science, MAKAUT (2022)</p>
    </section>

    <footer>
      <p>Made with 💻 by Pial Roy | <span class="docker-hint">Smooth as a container ship.</span></p>
    </footer>
  </div>
</body>
</html>
HTML

# templates/contact.html
cat <<HTML > templates/contact.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Pial Roy</title>
  <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
</head>
<body>
  <div class="container">
    <header>
      <h1>Contact Me</h1>
      <p class="subtitle">Let's build something reliable together.</p>
    </header>

    <nav>
      <a href="/">Home</a>
      <a href="/contact">Contact Me</a>
    </nav>

    {% with messages = get_flashed_messages() %}
      {% if messages %}
        <div class="flash">
          {% for msg in messages %}
            <p>{{ msg }}</p>
          {% endfor %}
        </div>
      {% endif %}
    {% endwith %}

    <form method="POST">
      <label>Your Name</label>
      <input type="text" name="name" required>

      <label>Your Email</label>
      <input type="email" name="email" required>

      <label>Your Message</label>
      <textarea name="message" rows="5" required></textarea>

      <button type="submit">Send</button>
    </form>

    <p class="email-hint">Or email me directly at <strong>pialroy31416@gmail.com</strong></p>

    <footer>
      <p>Made with 💻 by Pial Roy | <span class="docker-hint">Powered by isolated services.</span></p>
    </footer>
  </div>
</body>
</html>
HTML

# static/style.css
cat <<CSS > static/style.css
body {
  font-family: 'Segoe UI', sans-serif;
  background: #f9f9f9;
  margin: 0;
  padding: 0;
}

.container {
  max-width: 800px;
  margin: auto;
  background: #fff;
  padding: 30px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  margin-top: 30px;
}

header {
  text-align: center;
}

h1 {
  margin: 0;
  color: #222;
}

.subtitle {
  color: #007bff;
  font-style: italic;
}

nav {
  margin: 20px 0;
  text-align: center;
}

nav a {
  margin: 0 15px;
  text-decoration: none;
  color: #007bff;
  font-weight: bold;
}

section {
  margin-top: 30px;
}

section h2 {
  color: #333;
  border-left: 5px solid #007bff;
  padding-left: 10px;
}

ul {
  padding-left: 20px;
}

footer {
  text-align: center;
  margin-top: 50px;
  color: #888;
  font-size: 0.9em;
}

.docker-hint {
  color: #008cba;
  font-style: italic;
}

form {
  display: flex;
  flex-direction: column;
}

form label {
  margin: 10px 0 5px;
}

form input, form textarea {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

form button {
  margin-top: 15px;
  padding: 10px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.flash {
  background-color: #d4edda;
  color: #155724;
  padding: 10px;
  margin-top: 20px;
  border-left: 5px solid #28a745;
}

.email-hint {
  margin-top: 20px;
  font-size: 0.9em;
  color: #555;
}
CSS

echo "✅ Setup complete. Run with: python app.py"
