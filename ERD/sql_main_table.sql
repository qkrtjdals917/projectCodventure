SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS mc_like;
DROP TABLE IF EXISTS mc_board;
DROP TABLE IF EXISTS mc_member;




/* Create Tables */

CREATE TABLE mc_board
(
	board_uid int NOT NULL AUTO_INCREMENT,
	type varchar(2) NOT NULL CHECK(type IN ("자유", "정보", "공지")),
	subject varchar(64) NOT NULL,
	tag varchar(5) CHECK(tag IN ( "유머","잡담","질문","코인","뉴스","팁과노하우")),
	nickname varchar(20),
	regDate datetime DEFAULT now(),
	count int DEFAULT 0,
	content varchar(500) NOT NULL,
	PRIMARY KEY (board_uid)
);


CREATE TABLE mc_like
(
	board_uid int NOT NULL,
	like_nickname varchar(20) CHECK (nickname REGEXP ('^[0-9a-zA-Z가-힣]+$'))
);


CREATE TABLE mc_member
(
	member_uid int NOT NULL AUTO_INCREMENT,
	email varchar(40) NOT NULL CHECK (email REGEXP ("^[\\w]([-_\\.]?[\\w])*@[\\w]([-_\\.]?[\\w])*\\.[a-zA-Z]{2,3}$"),
	password varchar(128) NOT NULL,
	nickname varchar(20) NOT NULL CHECK (nickname REGEXP ('^[0-9a-zA-Z가-힣]+$')),
	phoneNumber varchar(15) CHECK (phonenum REGEXP ("^\\d{2,3}-\\d{3,4}-\\d{4}$"),
	authority int NOT NULL CHECK (authority IN (0, 1, 2)),
	PRIMARY KEY (member_uid),
	UNIQUE (email),
	UNIQUE (nickname)
);



/* Create Foreign Keys */

ALTER TABLE mc_like
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


ALTER TABLE mc_like
	ADD FOREIGN KEY (like_nickname)
	REFERENCES mc_member (nickname)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



