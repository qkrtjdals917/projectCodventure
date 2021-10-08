SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS mc_comment;
DROP TABLE IF EXISTS mc_like;
DROP TABLE IF EXISTS mc_report;
DROP TABLE IF EXISTS mc_board;
DROP TABLE IF EXISTS mc_member;
DROP TABLE IF EXISTS mc_authority;
DROP TABLE IF EXISTS mc_coin;




/* Create Tables */

CREATE TABLE mc_authority
(
	authority int NOT NULL,
	auth_name varchar(3) NOT NULL,
	PRIMARY KEY (authority)
);


CREATE TABLE mc_board
(
	board_uid int NOT NULL AUTO_INCREMENT,
	type varchar(2) NOT NULL CHECK(type IN ("자유", "정보", "공지")),
	subject varchar(64) NOT NULL,
	tag varchar(5) CHECK(tag IN ( "유머","잡담","질문","코인","뉴스","팁과노하우")),
	regDate datetime DEFAULT now(),
	count int DEFAULT 0,
	content varchar(500) NOT NULL CHECK (LENGTH(content) >= 3),
	member_uid int NOT NULL,
	PRIMARY KEY (board_uid)
);


CREATE TABLE mc_coin
(
	coin_uid int NOT NULL AUTO_INCREMENT,
	coin_name varchar(10),
	PRIMARY KEY (coin_uid)
);


CREATE TABLE mc_comment
(
	comment_uid int NOT NULL AUTO_INCREMENT,
	board_uid int NOT NULL,
	comment_content varchar(200) NOT NULL,
	member_uid int NOT NULL,
	regDate datetime DEFAULT now(),
	PRIMARY KEY (comment_uid)
);


CREATE TABLE mc_like
(
	board_uid int NOT NULL,
	member_uid int NOT NULL
);


CREATE TABLE mc_member
(
	member_uid int NOT NULL AUTO_INCREMENT,
	email varchar(40) NOT NULL CHECK (email REGEXP ("^[\\w]([-_\\.]?[\\w])*@[\\w]([-_\\.]?[\\w])*\\.[a-zA-Z]{2,3}$")),
	password varchar(128) NOT NULL,
	nickname varchar(20) NOT NULL CHECK (nickname REGEXP ('^[0-9a-zA-Z가-힣]+$')),
	phoneNumber varchar(15) CHECK (phoneNumber REGEXP ("^\\d{2,3}-\\d{3,4}-\\d{4}$")),
	authority int NOT NULL DEFAULT 0,
	PRIMARY KEY (member_uid),
	UNIQUE (email),
	UNIQUE (nickname)
);


CREATE TABLE mc_report
(
	board_uid int NOT NULL,
	report_uid int NOT NULL AUTO_INCREMENT,
	report_tag varchar(20) NOT NULL,
	report_content varchar(64) NOT NULL,
	member_uid int NOT NULL,
	PRIMARY KEY (report_uid)
);



/* Create Foreign Keys */

ALTER TABLE mc_member
	ADD FOREIGN KEY (authority)
	REFERENCES mc_authority (authority)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_comment
	ADD FOREIGN KEY (board_uid)
	REFERENCES mc_board (board_uid)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE mc_like
	ADD FOREIGN KEY (board_uid)
	REFERENCES mc_board (board_uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_report
	ADD FOREIGN KEY (board_uid)
	REFERENCES mc_board (board_uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_board
	ADD FOREIGN KEY (member_uid)
	REFERENCES mc_member (member_uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_comment
	ADD FOREIGN KEY (member_uid)
	REFERENCES mc_member (member_uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_like
	ADD FOREIGN KEY (member_uid)
	REFERENCES mc_member (member_uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_report
	ADD FOREIGN KEY (member_uid)
	REFERENCES mc_member (member_uid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

INSERT INTO mc_authority (authority, auth_name)
VALUES (0, '회원') , (1, '관리자'), (2, '운영자');

INSERT INTO mc_member (email, password, nickname, phoneNumber, authority) 
VALUES( 'root@root.com', 'root', 'root', '010-1234-1234', 2);

SELECT * FROM mc_authority;
SELECT * FROM mc_member ORDER BY member_uid DESC;
SELECT * FROM mc_board;
SELECT * FROM mc_comment;
SELECT * FROM mc_member WHERE email = "test3@email.com";
SELECT count(subject) FROM mc_board WHERE member_uid = 77;

-- 글 조회수 증가
UPDATE mc_board SET count = count + 1 WHERE board_uid = 1;

-- 공지페이지 리스트
SELECT mb.board_uid board_uid, mb.subject subject, mm.nickname nickname, mb.regDate regDate, mb.count count
FROM mc_board mb , mc_member mm 
WHERE mb.member_uid = mm.member_uid
AND mb.type = "공지"
ORDER BY board_uid DESC;
	
-- 글선택
SELECT mb.board_uid board_uid, mb.subject subject, mm.nickname nickname, 
mb.regDate regDate, mb.count count, mb.content content, 
mb.type type, mb.tag tag 
FROM mc_board mb , mc_member mm 
WHERE mb.member_uid = mm.member_uid 
AND mb.board_uid = 1;


SELECT mb.board_uid board_uid, mb.subject subject, mm.nickname nickname, 
		mb.regDate regDate, mb.count count, mb.content content, 
		mb.type type, mb.tag tag 
		FROM mc_board mb , mc_member mm 
		WHERE mb.member_uid = mm.member_uid
		AND mb.type <> "공지";

SELECT * FROM mc_like;

-- 글 작성
INSERT INTO mc_board (type, subject, tag, content, member_uid)

VALUES ("자유", "글작성테스트sql", "" ,"이 글은 테스트 중입니다.", 52);

SELECT *FROM mc_board mb ;
		SELECT	
			member_uid "member_uid",
			email "email",
			password "pw",
			nickname "nickname",
			phoneNumber "phoneNumber",
			authority "authority"
		FROM 
			mc_member
		WHERE email = "aaa5@aaa.com";

VALUES ("자유", "글작성테스트sql", ,"이 글은 테스트 중입니다.", 52);
SELECT *FROM mc_board mb ;

SELECT	
	member_uid "member_uid",
	email "email",
	password "pw",
	nickname "nickname",
	phoneNumber "phoneNumber",
	authority "authority"
FROM 
	mc_member

WHERE email = "aaa5@aaa.com";
SELECT *FROM mc_board mb ;

WHERE email = "aaa5@aaa.com";
SELECT *FROM mc_board mb ;
