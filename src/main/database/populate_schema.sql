INSERT INTO c##auth_user.users (user_email, user_name, user_pass) VALUES ('Kowalski@wp.pl', 'kowal', '12345678');
INSERT INTO c##auth_user.users (user_email, user_name, user_pass) VALUES ('Nowak@wp.pl', 'nowak', '12345678');

UPDATE c##auth_user.user_roles SET role_name='admin' WHERE user_id = 1;

INSERT INTO c##auth_user.user_ip_perm (perm_ip, user_id) VALUES ('localhost', '2');
INSERT INTO c##auth_user.user_ip_perm (perm_ip, user_id) VALUES ('0:0:0:0:0:0:0:1', '2');