/*
CREATE TABLE BOARD(
	BOARD_NUM INT,
	BOARD_NAME VARCHAR(20) NOT NULL,
	BOARD_PASS VARCHAR(15) NOT NULL,
	BOARD_MARKET VARCHAR(50) NOT NULL,
	BOARD_SUBJECT VARCHAR(50) NOT NULL,
	BOARD_PRICE INT DEFAULT 0,
	BOARD_WALLETID VARCHAR(200) NOT NULL,
	BOARD_CONTENT VARCHAR(2000) NOT NULL,
	BOARD_FILE VARCHAR(50) NOT NULL,
	BOARD_RE_REF INT NOT NULL,
	BOARD_RE_LEV INT NOT NULL,
	BOARD_RE_SEQ INT NOT NULL,
	BOARD_READCOUNT INT DEFAULT 0,
	BOARD_DATE DATETIME,
	BOARD_MDATE DATETIME,
	PRIMARY KEY(BOARD_NUM)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
*/

show tables;

show variables like 'char%';

desc board;

drop tables board;

delete from BOARD;

select * from BOARD;

-- cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct

insert into board values(1,'홍길동','1111','11번가','레고',10000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,10,now(),NULL);
insert into board values(2,'오라클','1111','쿠팡','청바지',20000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,35,now(),NULL);
insert into board values(3,'호스트','1111','위메프','패팅',30000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,58,now(),NULL);
insert into board values(4,'시스템','1111','G마켓','가습기',40000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,63,now(),NULL);
insert into board values(5,'관리자','1111','네이버쇼핑','공기청정기',50000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,196,now(),NULL);
insert into board values(6,'사용자','1111','옥션','자켓',60000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,345,now(),NULL);
insert into board values(7,'아무개','1111','티몬','도서',70000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,21,now(),NULL);
insert into board values(8,'롯데마트','1111','11번가','과자',80000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,7,now(),NULL);
insert into board values(9,'홈플러스','1111','쿠팡','의자',90000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,68,now(),NULL);
insert into board values(10,'이마트','1111','위메프','책상',100000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,93,now(),NULL);
insert into board values(11,'똘이','1111','G마켓','청소기',110000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,467,now(),NULL);
insert into board values(12,'홈쇼핑','1111','네이버쇼핑','컴퓨터',120000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,88,now(),NULL);
insert into board values(13,'닥터','1111','옥션','휴지',130000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,143,now(),NULL);
insert into board values(14,'학부모','1111','티몬','신발',140000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,93,now(),NULL);
insert into board values(15,'학생','1111','인터파크','휴대폰',150000,'cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct','내용','',0,0,0,78,now(),NULL);


alter table BOARD convert to character set utf8;

alter table BOARD modify column BOARD_DATE DATETIME;
