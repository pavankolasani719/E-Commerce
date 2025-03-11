from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://admin:password@postgres_db:5432/ecommerce'
db = SQLAlchemy(app)

# Ensure the app runs within the application context
with app.app_context():
    db.create_all()  # Ensures tables are created at startup

@app.route("/")
def home():
    return "Ecommerce Backend Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
