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

CREATE TABLE c##auth_user.users_actions(
	action_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	action_date DATE NOT NULL,
	action_name VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,
    CONSTRAINT fk_action_user_id
    FOREIGN KEY (user_id)
    REFERENCES c##auth_user.users(user_id)
);

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
    PROCEDURE get_user_actions(
         user_id IN INTEGER
       , actions_cursor OUT SYS_REFCURSOR);
    PROCEDURE add_user_action(
         user_id IN INTEGER
       , action_name IN VARCHAR);
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
            c##auth_user.USER_PACKAGE.add_user_action(user_rec.user_id, 'Authentication.');
        END IF;
        
        EXCEPTION
            WHEN wrong_credentials THEN
                authenticate_user.res_code := 0;
                authenticate_user.res_msg := 'Wrong credentials.';
    END authenticate_user;
    PROCEDURE get_user_actions(
         user_id IN INTEGER
       , actions_cursor OUT SYS_REFCURSOR) IS
    BEGIN    
        OPEN actions_cursor FOR
        SELECT ACTION_ID, ACTION_DATE, ACTION_NAME, USER_ID
        FROM c##auth_user.users_actions ua
        WHERE ua.user_id = get_user_actions.user_id
        ORDER BY ua.action_date;
    END get_user_actions;
    PROCEDURE add_user_action(
         user_id IN INTEGER
       , action_name IN VARCHAR) IS
     BEGIN
        INSERT INTO c##auth_user.users_actions(action_date, action_name, user_id) VALUES (SYSDATE, add_user_action.action_name, add_user_action.user_id);
     END add_user_action;
END USER_PACKAGE;