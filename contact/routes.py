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
