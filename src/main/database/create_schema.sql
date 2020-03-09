CREATE DATABASE authorization_app;

USE authorization_app;

DROP TABLE user_roles;
DROP TABLE users;

CREATE TABLE users(

	user_id BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	user_email VARCHAR(255) NOT NULL UNIQUE,
	user_name VARCHAR(255) NOT NULL UNIQUE,
	user_pass CHAR(64) NOT NULL,
	user_join_date DATETIME,
	user_birth_date DATE,
	user_first_name VARCHAR(255),
	user_last_name VARCHAR(255)

);

CREATE TABLE user_roles (
  user_name VARCHAR(255) PRIMARY KEY NOT NULL,
  role_name VARCHAR(15) NOT NULL
);

CREATE TRIGGER set_user_role_when_registering
AFTER INSERT ON users
FOR EACH ROW
    INSERT INTO user_roles(user_name, role_name) VALUES (NEW.user_name, 'user');