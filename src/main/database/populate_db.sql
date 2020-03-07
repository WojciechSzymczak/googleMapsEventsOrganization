INSERT INTO users (user_email, user_name, user_pass, user_first_name, user_last_name ) VALUES ('Kowalski@wp.pl', 'kowal', 'haslo123', 'Jan', 'Kowalski');
INSERT INTO users (user_email, user_name, user_pass, user_first_name, user_last_name ) VALUES ('Nowak@wp.pl', 'nowak', 'haslo123', 'Arkadiusz', 'Nowak');

INSERT INTO user_roles (user_name, role_name) values ('kowal','admin');
INSERT INTO user_roles (user_name, role_name) values ('nowak','user');

INSERT INTO events (event_name, event_start_date, event_longitude, event_latitude, event_description, user_id)
values ('ExampleEvent1', '2018-03-23 12:43:00.000', 19.462163109570383, 51.76052351509456, 'ExampleEvent1Description', 2);
INSERT INTO events (event_name, event_start_date, event_longitude, event_latitude, event_description, user_id)
values ('ExampleEvent2', '2018-03-21 12:30:00.000', 18.462163109570383, 52.76052351509456, 'ExampleEvent2Description', 2);
INSERT INTO events (event_name, event_start_date, event_longitude, event_latitude, event_description, user_id)
values ('ExampleEvent3', '2019-05-23 15:22:00.000', 17.462163109570383, 53.76052351509456, 'ExampleEvent3Description', 2);