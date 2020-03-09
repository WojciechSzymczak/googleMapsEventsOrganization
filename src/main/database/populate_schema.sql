INSERT INTO users (user_email, user_name, user_pass, user_first_name, user_last_name ) VALUES ('Kowalski@wp.pl', 'kowal', '12345678', 'Jan', 'Kowalski');
INSERT INTO users (user_email, user_name, user_pass, user_first_name, user_last_name ) VALUES ('Nowak@wp.pl', 'nowak', '12345678', 'Arkadiusz', 'Nowak');

INSERT INTO user_roles (user_name, role_name) values ('kowal','admin');
INSERT INTO user_roles (user_name, role_name) values ('nowak','user');