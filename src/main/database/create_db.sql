CREATE DATABASE events;

USE events;

DROP TABLE events;
DROP TABLE user_roles;
DROP TABLE users;

DROP TRIGGER set_user_role_when_registering;

DROP PROCEDURE add_event;

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

CREATE TABLE events(

	event_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	event_name VARCHAR(255) NOT NULL UNIQUE,
	event_start_date DATETIME,
	event_longitude DOUBLE(18,15),
	event_latitude DOUBLE(17,15),
	event_description TEXT,
	user_id BIGINT,
        FOREIGN KEY (user_id) REFERENCES users(user_id)

);

CREATE TRIGGER set_user_role_when_registering
AFTER INSERT ON users
FOR EACH ROW
    INSERT INTO user_roles(user_name, role_name) VALUES (NEW.user_name, 'user');

DELIMITER$$
CREATE PROCEDURE add_event(IN event_name VARCHAR(255),IN event_start_date DATETIME,IN event_longitude DOUBLE,IN event_latitude DOUBLE, IN user_id BIGINT,IN event_description TEXT)
BEGIN
    insert into events.events (event_name,event_start_date,event_longitude,event_latitude,user_id,event_description) values (event_name,event_start_date,event_longitude,event_latitude,user_id,event_description);
END$$
DELIMITER;