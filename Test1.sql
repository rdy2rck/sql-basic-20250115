CREATE DATABASE board;

USE board;

CREATE TABLE user(
email VARCHAR(50) NOT NULL,
password VARCHAR(100) NOT NULL,
nickname VARCHAR(20) NOT NULL UNIQUE,
tel_number VARCHAR(15) NOT NULL UNIQUE,
address TEXT NOT NULL,
address_detail TEXT,
profile_image TEXT,
agreed_personal TINYINT NOT NULL,
CONSTRAINT user_pk PRIMARY KEY (email)
);

CREATE TABLE board (
board_number INT NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
contents TEXT NOT NULL,
write_datetime DATETIME NOT NULL DEFAULT now(),
favorite_count INT NOT NULL DEFAULT 0,
comment_count INT NOT NULL DEFAULT 0,
view_count INT NOT NULL DEFAULT 0,
writer_email VARCHAR(50) NOT NULL,
CONSTRAINT board_pk PRIMARY KEY (board_number),
CONSTRAINT writer FOREIGN KEY board (writer_email) REFERENCES user (email) ON DELETE CASCADE
);

CREATE TABLE comment (
comment_number INT NOT NULL AUTO_INCREMENT,
contents TEXT NOT NULL,
write_datetime DATETIME NOT NULL DEFAULT now(),
user_email VARCHAR(50) NOT NULL,
board_number INT NOT NULL,
CONSTRAINT comment_pk PRIMARY KEY (comment_number),
CONSTRAINT writer FOREIGN KEY (user_email) REFERENCES user (email)  ON DELETE CASCADE,
CONSTRAINT board_comment FOREIGN KEY (board_number) REFERENCES board (board_number) ON DELETE CASCADE
);

CREATE TABLE favorite (
user_email VARCHAR(50) NOT NULL,
board_board_number INT NOT NULL,
CONSTRAINT user_favorite FOREIGN KEY (user_email) REFERENCES user (email)  ON DELETE CASCADE,
CONSTRAINT board_favorite FOREIGN KEY (board_board_number) REFERENCES board (board_number)  ON DELETE CASCADE,
PRIMARY KEY (user_email, board_board_number)
);

CREATE TABLE board_image(
sequence INT NOT NULL AUTO_INCREMENT,
board_number INT NOT NULL,
image_url TEXT,
CONSTRAINT board_image_pk PRIMARY KEY (sequence),
CONSTRAINT board_image FOREIGN KEY (board_number) REFERENCES board (board_number)  ON DELETE CASCADE
);

CREATE TABLE search_log (
sequence INT NOT NULL AUTO_INCREMENT,
search_word TEXT NOT NULL,
relation_word TEXT,
relation TINYINT NOT NULL,
CONSTRAINT search_log_pk PRIMARY KEY (sequence)
);