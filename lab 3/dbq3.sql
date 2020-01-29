/*
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
drop table fine;
drop table Book_Return;
drop table Book_Issue;
drop table Book_stock;


create table Book_stock(
	Book_id int NOT NULL primary key,
	title varchar(20) not null,
	copies int not null
);

create table Book_Issue(
	card_no int not null ,
	cholder_name varchar(25),
	book_id int not null references Book_stock(book_id),
	issue_date date not null,
	due_date date not null
);

create table Book_Return(
	card_no int not null,
	cholder_name varchar(25),
	book_id int not null references Book_stock(book_id),
	return_date date not null,
	issue_date date not null
);

create table fine(
 	card_no int not null primary key,
 	amt int not null
);

insert into book_stock values ('1001','pds','5');
insert into book_stock values ('1002','dbms','4');
insert into book_stock values ('1003','coa','3');
insert into book_stock values ('1004','os','2');
insert into book_stock values ('1005','algo','1');


--insert into book_issue values('2002','sai','1001',SYSDATE,SYSDATE+7);

select * from book_stock;
*/
set serveroutput on
DECLARE
	opt varchar(1);
	cno int;
	cname varchar(25);
	cnt int;
	cnt2 int;
	stock int;
	bookid int;

	cnt4 int;
	idate Book_Issue.issue_date%type;
	rdate Book_Issue.due_date%type;

BEGIN
	opt := '&option_I_or_R';
	cno := &card_no;
	cname := '&card_holder_name';
	bookid := &bookid;


 	if(opt = 'i' or opt='I') then
 		select count(*) into cnt from Book_Issue where card_no = cno;
 		select count(*) into cnt2 from Book_Issue where book_id=bookid;
 		select copies into stock from Book_stock where  book_id=bookid;

 		IF (cnt <3 AND cnt2=0 AND stock>0) then
 			insert into Book_Issue values(cno,cname,bookid,SYSDATE,SYSDATE+7);
 			update book_stock set copies=copies-1 where book_id=bookid;
 			dbms_output.put_line('Book issued succesfully!');
 		ELSE 
 			dbms_output.put_line('Sorry! book cannot be issued');
 		end if;
 	end if;

 	if(opt = 'r' or opt = 'R') then
 		select count(*) into cnt4 from Book_Issue where book_id=bookid AND card_no=cno;
 		if (cnt4>0) then
	 		select issue_date into idate from Book_Issue where book_id=bookid AND card_no=cno;
	 		insert into Book_Return values (cno,cname,bookid,SYSDATE,idate);
	 		update book_stock set copies=copies+1 where book_id=bookid;
	 		select issue_date into rdate from Book_Issue where book_id=bookid AND card_no=cno;
	 		delete from Book_Issue where card_no = cno AND book_id=bookid;

	 		if(SYSDATE > rdate) then
	 			select count(*) into cnt4 from fine where card_no=cno;

	 			if(cnt4>0) then
	 				update fine set amt=amt+10*(SYSDATE-rdate) where card_no=cno;
	 			ELSE
	 				insert into fine values(cno,10*(SYSDATE-rdate));
	 			end if;

	 		end if;

	 		dbms_output.put_line('Book returned succesfully!');
	 	ELSE
	 		dbms_output.put_line('You have not issued this book');
 		end if;

 	ELSE
 		dbms_output.put_line('Choose option correctly!!');
 	end if;
END;
/

select * from book_stock;
select * from book_issue;
select * from Book_Return;

