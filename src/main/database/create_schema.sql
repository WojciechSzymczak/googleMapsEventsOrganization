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

CREATE OR REPLACE PACKAGE C##AUTH_USER.USER_PACKAGE AS
    PROCEDURE authenticate_user(
         user_name IN VARCHAR
       , user_pass IN VARCHAR
       , res_code OUT NUMBER
       , res_msg OUT VARCHAR
       , user_id OUT NUMBER
       , user_email OUT VARCHAR 
       , user_role OUT VARCHAR);
END USER_PACKAGE;
/

CREATE OR REPLACE PACKAGE BODY c##auth_user.USER_PACKAGE AS
    PROCEDURE authenticate_user(
         user_name IN VARCHAR
       , user_pass IN VARCHAR
       , res_code OUT NUMBER
       , res_msg OUT VARCHAR
       , user_id OUT NUMBER
       , user_email OUT VARCHAR 
       , user_role OUT VARCHAR) IS
    wrong_credentials EXCEPTION;
    user_rec c##auth_user.users%ROWTYPE;
    CURSOR user_cur RETURN c##auth_user.users%ROWTYPE IS
    SELECT * FROM c##auth_user.users u 
    WHERE TRIM(u.user_name) = authenticate_user.user_name
    AND TRIM(u.user_pass) = authenticate_user.user_pass;
    BEGIN    
        OPEN user_cur;    
        LOOP
            FETCH user_cur INTO user_rec;
            EXIT WHEN user_cur%NOTFOUND;
        END LOOP;
        
        IF user_cur%ROWCOUNT = 0 THEN
            CLOSE user_cur;
            RAISE wrong_credentials;
        ELSE            
            CLOSE user_cur;
            authenticate_user.res_code := 1;
            authenticate_user.res_msg := 'User successfully authenticated.';
            authenticate_user.user_id := user_rec.user_id;
            authenticate_user.user_email := user_rec.user_email;
            SELECT role_name 
            INTO authenticate_user.user_role 
            FROM c##auth_user.user_roles ur
            WHERE ur.user_id = user_rec.user_id;
        END IF;
        
        EXCEPTION
            WHEN wrong_credentials THEN
                authenticate_user.res_code := 0;
                authenticate_user.res_msg := 'Wrong credentials.';
    END authenticate_user;
END USER_PACKAGE;