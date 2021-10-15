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
	bithumb_name varchar(10),
	upbit_name varchar(10),
	coinone_name varchar(10),
	korbit_name varchar(10),
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
	ON DELETE CASCADE
;


ALTER TABLE mc_report
	ADD FOREIGN KEY (board_uid)
	REFERENCES mc_board (board_uid)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
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
	ON DELETE CASCADE
;


ALTER TABLE mc_like
	ADD FOREIGN KEY (member_uid)
	REFERENCES mc_member (member_uid)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;


ALTER TABLE mc_report
	ADD FOREIGN KEY (member_uid)
	REFERENCES mc_member (member_uid)
	ON UPDATE RESTRICT
	ON DELETE CASCADE
;

INSERT INTO mc_authority (authority, auth_name)
VALUES (0, '회원') , (1, '관리자'), (2, '운영자');

INSERT INTO mc_member (email, password, nickname, phoneNumber, authority) 
VALUES( 'root@root.com', 'root', 'root', '010-1234-1234', 2);

UPDATE mc_member 
SET authority = 2
WHERE email = 'root@root.com';

SELECT * FROM mc_authority;
SELECT * FROM mc_member ORDER BY member_uid DESC;

SELECT * FROM mc_report;
SELECT * FROM mc_board;
SELECT * FROM mc_comment;



INSERT INTO mc_coin (bithumb_name,upbit_name,coinone_name,korbit_name)
VALUES ("BTC","BTC","btc","btc_krw"),
	   ("ETH","ETH","eth","eth_krw"),
	   ("LTC","LTC","ltc","ltc_krw"),
	   ("ETC","ETC","etc","etc_krw"),
	   ("XRP","XRP","xrp","xrp_krw"),
	   ("BCH","BCH","bch","bch_krw"),
	   ("QTUM","QTUM","qtum","qtum_krw"),
	   ("BTG","BTG","btg",""),
	   ("EOS","EOS","eos","eos_krw"),          
	   ("ICX","ICX","icx",""), 
	   ("TRX","TRX","trx","trx_krw"),
	   ("ELF","ELF","",""), 
	   ("OMG","OMG","omg","omg_krw"), 
	   ("KNC","KNC","knc",""),
	   ("GLM","GLM","",""),
	   ("ZIL","ZIL","zil","zil_krw"),
	   ("WAXP","WAXP","",""),
	   ("POWR","POWR","",""),
	   ("LRC","","","lrc_krw"),
	   ("STEEM","STEEM","",""),
	   ("STRAX","","",""),
	   ("ZRX","","zrx",""),
	   ("REP","REP","",""),
	   ("XEM","XEM","",""),
	   ("SNT","SNT","",""),
	   ("ADA","ADA","ada","ada_krw"),
	   ("CTXC","","",""),
	   ("BAT","BAT","bat","bat_krw"),
	   ("WTC","","",""),
	   ("THETA","THETA","","theta_krw"),
	   ("LOOM","LOOM","",""),
	   ("WAVES","WAVES","",""),
	   ("TRUE","","",""),
	   ("LINK","LINK","link","link_krw"),
	   ("ENJ","ENJ","","enj_krw"),
	   ("VET","VET","","vet_krw"),
	   ("MTL","MTL","",""),
	   ("IOST","IOST","",""),
	   ("TMTG","","tmtg",""),
	   ("QKC","QKC","",""),
	   ("HDAC","","",""),
	   ("AMO","","amo",""),
	   ("BSV","BSV","bsv","bsv_krw"),
	   ("ORBS","ORBS","orbs",""),
	   ("TFUEL","TFUEL","",""),
	   ("VALOR","","",""),
	   ("CON","","",""),
	   ("ANKR","ANKR","ankr",""),
	   ("MIX","","",""),
	   ("CRO","CRO","cro",""),
	   ("FX","","",""),
	   ("CHR","","",""),
	   ("MBL","MBL","mbl",""),
	   ("MXC","","",""),
	   ("FCT","","",""),
       ("TRV","","",""),
       ("DAD","","dad",""),
       ("WOM","","",""),
       ("SOC","","soc",""),
       ("EM","","",""),
       ("BOA","","",""),
       ("FLETA","","fleta",""),
       ("SXP","SXP","sxp",""),
       ("COS","","cos",""),
       ("APIX","","",""),
       ("EL","","",""),
       ("BASIC","","basic",""),
       ("HIVE","HIVE","",""),
       ("XPR","","",""),
       ("VRA","","",""),
       ("FIT","","",""),
       ("EGG","","egg_krw",""),
       ("BORA","BORA","bora",""),
       ("ARPA","","arpa",""),
       ("APM","","",""),
       ("CKB","","ckb",""),
       ("AERGO","AERGO","","aergo"),
       ("ANW","","",""),
       ("CENNZ","","",""),
       ("EVZ","","",""),
       ("CYCLUB","","",""),
       ("SRM","SRM","srm",""),
       ("QTCON","","qtcon",""),
       ("UNI","","uni","uni_krw"),
       ("YFI","","","yfi_krw"),
       ("UMA","","uma","uma_krw"),
       ("AAVE","","aave","aave_krw"), 
       ("COMP","","comp","comp_krw"),
       ("REN","","ren",""),
       ("BAL","","bal",""),
       ("RSR","","",""),
       ("NMR","","",""),
       ("RLC","","",""),
       ("UOS","","uos",""),
       ("SAND","SAND","sand","sand_krw"),
       ("GOM2","","gom2",""),
       ("RINGX","","",""),
       ("BEL","","bel",""),
       ("OBSR","","",""),
       ("ORC","","","");


