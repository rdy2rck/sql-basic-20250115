CREATE DATABASE test;

USE test;

-- 1. 사용자로부터 이메일(email) : 'email@email.com', 패스워드(password)
-- : 'P!ssw0rd', 닉네임(nickanme) : 'rose', 전화번호(tel_number) :
-- '010-1234-5678', 주소(address) : '부산광역시 사하구',
-- 주소상세(address_detail) : '낙동대로', 개인정보 수집 동의(agreed_personal):
-- true 를 입력받아 user 테이블에 삽입하는 SQL을 작성하시오.
CREATE TABLE user (
email VARCHAR(200) NOT NULL UNIQUE,
password VARCHAR(50) NOT NULL ,
nickname VARCHAR(30) NOT NULL,
tel_number VARCHAR(30),
address TEXT NOT NULL,
address_detail TEXT NOT NULL,
agreed_personal BOOLEAN NOT NULL,
CONSTRAINT user_pk PRIMARY KEY (email)
);

INSERT INTO user VALUES ('email@email.com', 'P!ssw0rd', 'rose',
'010-1234-5678', '부산광역시 사하구', '낙동대로', false);

-- 2. 사용자로부터 이메일(email) : 'email@email.com',
-- 프로필 이미지(profile_image) : 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg'
-- 를 입력받아 user 테이블의 해당 email을 가지는 레코드의 profile_image를
-- 입력받은 profile_image로 변경하는 SQL을 작성하시오.

ALTER TABLE user ADD COLUMN profile_image TEXT;

UPDATE user SET profile_image = 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg'  WHERE email = 'email@email.com';

-- 3. 사용자로부터 게시물 제목(title): 첫번째 게시물, 게시물 내용(contents):
-- '반갑습니다. 처음뵙겠습니다.', 작성자 이메일(writer_email):
-- 'email2@email.com'을 입력받아 board 테이블에 삽입하는 SQL을 작성하시오.
-- 만약 삽입에 실패한다면 실패하는 이유에 대하여 설명하시오.

CREATE TABLE board (
board_number INT NOT NULL UNIQUE AUTO_INCREMENT,
title TEXT NOT NULL,
contents TEXT NOT NULL,
writer_email VARCHAR(200) NOT NULL,
CONSTRAINT board_pk PRIMARY KEY (board_number),
CONSTRAINT writer_email_fk FOREIGN KEY (writer_email) REFERENCES user (email)
);

INSERT INTO board (title, contents, writer_email) VALUES ('첫번째 게시물', '반갑습니다. 처음뵙겠습니다.', 'email2@email.com');

-- 삽입 실패 : FOREIGN KEY 제약 조건으로 참조하고 있는 테이블 user의 컬럼 email에 'email@email.com' 데이터가 존재하지 않음

-- 4. 사용자로부터 게시물 제목(title): 첫번째 게시물, 게시물 내용(contents):
-- '반갑습니다. 처음뵙겠습니다.', 작성자 이메일(writer_email):
-- 'email@email.com'을 입력받아 board 테이블에 삽입하는 SQL을 작성하시오.
-- 만약 삽입에 실패한다면 실패하는 이유에 대하여 설명하시오.

INSERT INTO board (title, contents, writer_email) VALUES ('첫번째 게시물', '반갑습니다. 처음뵙겠습니다.', 'email@email.com');

-- 5. 사용자로부터 게시물 번호(board_number): 1,
-- 이미지 URL(image_url): 'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg'
-- 를 입력받아 board_image 테이블에 삽입하는 SQL을 작성하시오.

CREATE TABLE board_image (
sequence INT NOT NULL UNIQUE AUTO_INCREMENT,
board_number INT NOT NULL,
image_url TEXT NOT NULL,
CONSTRAINT board_image_pk PRIMARY KEY (sequence),
CONSTRAINT board_image_number_fk FOREIGN KEY board_image (board_number) REFERENCES board (board_number)
);

INSERT INTO board_image (board_number, image_url) VALUES (1, 'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg');

-- 6. 사용자 email@email.com가 1번 게시물에 좋아요를 누르는 기능을 SQL로 작성하시오.
CREATE TABLE favorite (
user VARCHAR(200) NOT NULL UNIQUE,
board_number INT NOT NULL,
CONSTRAINT favorite_pk PRIMARY KEY (user, board_number),
CONSTRAINT user_fk FOREIGN KEY favorite (user) REFERENCES user (email),
CONSTRAINT board_number_fk FOREIGN KEY favorite (board_number) REFERENCES board (board_number)
);

INSERT INTO favorite VALUES ('email@email.com', 1);

-- 7. 게시물번호(board_number), 게시물 제목(title), 게시물 내용(contents),
-- 조회수(view_count), 댓글수(comment_count), 좋아요수(favorite_count),
-- 게시물 작성일(write_datetime), 작성자 이메일(writer_email),
-- 작성자 프로필 사진(writer_profile_image), 작성자 닉네임(writer_nickname)을 모두 조회하는 SQL을 작성하시오.
-- (user 테이블과 board 테이블을 모두 이용하시오)
ALTER TABLE board ADD COLUMN view_count INT NOT NULL DEFAULT 0;
ALTER TABLE board ADD COLUMN comment_count INT NOT NULL DEFAULT 0;
ALTER TABLE board ADD COLUMN favorite_count INT NOT NULL DEFAULT 0;
ALTER TABLE board ADD COLUMN write_datetime DATETIME NOT NULL DEFAULT now();

SELECT
B.board_number '게시물번호',
B.title '게시물 제목',
B.contents '게시물 내용',
B.view_count '조회수',
B.comment_count '댓글수',
B.favorite_count '좋아요수',
B.write_datetime '게시물 작성일',
B.writer_email '작성자 이메일',
U.profile_image '작성자 프로필 사진',
U.nickname '작성자 닉네임'
FROM board B INNER JOIN user U ON B.writer_email = U.email;

-- 8. 7번 문제에서 작성한 SQL을 board_view라는 이름의 가상의 테이블로 생성하는
-- SQL을 작성하시오.
CREATE VIEW board_view AS SELECT
B.board_number '게시물번호',
B.title '게시물 제목',
B.contents '게시물 내용',
B.view_count '조회수',
B.comment_count '댓글수',
B.favorite_count '좋아요수',
B.write_datetime '게시물 작성일',
B.writer_email '작성자 이메일',
U.profile_image '작성자 프로필 사진',
U.nickname '작성자 닉네임'
FROM board B INNER JOIN user U ON B.writer_email = U.email;

-- 9. 사용자로 부터 '반갑'이라는 문자열을 입력받아 board_view 가상 테이블에서
-- 제목(title) 또는 내용(contents)에 포함되어 있는 레코드를 조회하는 SQL을 작성하시오.
SELECT *
FROM board_view
WHERE '게시물 제목' LIKE '%반갑%' OR '게시물 내용' LIKE '%반갑%';

-- 10. board 테이블에서 title 컬럼에 대한 조회 속도를 높이기 위한 기능을
-- board_title_idx 라는 이름으로 생성하는 SQL을 작성하시오
CREATE INDEX board_title_idx ON board (title(100));

-- 11. board 테이블에서 작성자 별로 작성한 게시물의 수를 구하는 SQL을 작성하시오.
SELECT writer_email, COUNT(*)
FROM board
GROUP BY writer_email;