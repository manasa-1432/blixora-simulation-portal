from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector

app = Flask(__name__)
app.secret_key = "your_secret_key"  # Change to something secure

# Database connection function
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",       # Your MySQL username
        password="manasabhanu1432",       # Your MySQL password
        database="blixora" # Your database name
    )

# Home page route
@app.route('/')
def index():
    return render_template("index.html")

# Login route
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE email=%s AND password=%s", (email, password))
        user = cursor.fetchone()
        conn.close()

        if user:
            session['user_id'] = user['id']
            session['name'] = user['name']
            return redirect(url_for('dashboard'))
        else:
            return "Invalid email or password"

    return render_template("login.html")

# Dashboard route
@app.route('/dashboard')
def dashboard():
    if 'user_id' in session:
        return render_template("dashboard.html", name=session['name'])
    return redirect(url_for('login'))

# Browse simulations → home page
@app.route('/home')
def home():
    return render_template("home.html")

# Logout route
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))
@app.route('/register')
def register():
    return render_template('register.html')

if __name__ == '__main__':
    app.run(debug=True)
