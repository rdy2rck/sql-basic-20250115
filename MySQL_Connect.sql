CREATE DATABASE crud;
USE crud;

CREATE TABLE user (
id VARCHAR(20) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
nickname VARCHAR(50) NOT NULL,
CONSTRAINT user_pk PRIMARY KEY (id)
);

INSERT INTO user VALUES ('qwer1234', 'qwer1234', 'qwer1234');

INSERT INTO user VALUES (?, ?, ?);

CREATE TABLE board (
	postNumber INT NOT NULL UNIQUE AUTO_INCREMENT,
    postTitle TEXT NOT NULL,
    postBody TEXT NOT NULL,
    uploadDate DATE NOT NULL,
    authorName VARCHAR(20) NOT NULL,
    
    CONSTRAINT board_pk PRIMARY KEY (postNumber),
    CONSTRAINT board_writer_fk FOREIGN KEY (authorName) REFERENCES user (id)
);

INSERT INTO board (postTitle, postBody, uploadDate, authorName) VALUES (?, ?, CURDATE(), ?);

CREATE VIEW board_view AS
SELECT
B.postNumber board_number,
B.postTitle title,
U.nickname nickname,
B.uploadDate write_date,
B.postBody content
FROM board B INNER JOIN user U
ON B.authorName = U.id;

CREATE TABLE comment (
comment_number INT NOT NULL UNIQUE AUTO_INCREMENT,
board_number INT NOT NULL,
writer_id VARCHAR(20) NOT NULL,
contents TEXT NOT NULL,
write_datetime DATETIME NOT NULL,
status BOOLEAN NOT NULL,
parent_comment INT,

CONSTRAINT comment_pk PRIMARY KEY (comment_number),
CONSTRAINT comment_board_fk FOREIGN KEY (board_number) REFERENCES board (postNumber),
CONSTRAINT comment_user_fk FOREIGN KEY (writer_id) REFERENCES user (id),
CONSTRAINT parent_comment_fk FOREIGN KEY (parent_comment) REFERENCES comment (comment_number)
);

CREATE TABLE favorite (
id VARCHAR(20) NOT NULL,
board_number INT NOT NULL,

CONSTRAINT favorite_pk PRIMARY KEY (id, board_number),
CONSTRAINT favorite_user_fk FOREIGN KEY (id) REFERENCES user (id),
CONSTRAINT favorite_board_fk FOREIGN KEY (board_number) REFERENCES board (postNumber)
);

INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ("Qwer", 1, "qwer1234", now(), true, null);

INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ("자식댓글 1", 3, "qwer1234", now(), true, 1);

INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ("자식댓글 2", 1, "qwer1234", now(), true, 1);

INSERT INTO comment (contents, board_number, writer_id, write_datetime, status, parent_comment)
VALUES ("자식댓글 2-1", 1, "qwer1234", now(), true, 3);

SELECT * FROM comment;

UPDATE comment SET status = false WHERE comment_number = 2;

DELETE FROM comment WHERE comment_number = 2;

SELECT * FROM  favorite WHERE id = "qwer1234" AND board_number = 3;

INSERT INTO favorite VALUES ("qwer1234", 3);

DELETE FROM favorite WHERE id = "qwer1234" AND board_number = 3;

SELECT board_number, COUNT(*) count FROM comment
WHERE board_number = 3
GROUP BY board_number;

SELECT COUNT(*) FROM favorite
WHERE board_number = 3
GROUP BY board_number;

SELECT
C.board_number 'board_number',
C.count 'comment_count',
F.count 'favorite_count'
FROM
(
SELECT board_number, COUNT(*) count FROM comment
WHERE board_number = 3
GROUP BY board_number
) C
LEFT JOIN
(
SELECT board_number, COUNT(*) count FROM favorite
WHERE board_number =3
GROUP BY board_number
) F
ON C.board_number = F.board_number;