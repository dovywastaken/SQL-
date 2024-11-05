DROP DATABASE IF EXISTS market_db; -- 만약 market_db가 존재하면 우선 삭제한다.
CREATE DATABASE market_db;

USE market_db;
CREATE TABLE member -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
);
CREATE TABLE buy -- 구매 테이블
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   mem_id  	CHAR(8) NOT NULL, -- 아이디(FK)
   prod_name 	CHAR(6) NOT NULL, --  제품이름
   group_name 	CHAR(4), -- 분류
   price     	INT  NOT NULL, -- 가격
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

SELECT * FROM member;
select mem_name as 멤버이름 from member;
select addr, debut_date, mem_name from member;
select addr 주소, debut_date "데뷔년도", mem_name as 멤버이름 from member;
SELECT * FROM buy;

select mem_id, mem_name
	from member
    Where height <= 162;
    
select mem_name, height, mem_number
	from member
    where height >= 165 and mem_number > 6;

select * from member where mem_name = "블랙핑크";
select * from member where mem_number = 4;

-- and와 or
select mem_name, height, mem_number from member where height >= 165 and mem_number > 6;
select mem_name, height, mem_number from member where height >= 165 or mem_number > 6;

-- between 사용하기
select mem_name, height from member where height >= 163 and height <= 165;
-- ==
select mem_name, height from member where height between 163 and 165;


-- in 사용하기 
select mem_name, addr from member where addr = '경기' or addr = '전남' or addr = '경남';
-- ==
select mem_name, addr 
	from member 
	where addr in ('경기', '전남', '경남');

-- like 사용하기
select *
	from member
	where mem_name like '우%';

select *
	from member
    where mem_name like '__핑크';


select mem_id, mem_name, debut_date
	from member
	order by debut_date;

select mem_id, mem_name, debut_date
	from member
	order by debut_date desc;
    
select mem_id, mem_name, debut_date, height
	from member
    order by height desc;
    -- where height >= 164;
	-- order by 후에  where를 적은건 syntax error를 발생시킨다
    

select mem_id, mem_name, debut_date, height
	from member
    where height >= 164
    order by height desc, debut_date asc;
    
select *
	from member
	limit 3;


select mem_name, debut_date
	from member
    order by debut_date
    limit 3;


select mem_name, height
	from member
    order by height desc
    limit 3,2;

-- distinct 절 
select addr from member;
select addr from member order by addr;
select distinct addr from member;


-- group by절 (sum)
select mem_id, amount from buy order by mem_id; 
select mem_id, sum(amount) from buy group by mem_id;
select mem_id '회원 아이디', sum(amount) '총 구매 개수'
	from buy group by mem_id;
select mem_id '회원 아이디', sum(price*amount) '총 구매 금액'
	from buy group by mem_id;

-- group by절 (avg)
select avg(amount) '평균 구매 개수' from buy;
select mem_id, avg(amount) '평균 구매 개수'
	from buy
    group by mem_id;
    
-- group by절 (count)
select count(*) from member;