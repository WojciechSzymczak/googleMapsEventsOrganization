CREATE TABLE c##auth_user.users(
	user_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	user_email VARCHAR(255) NOT NULL UNIQUE,
	user_name VARCHAR(255) NOT NULL UNIQUE,
	user_pass CHAR(64) NOT NULL,
    user_auth_blocked_until TIMESTAMP
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

CREATE TABLE c##auth_user.user_auth_attempt (
    attempt_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    attempt_date TIMESTAMP NOT NULL,
    user_id INTEGER,
    CONSTRAINT fk_user_attempt
    FOREIGN KEY (user_id)
    REFERENCES c##auth_user.users(user_id)
);
/

CREATE TABLE c##auth_user.user_ip_perm (
    perm_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    perm_ip VARCHAR(32),
    user_id INTEGER,
    CONSTRAINT fk_user_ip_perm
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
    PROCEDURE get_user_actions(
         user_id IN INTEGER
       , actions_cursor OUT SYS_REFCURSOR);
    PROCEDURE add_user_action(
         user_id IN INTEGER
       , action_name IN VARCHAR);
    PROCEDURE add_auth_attempt(
         user_name IN VARCHAR);
    PROCEDURE get_user_ip_permits(
         user_id IN INTEGER
       , permits_cursor OUT SYS_REFCURSOR);
    PROCEDURE add_user_ip_permit(
         user_id IN INTEGER
       , permit_ip IN VARCHAR       
       , res_code OUT INTEGER
       , res_msg OUT VARCHAR);
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
    user_auth_blocked EXCEPTION;
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
            IF user_rec.user_auth_blocked_until > SYSDATE THEN
                RAISE user_auth_blocked;
            END IF;
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
                authenticate_user.res_msg := 'Wrong credentials. Please try again.';
                c##auth_user.USER_PACKAGE.add_auth_attempt(authenticate_user.user_name);
            WHEN user_auth_blocked THEN
                authenticate_user.res_code := 2;
                authenticate_user.res_msg := 'Too many failed authentication attempts. User authentication blocked until: ' || user_rec.user_auth_blocked_until || '.';
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
    PROCEDURE add_auth_attempt(
         user_name IN VARCHAR) IS
         user_rec c##auth_user.users%ROWTYPE;
         attempt_count INTEGER;
    BEGIN
        SELECT * INTO user_rec FROM c##auth_user.users u WHERE u.user_name = add_auth_attempt.user_name;
        IF user_rec.user_id IS NOT NULL THEN
            INSERT INTO c##auth_user.user_auth_attempt(attempt_date, user_id) VALUES(SYSTIMESTAMP, user_rec.user_id);
        END IF;
        SELECT COUNT(*) INTO add_auth_attempt.attempt_count FROM c##auth_user.user_auth_attempt uaa WHERE uaa.user_id = user_rec.user_id AND uaa.attempt_date > (SYSDATE - (1/1440*5));
        IF attempt_count >= 3 THEN
            UPDATE c##auth_user.users u SET u.user_auth_blocked_until = (SYSDATE + (1/1440*5)) WHERE u.user_id = user_rec.user_id;
        END IF;    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('User: ' || add_auth_attempt.user_name || ' not found.');
    END add_auth_attempt;
    PROCEDURE get_user_ip_permits(
         user_id IN INTEGER
       , permits_cursor OUT SYS_REFCURSOR) IS       
    BEGIN
        OPEN permits_cursor FOR
        SELECT uip.PERM_ID, uip.PERM_IP, uip.USER_ID 
        FROM c##auth_user.user_ip_perm uip
        WHERE uip.user_id = get_user_ip_permits.user_id
        ORDER BY uip.perm_id;
    END get_user_ip_permits;    
    PROCEDURE add_user_ip_permit(
         user_id IN INTEGER
       , permit_ip IN VARCHAR       
       , res_code OUT INTEGER
       , res_msg OUT VARCHAR) IS
       user_not_found EXCEPTION;
       user_count INTEGER;
     BEGIN
        SELECT COUNT(*) INTO user_count FROM c##auth_user.users u WHERE u.user_id = add_user_ip_permit.user_id;
        IF user_count = 0 THEN
            RAISE user_not_found;
        END IF;
        INSERT INTO c##auth_user.user_ip_perm (perm_ip, user_id) VALUES(add_user_ip_permit.permit_ip, add_user_ip_permit.user_id);        
        add_user_ip_permit.res_code := 1;
        add_user_ip_permit.res_msg := 'Permit added.';
        EXCEPTION
            WHEN user_not_found THEN
                add_user_ip_permit.res_code := 0;
                add_user_ip_permit.res_msg := 'Permit not added. Please contact support.';
     END add_user_ip_permit;
END USER_PACKAGE;