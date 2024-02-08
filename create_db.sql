-- DB creation
CREATE DATABASE ig_data_admin;
CREATE USER data_admin WITH ENCRYPTED PASSWORD 'investigamer';
GRANT ALL PRIVILEGES ON DATABASE ig_data_admin TO data_admin;
GRANT USAGE ON SCHEMA public TO data_admin;

-- Creation of the users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    hashed_password VARCHAR(255)
);

-- Creation of the questions table
CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    text TEXT,
    difficulty_level VARCHAR(255),
    risk_factors TEXT,
    question_type VARCHAR(255) -- Can be 'Normal' or 'Edge Case'
);

-- Creation of the user_answers table with foreign keys to users and questions
CREATE TABLE user_answers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    answer_given TEXT,
    is_correct VARCHAR(255)
);


CREATE TABLE learning_paths (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE risk_assessments (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id),
    risk_score INTEGER,
    key_risk_factor VARCHAR(255)
);
