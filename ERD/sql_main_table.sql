SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS mc_admin;
DROP TABLE IF EXISTS mc_comment;
DROP TABLE IF EXISTS mc_like;
DROP TABLE IF EXISTS mc_report;
DROP TABLE IF EXISTS mc_board;
DROP TABLE IF EXISTS mc_member;
DROP TABLE IF EXISTS mc_authority;




/* Create Tables */

CREATE TABLE mc_admin
(
	admin_uid int NOT NULL,
	admin_email varchar(128) NOT NULL,
	admin_nick varchar(20) NOT NULL,
	admin_password varchar(128) NOT NULL,
	admin_phoneNumber varchar(15),
	authority int NOT NULL,
	PRIMARY KEY (admin_uid),
	UNIQUE (admin_uid),
	UNIQUE (admin_nick)
);


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
	nickname varchar(20),
	regDate datetime DEFAULT now(),
	count int DEFAULT 0,
	content varchar(500) NOT NULL CHECK (LENGTH(content) >= 3),
	PRIMARY KEY (board_uid)
);


CREATE TABLE mc_comment
(
	comment_uid int NOT NULL AUTO_INCREMENT,
	comment_nickname varchar(20) NOT NULL,
	board_uid int NOT NULL,
	comment_content varchar(200) NOT NULL,
	PRIMARY KEY (comment_uid)
);


CREATE TABLE mc_like
(
	board_uid int NOT NULL,
	like_nickname varchar(20) CHECK (nickname REGEXP ('^[0-9a-zA-Z가-힣]+$'))
);


CREATE TABLE mc_member
(
	member_uid int NOT NULL AUTO_INCREMENT,
	email varchar(40) NOT NULL CHECK (email REGEXP ("^[\\w]([-_\\.]?[\\w])*@[\\w]([-_\\.]?[\\w])*\\.[a-zA-Z]{2,3}$")),
	password varchar(128) NOT NULL,
	nickname varchar(20) NOT NULL CHECK (nickname REGEXP ('^[0-9a-zA-Z가-힣]+$')),
	phoneNumber varchar(15) CHECK (phoneNumber REGEXP ("^\\d{2,3}-\\d{3,4}-\\d{4}$")),
	authority int NOT NULL,
	PRIMARY KEY (member_uid),
	UNIQUE (email),
	UNIQUE (nickname)
);


CREATE TABLE mc_report
(
	report_uid int NOT NULL AUTO_INCREMENT,
	board_uid int NOT NULL,
	report_subjecct varchar(64) NOT NULL,
	reported_nickname varchar(20),
	reporter_nickname varchar(20),
	PRIMARY KEY (report_uid)
);



/* Create Foreign Keys */

ALTER TABLE mc_admin
	ADD FOREIGN KEY (authority)
	REFERENCES mc_authority (authority)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


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
	ON DELETE RESTRICT
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
	ADD FOREIGN KEY (nickname)
	REFERENCES mc_member (nickname)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_comment
	ADD FOREIGN KEY (comment_nickname)
	REFERENCES mc_member (nickname)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_like
	ADD FOREIGN KEY (like_nickname)
	REFERENCES mc_member (nickname)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE mc_report
	ADD FOREIGN KEY (reporter_nickname)
	REFERENCES mc_member (nickname)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



