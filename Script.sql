SELECT
	version();

CREATE SCHEMA telegram;

USE telegram;

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






