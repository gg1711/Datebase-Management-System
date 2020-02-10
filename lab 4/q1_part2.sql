/*
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
drop table Transaction;
drop table account;

create table account(
	Accno int not null primary key,
	Accname varchar(25) not null,
	type varchar(25) not null,
	balance int not null
);

create table Transaction(
	Tr_id int not null primary key,
	Accno int references account(Accno),
	Tr_type varchar(25) not null, -- w-withdraw, d -deposit
	Amt int not null,
	date_of_tr date
);

insert into Account values('2001','balaji','saving','1000');
insert into Account values('2002','sai','current','2000');
insert into Account values('2003','rahul','saving','3000');
insert into Account values('2004','yash','current','4000');
insert into Account values('2005','gaurav','saving','5000');

select * from account;
*/
create or replace trigger checking
before insert on Transaction
for each row

DECLARE
bal int;
BEGIN
	if(:new.Tr_type = 'd' ) then
		dbms_output.put_line('Deposit allowed');	
	else
		select balance into bal from account where Accno = :new.Accno;
		if(bal < :new.amt) then
			raise_application_error(-20001,' Balance is less than amount asked ');
		else 
			dbms_output.put_line('Withdraw allowed');
		end if;
	end if;

end;
/


create or replace trigger deposit
after insert on Transaction
for each row

DECLARE
	
BEGIN
	if(:new.Tr_type = 'd') then
		update account set balance = balance + :new.amt
					where Accno  =  :new.Accno;
		dbms_output.put_line('Amount '|| :new.amt ||' deposited succesfully!');
	else
		update account set balance = balance - :new.amt
					where Accno = :new.Accno;
		dbms_output.put_line('Amount '|| :new.amt ||' withdrawn succesfully!');

	end if;

end;
/


DECLARE
	tr_type varchar(1);
	ac_no int;
	tr_id int;
	amt int;
	bal int;

	cursor c is
		select Accno, balance from account;
BEGIN
	
	tr_type := '&tr_type_w_or_d';
	ac_no := '&ac_no';
	tr_id := '&tr_id';
	amt := '&amt';

	insert into Transaction values(tr_id,ac_no,tr_type,amt,sysdate);
END;
/

select * from account;
select * from Transaction;
