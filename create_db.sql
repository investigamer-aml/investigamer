-- DB creation
CREATE DATABASE ig_data_admin;
CREATE USER data_admin WITH ENCRYPTED PASSWORD 'investigamer';
create schema public;
GRANT ALL PRIVILEGES ON DATABASE ig_data_admin TO data_admin;
GRANT USAGE ON SCHEMA public TO data_admin;

--drop schema public cascade;

-- Creation of the users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY
,   username VARCHAR(255)
,   email VARCHAR(255) UNIQUE
,   hashed_password VARCHAR(255)
,   use_case_difficulty varchar
,   score float
);

-- Creation of the questions table
CREATE TABLE use_cases (
    id SERIAL PRIMARY KEY
,   description TEXT
,   type VARCHAR(255)
,   difficulty TEXT
,   multiple_risks boolean
,   correct_answer text
,   final_decision text
,   risk_factor_matrix_id INTEGER
,   lesson_id INTEGER
);

-- Creation of the user_answers table with foreign keys to users and questions
CREATE TABLE user_answers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    use_case_id INTEGER REFERENCES use_cases(id) ON DELETE CASCADE,
    answer_given TEXT,
    is_correct boolean
);


CREATE TABLE learning_paths (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(255),
    description TEXT
);


create table risk_factor_matrix (
  id serial primary key
, factor varchar
, score integer
, use_case_id INTEGER REFERENCES use_cases(id) ON DELETE CASCADE
);

create table lessons  (
  id serial primary key
, title text
);


create table questions (
  id serial primary key
, use_case_id INTEGER REFERENCES use_cases(id) ON DELETE CASCADE
, text  text
);

create table options (
  id serial primary key
, question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE
, text  text
, is_correct boolean
)
--
--
--
--select u.*
--from   use_cases u
--
--
--
--select * from users
--
--where  u.difficulty in (
--         select difficulty
--         from   use_cases
--       )
--  and  u.id not in (
--         select use_case_id
--         from   user_answers
--         where  user_answers.is_correct = true
--       )
--   order by random() desc
--    limit 1;
--
--
--
--   SELECT *
--    FROM use_cases
--
--
--    insert into use_cases
--    (id, description, type, difficulty, multiple_risks, correct_answer, final_decision, risk_factor_matrix_id, lesson_id)
--    values(2, 'case 2', 'KYC', 'Easy', true, 'They operate in various jurisdictions across Europe, the Middle East, and Asia.', 'Ignore', 2, 1)
--
--
--
-- commit;
--