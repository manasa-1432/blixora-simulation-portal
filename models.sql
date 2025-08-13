CREATE DATABASE IF NOT EXISTS blixora;
USE blixora;

-- USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email, password, role)
VALUES 
('Test User', 'user@example.com', '12345', 'user'),
('Admin User', 'admin@example.com', 'admin123', 'admin');

-- SIMULATIONS TABLE
CREATE TABLE IF NOT EXISTS simulations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    difficulty ENUM('Beginner', 'Intermediate', 'Advanced'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO simulations (title, description, difficulty)
VALUES
('AI Basics', 'Introduction to Artificial Intelligence concepts.', 'Beginner'),
('Cybersecurity Lab', 'Hands-on cybersecurity simulations.', 'Intermediate'),
('Cloud Deployment', 'Deploying scalable applications on the cloud.', 'Advanced');

-- ENROLLMENTS TABLE
CREATE TABLE IF NOT EXISTS enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    simulation_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (simulation_id) REFERENCES simulations(id) ON DELETE CASCADE
);

