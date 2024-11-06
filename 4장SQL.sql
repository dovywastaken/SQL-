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

