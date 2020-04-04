INSERT INTO c##auth_user.users (user_email, user_name) VALUES ('Kowalski@wp.pl', 'kowal');
INSERT INTO c##auth_user.users (user_email, user_name) VALUES ('Nowak@wp.pl', 'nowak');

INSERT INTO c##auth_user.user_passwords (pass_pass, pass_create_date, pass_immutable_date, pass_expire_date, user_id) VALUES ('12345678', SYSDATE, SYSDATE + 1, SYSDATE + 90, 1);
INSERT INTO c##auth_user.user_passwords (pass_pass, pass_create_date, pass_immutable_date, pass_expire_date, user_id) VALUES ('12345678', SYSDATE, SYSDATE + 1, SYSDATE + 90, 2);
INSERT INTO c##auth_user.user_passwords (pass_pass, pass_create_date, pass_immutable_date, pass_expire_date, user_id) VALUES ('87654321', SYSDATE-10, SYSDATE -9, SYSDATE + 80, 2);
INSERT INTO c##auth_user.user_passwords (pass_pass, pass_create_date, pass_immutable_date, pass_expire_date, user_id) VALUES ('98765432', SYSDATE-20, SYSDATE -19, SYSDATE + 70, 2);
INSERT INTO c##auth_user.user_passwords (pass_pass, pass_create_date, pass_immutable_date, pass_expire_date, user_id) VALUES ('123', SYSDATE-30, SYSDATE -29, SYSDATE + 60, 2);
INSERT INTO c##auth_user.user_passwords (pass_pass, pass_create_date, pass_immutable_date, pass_expire_date, user_id) VALUES ('321', SYSDATE-40, SYSDATE -39, SYSDATE + 50, 2);

UPDATE c##auth_user.user_roles SET role_name='admin' WHERE user_id = 1;

INSERT INTO c##auth_user.user_ip_perm (perm_ip, user_id) VALUES ('localhost', '2');
INSERT INTO c##auth_user.user_ip_perm (perm_ip, user_id) VALUES ('0:0:0:0:0:0:0:1', '2');