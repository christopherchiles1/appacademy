DROP TABLE IF EXISTS users;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  author_id INTEGER REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  question_id INTEGER REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER REFERENCES questions(id) NOT NULL,
  parent_id INTEGER REFERENCES replies(id),
  user_id INTEGER REFERENCES users(id),
  body TEXT
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  question_id INTEGER REFERENCES questions(id)
);

-- Seed data

INSERT INTO
  users(fname, lname)
VALUES
  ('Charles', 'McDonny'),
  ('David', 'Porter'),
  ('Chris', 'Chiles'),
  ('Eric', 'Schwarnzbach');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('How hot is the sun?',
    'I think its 40000',
    2
  ),
  ('How tall is Eric?',
    'Because reasons',
    3
  );

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 1),
  (4, 2),
  (2, 2);

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (2, 2),
  (3, 1),
  (1,1);

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 4, 'Its 9941 fahrenheit. Learn to google.'),
  (1, 1, 2, 'Thanks Eric.'),
  (2, NULL, 1, '7 feet tall');
