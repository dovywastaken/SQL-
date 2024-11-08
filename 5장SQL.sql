create database naver_db;
use naver_db;

create table member(
	 id varchar(5) NOT NULL PRIMARY KEY, -- PK 처리
     name varchar(10) not null,
     memNum int not null,
     adr char(2) not null,
     countryCode char(3),
     phone varchar(8),
     height int,
     debut date
     -- primary key(id) 이런식으로 PK 처리를 해도 된다
);

create table buy(
	num int not null auto_increment primary key,
    id varchar(5) not null,
    product char(5) not null,
    category char (5),
    price int not null,
    amount int,
    FOREIGN KEY (id) REFERENCES member(id) -- FK 처리
);

select * from member;
select * from buy;

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





-- constraint

drop table if exists buy, member;
create table member(
	mem_id char(8) not null,
    mem_name char(8) not null,
    height int unsigned null,
    constraint primary key PKMember (mem_id)
);
alter table member
	add constraint
    primary key (mem_id);

describe member;
describe buy;

create table member(
	mem_id char(8) primary key,
    mem_name char(8) not null,
    height int unsigned null
);
create table buy(
	num int auto_increment primary key,
    mem_id char(8) not null,
    prod_name char(6) not null,
    foreign key(mem_id) references member(mem_id)
);




drop table if exists buy;
create table buy(
	num int auto_increment primary key,
    mem_id char(8) not null,
    prod_name char(8) not null
);
alter table buy
	add constraint
    foreign key(mem_id)
    references member(mem_id);

describe buy;
select M.mem_id, M.mem_name, B.prod_name from buy B
	Inner join member M
    on B.mem_id = M.mem_id
;

select * from member;
select * from buy;

insert into member values('BLK', '블랙핑크', 163);
insert into buy values(null, 'BLK', '지갑');
insert into buy values(null, 'BLK', 'MacBook');

update member Set mem_id = 'Pink' where mem_id = 'BLK'; -- 에러발생 : PK와 FK로 연결된 경우 수정이 불가능하기 때문에
delete from member where mem_id='BLK'; -- 에러발생 : 마찬가지로 BLK는 PK와 FK로 연결되었기 때문에 수정이 불가능함

-- 
alter table buy
	add constraint
    foreign key(mem_id)
    references member(mem_id)
    on update cascade
    on delete cascade;

delete from member where mem_id='Pink';




drop table if exists buy, member;
create table member(
	mem_id char(8) primary key,
    mem_name char(10) not null,
    height int unsigned null,
    email char(30) null unique
);

insert into member values('BLK', '블랙핑크', 163, 'pink@gmail.com');
insert into member values('TWC', '트와이스', 167, null);
insert into member values('APN', '에이핑크', 164, 'pink@gmail.com'); -- 이메일은 Unique 처리를 해놔서 같은 이메일로 등록이 안된다


drop table if exists member;
create table member(
	mem_id char(8) primary key,
    mem_name char(10) not null,
    height int unsigned null check (height>=100),
    phone1 char(3) null
);

insert into member values('BLK', '블랙핑크', 163, null);
insert into member values('APN', '에이핑크', 99, null); -- height의 값이 check constraint에 의해 100이하면 insert 되지 않기 때문에 에러가 발생한다

alter table member
	add constraint
    check(phone1 in ('02', '031', '032', '054','055','061'));
    
    
insert into member values('TWC', '트와이스', 167, '02');
insert into member values('OMY', '오마이걸', 167, '010'); -- 010은 check 제약조건에서 설정하지 않았기 때문에 insert가 안된다

-- 기본값 정의
drop table if exists member;
create table member(
	mem_id char(8) primary key,
    mem_name varchar(10) not null,
    height int unsigned null default 160,
    phone1 char(3)
);

describe member;
alter table member
	alter column  phone1 set default '02';

insert into member values('RED','레드벨벳','161','054');
insert into member values('SPC','우주소녀',default,default);
select * from member;


-- 가상의 테이블 : 뷰

-- market_db에서 실습
use market_db;
create view v_member
as
	select mem_id, mem_name, addr From member;

select * from v_member; -- 원래 테이블(member)에서 select 한 컬럼만 뷰로 구현되기 때문에 *로 전체 조회해도 불러온 컬럼만 나온다

select mem_name, addr from v_member
	where addr in('서울','경기');
    
select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처' 
	From buy B
		Inner join member M
        On B.mem_id = M.mem_id;


Create view v_memberbuy
as
	select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
	From buy B
		Inner join member M
        On B.mem_id = M.mem_id
;

drop view v_memberbuy;
select * from v_memberbuy where mem_name = '블랙핑크';


create view v_viewtest1
as
	select B.mem_id 'Member ID', M.mem_name As 'Member Name',
		B.prod_name "Product Name",
					concat(M.phone1, M.phone2) as "Office Phone"
		from buy B
			Inner join member M
            on B.mem_id = M.mem_id
;

select distinct `Member ID`, `Member Name` From v_viewtest1;
            
Alter view v_viewtest1
as
	select B.mem_id '회원 ID', M.mem_name As '회원 이름',
		B.prod_name "제품 이름",
					concat(M.phone1, M.phone2) as "연락처"
		from buy B
			Inner join member M
            on B.mem_id = M.mem_id
;

select distinct `회원 ID`, `회원 이름` From v_viewtest1;

drop view v_viewtest1;


update v_member set addr = '창원' where mem_id='BLK';

select addr, mem_id from v_member;
insert into v_member(mem_id, mem_name, addr) values('BTS','방탄소년단','경기');

create view v_height167
as
	select * from member where height >= 167
				with check option;

select * from v_height167;

delete from v_height167 where height < 167; -- 뷰로 만든 167 미만인 데이터가 없기 때문에 삭제될 데이터도 없다

-- 뷰를 통한 데이터 입력
insert into v_height167 values('TRA','티아라',6,'서울',null,null,159,'2005-01-01'); -- 일부러 키가 167보다 작도록 설정한 데이터를 insert 해보기
insert into v_height167 values('TOB', '텔레토비',4,'영국',null,null,140,'1995-01-01'); -- with check option 속성 때문에  insert가 안된다
select * from member;






















