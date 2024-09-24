from flask import Flask, request, jsonify
from flask_cors import CORS
import MySQLdb
from datetime import datetime

app = Flask(__name__)
CORS(app)

# Connect to MariaDB
def get_db_connection():
    connection = MySQLdb.connect(
        host="localhost",
        user="ondul",  
        passwd="o",
        db="reports"
    )
    return connection

# Route to handle report submission
@app.route('/submit-report', methods=['POST'])
def submit_report():
    data = request.json
    title = data.get('title')
    description = data.get('description')
    location = data.get('location')
    media = data.get('media') 
    verified = data.get('verified')
    user_id = data.get('user_id')
    date_submitted = data.get('date_submitted')
    status = data.get('status')
    email = data.get('email')

    # Insert into the database
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute(
        'INSERT INTO reports (title, description, location, media, verified, user_id, date_submitted, status, email) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)',
        (title, description, location, media, verified, user_id, date_submitted, status, email)
    )
    connection.commit()
    cursor.close()
    connection.close()

    return jsonify({'message': 'Report submitted successfully'}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
