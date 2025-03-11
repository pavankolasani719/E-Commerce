from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://admin:password@postgres_db:5432/ecommerce'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Avoids unnecessary overhead
db = SQLAlchemy(app)

# Import models after db initialization to avoid circular imports
from app.models import Product  # Ensure you have models defined in app/models.py

# Ensure the app runs within the application context
with app.app_context():
    db.create_all()  # Creates database tables if they do not exist

@app.route("/")
def home():
    return "Ecommerce Backend Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
