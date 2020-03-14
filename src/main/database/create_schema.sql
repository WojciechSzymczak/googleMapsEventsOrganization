CREATE TABLE c##auth_user.users(
	user_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	user_email VARCHAR(255) NOT NULL UNIQUE,
	user_name VARCHAR(255) NOT NULL UNIQUE,
	user_pass CHAR(64) NOT NULL
);
/

CREATE TABLE c##auth_user.user_roles (
  user_role_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INTEGER NOT NULL,
  role_name VARCHAR(15) NOT NULL,
  CONSTRAINT fk_user
  FOREIGN KEY (user_id)
  REFERENCES c##auth_user.users(user_id)
);
/

CREATE OR REPLACE TRIGGER c##auth_user.set_user_role_when_registering
AFTER INSERT ON c##auth_user.users
FOR EACH ROW
BEGIN
    INSERT INTO c##auth_user.user_roles(user_id, role_name) VALUES (:NEW.user_id, 'user');
END;
/

--TODO fix procedure - authenticate_user
CREATE OR REPLACE PACKAGE C##AUTH_USER.USER_PACKAGE AS
    PROCEDURE authenticate_user(
         user_name IN VARCHAR
       , user_pass IN VARCHAR
       , res_code OUT NUMBER
       , res_msg OUT VARCHAR
       , user_id OUT NUMBER
       , user_email OUT VARCHAR );
END USER_PACKAGE;
/

CREATE OR REPLACE PACKAGE BODY c##auth_user.USER_PACKAGE AS
    PROCEDURE authenticate_user(
         user_name IN VARCHAR
       , user_pass IN VARCHAR
       , res_code OUT NUMBER
       , res_msg OUT VARCHAR
       , user_id OUT NUMBER
       , user_email OUT VARCHAR ) IS
    user_rec c##auth_user.users%ROWTYPE;
    BEGIN
        SELECT * INTO user_rec
        FROM c##auth_user.users U
        WHERE U.user_name LIKE authenticate_user.user_name
          AND U.user_pass LIKE authenticate_user.user_pass
          AND ROWNUM <= 1;
        authenticate_user.res_code := 1;
        authenticate_user.res_msg := 'SUCCESS';
        authenticate_user.user_id := user_rec.user_id;
        authenticate_user.user_email := user_rec.user_email;
    END;
END USER_PACKAGE;