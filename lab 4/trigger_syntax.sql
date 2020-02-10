create or replace trigger issue 
	before insert on book_issue
	for each row

declare
	cnt1 int;
	cnt2 int;
	stock int;

	e1 exception;
	e2 exception;
	e3 exception;

begin
	SELECT count(*) into cnt1 from book_issue where card_no = :new.card_no;

	select count(*) into cnt2 from book_issue where book_id = :new.book_id;

	select count(*) into stock from book_stock where book_id = :new.book_id;

	if (cnt1 > 3) then
		raise e1;
	elsif (cnt2 > 0) then 
		raise e2;
	elsif (stock = 0) then
		raise e3;
	else
		update book_stock set copies = copies - 1 where book_id = :new.book_id;
	end if;

exception
	when e1 then
		raise_application_error(-20001,'already issued 3 books');
	when e2 then 
		raise_application_error(-20001,'have issued same book');
	when e3 then 
		raise_application_error(-20001,'stock not avaliable');
	when others then
		dbms_output.put_line('Error..!');

end;
/

------------------------FUNCTION WRITING ---------------------------------------

create or replace function issue_book
 	(opt in varchar2, cno in int, cname in  varchar2, bookid in int)
	return int as done int;
	
	----can define cursor here -----
begin
	select count(*) into done from book_stock;
	return done;
end;
/
