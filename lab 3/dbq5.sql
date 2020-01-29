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

	if(tr_type = 'd') then
		update account set balance = balance+amt
			where Accno=ac_no;

		insert into Transaction values(tr_id,ac_no,tr_type,amt,sysdate);

		dbms_output.put_line('Amount '|| amt ||' deposited succesfully!');

	elsif(tr_type = 'w') then
		select balance into bal from account where Accno=ac_no;

		if(bal>amt) then
			update account set balance = balance-amt
			where Accno=ac_no;

			insert into Transaction values(tr_id,ac_no,tr_type,amt,sysdate);
			dbms_output.put_line('Amount '|| amt ||' withdarwn succesfully!');
		else
			dbms_output.put_line('Balance ' || bal ||' is less than '||amt ||'asked.');

		end if;

	end if;
END;
/
select * from account;
select * from Transaction;