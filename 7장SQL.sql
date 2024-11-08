use market_db;

drop procedure if exists user_proc;

delimiter &&
	create procedure user_proc()
	begin
		select * from member;
	end &&
delimiter ;

call user_proc();

drop procedure user_proc;

-- in 사용해서 파라미터 받기

delimiter **
	create procedure user_proc1(In userName varchar(10))
    begin
		select * from member where mem_name = userName;
    end **
delimiter ;

call user_proc1('에이핑크');


delimiter ^^
	create procedure user_proc2(in userNumber int, in userHeight int)
    begin
		select * from member where mem_number > userNumber and height> userHeight;
    end ^^;
delimiter ;


call user_proc2(6,165);

delimiter ^^
	create procedure user_proc3(in txtValue char(10), out outValue int)
    begin
		insert into noTable values(null, txtValue);
        select max(id) into outValue from noTable;
    end ^^;
delimiter ;

create table if not exists noTable(
	id int auto_increment unique,
    txt char(10)
);

call user_proc3('테스트', @myValue);
select concat('입력된 ID 값 ==>', @myValue);


delimiter ^^
	create procedure ifelse_proc(in memName varchar(10))
    begin
		declare debutYear int;
        select year(debut_date) into debutYear from member
			where mem_name = memName;
            
		if(debutYear >= 2024) then
			select '신인 가수네요. 화이팅 하세요.' as '메시지';
        else
			select '고참 가수네요. 그동안 수고하셨어요.' as '메시지';
        end if;
    end ^^;
delimiter ;

call ifelse_proc('오마이걸');
drop procedure ifelse_proc;

-- 날짜 출력해주는 함수
select day(curdate());
select month(curdate());
select year(curdate());

delimiter ^^
	create procedure while_proc()
	begin
		declare hap int;
        declare num int;
        set hap = 0;
        set num = 1;
        
        while(num <= 100) do
			set hap = hap + num;
            set num = num + 1;
        end while;
        select hap as '1~100 합계';
    end ^^;
delimiter ;

call while_proc();


delimiter ^^
	create procedure dynamic_proc(in tableName varchar(20))
    begin
		set @sqlQuery = concat('select * from', tableName);
        prepare myQuery from @sqlQuery;
        execute myQuery;
        deallocate prepare myQuery;
    end ^^;
delimiter ;

call dynamic_proc('member');

-- stored function

set global log_bin_trust_function_creators = 1;

use market_db;
drop function if exists sumFunc;
delimiter ^^
	create function sumFunc(number1 int, number2 int) -- 파라미터로는 이걸 받아라!!
		returns int -- 반환 형식. 즉 정수 값을 반환하도록 함
	begin
		return number1 + number2; -- 실제 반환 값
	end ^^;
delimiter ;
    
select sumFunc(100, 200) as '합계';


























