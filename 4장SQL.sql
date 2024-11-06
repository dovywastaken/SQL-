-- 데이터 타입
create table big_table(
	data1 char(256), -- char의 단위가 작아서 설정이 안됨
    data2 varchar(16384)
);


create database netflix_db;
use netflix_db;
create table movie
(
		movie_id INT,
        movie_title varchar(30),
        movie_director varchar(20),
        movie_star varchar(20),
        movie_script longtext,
        movie_film longblob
);

-- 변수사용 

use market_db;

set @myVar1 = 5;
set @myVar2 = 4.25;

select @myVar1;
select @myVar2;

set @txt ='가수 이름 ==>';
set @height = 166;
select @txt, mem_name from member where height > @height;

-- Java에서 PreparedStatement 하던거랑 똑같음!!!

-- set @count = 3;
-- select mem_name, height from member order by height limit @count;

set @count = 3;
prepare mySQL from 'select mem_name, height from member order by height limit ?';
execute mySQL using @count;


-- 형변환
select cast(avg(price) as signed) '평균 가격' from buy;
-- or
select convert(avg(price), signed) '평균 가격' from buy;

select cast('2022$12$12' as date); -- 아무 특수기호를 구분점으로 사용해두고 casting을 as date로 하면 알아서 년-월-일 형식으로 바꿔준다
select cast('2022/12/12' as date);
select cast('2022^12^12' as date);
select cast('2022@12@12' as date);

select num, concat(cast(price as char), 'x', cast(amount as char), '=')
	'가격X수량', price*amount '구매액'
from buy;

-- implicit casting
select '100' + '200';
select concat('100', '200');
select concat(100, '200');
select 100+'200';

-- Inner join

select *
	from buy
	inner join member
    on buy.mem_id = member.mem_id
where buy.mem_id = 'GRL';

select *
	from buy
	inner join member
    on buy.mem_id = member.mem_id;
    
select *
	from buy
    inner join member
    on buy.mem_id = member.mem_id;


select mem_id, mem_name, prod_name, addr, concat(phone1, phone2)'연락처'
	from buy
		inner join member
        on buy.mem_id = member.mem_id;
        

select buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2)'연락처'
	from buy
		inner join member
        on buy.mem_id = member.mem_id;
        
select buy.mem_id, member.mem_name, buy.prod_name, member.addr, concat(member.phone1, member.phone2) '연락처'
	from buy
		inner join member
        on buy.mem_id = member.mem_id;


select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
	from buy B
		inner join member M
        on B.mem_id = M.mem_id;
        
select B.mem_id, M.mem_name, B.prod_name, M.addr
	from buy B
		inner join member M
        on B.mem_id = M.mem_id
	order by M.mem_id;
        
-- Outer Join

select M.mem_id, M.mem_name, B.prod_name, M.addr 
	from member M
		left outer join buy B
        on B.mem_id = M.mem_id
	order by M.mem_id;
    
    
select *
	from member M
		inner join buy B
        on B.mem_id = M.mem_id
	order by M.mem_id;
    
select *
	from member M
		left outer join buy B
        on B.mem_id = M.mem_id
	order by M.mem_id;
    
    
-- self join
create table emp_table (emp char(4), manager char(4), phone varchar(8));

insert into emp_table values('대표', null, '0000');
insert into emp_table values('영업이사', '대표', '1111');
insert into emp_table values('관리이사', '대표', '2222');
insert into emp_table values('정보이사', '대표', '3333');
insert into emp_table values('영업과장', '영업이사', '1111-1');
insert into emp_table values('경리부장', '관리이사', '2222-1');
insert into emp_table values('인사부장', '관리이사', '2222-2');
insert into emp_table values('개발팀장', '정보이사', '3333-1');
insert into emp_table values('개발주임', '정보이사', '3333-1-1');

select * from emp_table;

select A.emp '직원', B.emp '직속상관', B.phone '직속상관연락처'
	from emp_table A
		inner join emp_table B
        on A.manager = B.emp
	where A.emp = '경리부장';
    
-- SQL 프로그래밍 if문 활용

DELIMITER $$
create procedure ifProc3()
begin
	declare debutDate date;
    declare curDate date;
    declare days int;
	select debut_date into debutDate
		from market_db.member
        where mem_id = 'APN';
	set curDate = current_date();
    set days = datediff(curDate, debutDate);
    
    if(days/365) >= 5 then
		select concat('데뷔한 지', days, '일이나 지났습니다.');
	else
		select '데뷔한 지' + days + '일밖에 안됐네요';
	end if;
end%%
DELIMITER ;
call ifProc3();


select M.mem_id, M.mem_name, sum(price*amount) '총구매액'
	from buy B
		right Outer join member M
        on B.mem_id = M.mem_id
    group by M.mem_id
    order by sum(price*amount) desc;
    
    
SELECT M.mem_id,  M.mem_name, SUM(price * amount) '총구매액',
    CASE
        WHEN SUM(price * amount) >= 1500 THEN '최우수고객'
        WHEN SUM(price * amount) >= 1000 THEN '우수고객'
        WHEN SUM(price * amount) >= 1 THEN '일반고객'
        ELSE '유령고객'
    END '회원등급'
FROM  buy B
    RIGHT OUTER JOIN member M 
    ON B.mem_id = M.mem_id
GROUP BY 
    M.mem_id
ORDER BY SUM(price * amount) DESC;

    
-- while문

drop procedure if exists whileProc;

delimiter %%
create procedure whileProc()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    while(i <= 100) do
		set hap = hap + i;
        set i = i+1;
	end while;
    select '1부터 100까지의 합 ==>', hap;
end %%;
delimiter ;
call whileProc();
    
delimiter %%
create procedure whileProc2()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    myWhile:
	while(i<=100) do
		if(i%4 = 0)then
			set i = i+1;
			iterate myWhile;
        end if;
        set hap = hap + i;
        if(hap > 1000)then
			leave myWhile;
		end if;
        set i =i+1;
	end while;
    select '1부터 100까지의 합(4의 배수 제외), 1000을 넘으면 종료 ==>',hap;
end%% ;
delimiter ;
call whileProc2();
    

-- 동적 SQL

prepare myQuery from 'select * from member where mem_id = "BLK"';
execute myQuery;
deallocate prepare myQuery;



create table gate_table(id int auto_increment primary key, entry_time datetime);
set @curDate = current_timestamp();
prepare myQuery from 'insert into gate_table values(null, ?)';
execute myQuery Using @curDate;
deallocate prepare myQuery;

select * from gate_table;

