drop database bookmarketdb;
create database bookmarketdb;

use bookmarketdb; -- 자바의 import 같은 거임 이거 안하면 테이블 만들때 테이블 이름 앞에 데이터베이스 이름 붙여야 함 bookmarketdb.book 이런식으로


create table if not exists book(
b_id varchar(10) not null,
b_name varchar(20),
b_unitPrice integer,
b_author varchar(20),
b_description text,
b_publisher varchar(20),
b_category varchar(20),
b_unitsInStock long,
b_releaseDate varchar(20),
b_condition varchar(20),
b_fileName varchar(20),
primary key (b_id)
) default charset=utf8;


select * from book;

drop table book;