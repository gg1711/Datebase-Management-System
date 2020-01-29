
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
drop table transaction;

create table transaction(
	transNo int not null primary key,
	acctNO int not null,
	tr_date date not null,
	amount int not null
);

insert into transaction values('101','2001','2020-01-15','1000');
insert into transaction values('102','2002','2020-01-12','2000');
insert into transaction values('103','2003','2020-01-16','3000');
insert into transaction values('104','2003','2020-01-21','-700');
insert into transaction values('105','2003','2020-01-23','-2200');
insert into transaction values('106','2001','2020-01-20','-500');
insert into transaction values('107','2001','2020-01-22','-300');
insert into transaction values('108','2002','2020-01-24','-1000');
insert into transaction values('115','2002','2020-01-25','100');
insert into transaction values('109','2002','2020-01-28','-700');
insert into transaction values('110','2003','2020-01-26','500');

select * from transaction;

--(a)
drop view tp;
create view tp as
	select t1.acctno ,t1.tr_date,t2.amount from transaction t1, transaction t2
	where t1.acctno=t2.acctno AND t2.tr_date <= t1.tr_date;

select * from tp order by acctno,tr_date;


--(b)

drop view tempo;
create view tempo as
select distinct tp1.acctno, tp1.tr_date, (select sum(tp2.amount) from tp tp2 where tp1.acctno=tp2.acctno AND tp2.tr_date = tp1.tr_date) amt from tp tp1;

select acctno, min(amt) from tempo group by acctno;
