INSERT INTO c##auth_user.users (user_email, user_name, user_pass) VALUES ('Kowalski@wp.pl', 'kowal', '12345678');
INSERT INTO c##auth_user.users (user_email, user_name, user_pass) VALUES ('Nowak@wp.pl', 'nowak', '12345678');

UPDATE c##auth_user.user_roles SET role_name='admin' WHERE user_id = 1;

INSERT INTO c##auth_user.users_actions (action_date, action_name, user_id) VALUES (to_date('2020-01-03 12:32:11', 'YYYY-MM-DD HH24:MI:SS'), 'Successfull authentication.', 2);
INSERT INTO c##auth_user.users_actions (action_date, action_name, user_id) VALUES (to_date('2020-01-02 11:32:11', 'YYYY-MM-DD HH24:MI:SS'), 'Unsuccessfull authentication.', 2);
INSERT INTO c##auth_user.users_actions (action_date, action_name, user_id) VALUES (to_date('2020-01-01 8:32:11', 'YYYY-MM-DD HH24:MI:SS'), 'Log out.', 2);