SELECT
	version();

CREATE SCHEMA telegram;

USE telegram;
DROP TABLE users; 

CREATE TABLE users(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname varchar(100),
	lastname varchar(100) COMMENT 'фамилия',
	login varchar(100),
	email varchar(100) UNIQUE,
	password_hash varchar(256),
	phone bigint UNSIGNED UNIQUE, 
	
	INDEX idx_users_username(firstname, lastname)
	) COMMENT 'пользователи'; 

use telegram;

#DROP TABLE IF EXISTS user_settings;
CREATE TABLE user_settings(
	user_id bigint UNSIGNED NOT NULL,
	is_premium bit,
	is_night_mode_enabled bit,
	color_scheme enum('classic', 'day', 'tinted', 'night'),
	LANGUAGE enum('english', 'french', 'russian', 'german', 'belorussian', 'croatian','dutch'),
	status_text varchar(70),
	notifications_and_sounds JSON,
	created_at datetime DEFAULT NOW()
);


ALTER TABLE user_settings ADD CONSTRAINT fk_user_settings_user_id
FOREIGN KEY (user_id) REFERENCES users(id)
ON UPDATE CASCADE 
ON DELETE RESTRICT;

USE telegram;
ALTER TABLE users ADD COLUMN birthday datetime;
ALTER TABLE users MODIFY COLUMN birthday date;
#ALTER TABLE users RENAME COLUMN birthday TO date_of_birth;
#ALTER TABLE users DROP COLUMN date_of_birth;

#1 x M
#DROP TABLE IF EXISTS  private_messages;
CREATE TABLE privat_messages(
	id SERIAL,
	sender_id bigint UNSIGNED NOT NULL,
	receiver_id bigint UNSIGNED NOT NULL,
	media_type enum('text', 'image', 'audio', 'video'),
	body text,
	filename varchar(200),
	created_at datetime DEFAULT NOW(),
	
	FOREIGN KEY (sender_id) REFERENCES users(id),
	FOREIGN KEY (receiver_id) REFERENCES users(id)
	); 
	
	ALTER TABLE user_settings MODIFY COLUMN  user_id bigint UNSIGNED NOT NULL PRIMARY KEY;  
	
	ALTER TABLE user_settings 
	RENAME  COLUMN  LANGUAGE TO app_language;


