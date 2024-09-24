CREATE DATABASE reports;

USE reports;

CREATE TABLE reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    location VARCHAR(255),
    media VARCHAR(255),
    verified BOOLEAN,
    user_id INT,
    date_submitted DATETIME,
    status VARCHAR(50),
    email VARCHAR(255)
);
