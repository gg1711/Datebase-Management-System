/*
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD' ;

drop table attendance;
drop table course;
drop table student;

create table student(
sroll int primary key,
name varchar(25) not null,
branch varchar(10) not null,
batch varchar(10) not null,
programme varchar(10) 
);

create table course(
cid int primary key,
cname varchar(10) not null,
instructor varchar(15) not null
);

create table attendance(
sroll int  not null references student(sroll),
course_id int not null references course(cid),
period_s date,
period_e date,
total_classes int not null,
attend int not null,
primary key (sroll, course_id)
);


insert into student values(1,'gaurav','cse','2017','btech');
insert into student values(2,'balaji','cse','2015','btech'); 
insert into student values(3,'sai','mee','2017','btech'); 
insert into student values(4,'rajat','eee','2015','btech'); 
insert into student values(5,'yash','ece','2017','btech'); 

insert into course values(1,'agt','joy');
insert into course values(2,'up','sankarsan');
insert into course values(3,'iem','bartarya');
insert into course values(4,'cms','pr.sahoo');

insert into attendance values(1,1,'2020-01-03','2020-05-06',12,95);
insert into attendance values(2,1,'2020-01-04','2020-05-07',12,80);
insert into attendance values(3,3,'2020-01-03','2020-05-04',12,90);
insert into attendance values(4,2,'2020-01-05','2020-05-07',12,65);
insert into attendance values(5,4,'2020-01-10','2020-05-15',12,75);
insert into attendance values(4,3,'2020-01-08','2020-05-10',10,70);
insert into attendance values(5,2,'2020-01-12','2020-05-15',12,85);



select * from student;
select * from course;
select * from attendance;
*/
/*
--1
select s.name from student s, attendance a
where s.sroll = a.sroll AND a.attend > 80;

--2
create or replace view v2 as
	select a.sroll,s.batch,a.course_id,a.period_s,a.period_e, a.total_classes, a.attend 
	from attendance a, student s where s.sroll = a.sroll AND s.batch = '&enter_batch_year';

select * from v2;

--3
select s.name, v2.course_id from v2,student s where s.sroll = v2.sroll AND v2.attend <=70;

/*
--4
create or replace view v4 as
	select a.sroll, a.course_id, a.attend from attendance a 
	where a.course_id = '&enter_course_id';

select * from v4;

--5
update v4
	set attend = '&enter_new_attendance'
	where sroll = '&sroll';

select * from v4;
select * from attendance;

--6
drop table att_marks;
create table att_marks(
	sroll int references student(sroll),
	course_id int references course(cid),
	marks int
);

set serveroutput on;

declare 
	roll student.sroll%type;
	cid course.cid%type;
	att attendance.attend%type;
	marks int;

begin
	roll := '&sroll';
	cid := '&course_id';
	att := 0;
	select a.attend into att from attendance a where a.sroll = roll AND a.course_id = cid ;
	dbms_output.put_line('attendance '|| att);
	CASE
		when att >=95 then marks := 5;
		when att >=85 then marks := 4;
		when att >=75 then marks := 3;
		when att >=60 then marks := 2;
		when att < 60 then marks := 0;
	end case;
	dbms_output.put_line('marks alloted '||marks);

	insert into att_marks values(roll, cid, marks);

end;
/
select * from att_marks;
*/
