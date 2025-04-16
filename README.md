# Social_Justice_and_Reform_Hackathon
Many African nations are grappling with urgent socio-political challenges. The recent wave of youth-led protests underscores a deep-seated discontent with leadership, economic inequality, and a perceived lack of accountability.


Therefore, i took part in this issue by coming up with atleast one solution to help curb some of the factors causing this issue using flutter.

The application will have several features but below are the major ones to be implemented.

Real-Time Reporting:
Citizens can report issues (e.g., corruption, service delivery failures, or human rights abuses) directly through the app.

Crowdsourced Accountability:
Users can upvote/downvote reports to prioritize the most critical issues.

Community Forum:
Safe, moderated space for citizens to discuss ongoing socio-political issues.
Users can raise awareness about specific problems and suggest local solutions.

Educational Resources:
Provide access to information about civic rights, legal frameworks, and how to engage in peaceful activism.

Policy Tracking:
Track political promises, legislation, and reforms made by leaders.

Youth Empowerment:
Dedicated section for youth to connect, propose solutions and mobilize around socio-political causes.
Mentorship and leadership programs to channel the energy of protests into constructive activism.

Push Notifications & Alerts:
Real-time alerts for important policy changes, government statements and protests.

Anonymous Feedback:
Anonymity options to protect users in authoritarian contexts where speaking out can be dangerous.

Volunteer & Donation Opportunities:
Connect users with local NGOs and grassroots movements working on the issues they care about.


###How to run###

Prerequisites
Before starting, make sure you have the following installed:

1. Backend Requirements:
	Python 3.x: For running the Flask backend.
	Flask: A lightweight Python framework for web applications.
	MariaDB or MySQL: The database to store the corruption reports.
	Flask Extensions:
	flask
	flask-cors
	flask-mysqldb
	flask-wtf


2. Frontend Requirements:
	Flutter SDK: For building and running the Flutter app.
	

Step-by-Step Setup

Backend Setup (Flask + MariaDB)

Step 1: Install Python and Flask
Install Python: If Python is not already installed.
Install Flask and Required Extensions: 
Open a terminal and run the following commands: (pip install Flask flask-cors flask-mysqldb flask-wtf)


Step 2: Set Up MariaDB
Install MariaDB: Follow the instructions from MariaDB Downloads or use the command for Linux: 
(sudo apt install mariadb-server)

Create a Database: Open the MariaDB shell: 
(sudo mysql -u root -p) or this:  /usr/bin/mariadb -u ondul -p

Create the database and table:

CREATE DATABASE reports_db;

USE reports_db;

CREATE TABLE reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    location VARCHAR(255),
    media VARCHAR(255),
    verified BOOLEAN DEFAULT FALSE,
    status VARCHAR(50),
    user_id INT,
    date_submitted TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


Step 3: run the flask server: (python3 app.py)

In the terminal, navigate to the Flutter project directory and run: (flutter run)


