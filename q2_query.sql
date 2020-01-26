/*
create table STUDENT (
	name varchar(15) not null,
	student_no number(10) primary key,
	class number(5) not null,
	major varchar(15)
);

create table COURSE(
	courseName Varchar(15) not null,
	courseNo varchar(15) primary key,
	creditHour number(5) not null,
	department varchar(15) not null
);

create table section(
	sectionID number(15) primary key,
	courseNo varchar(15) references course(courseNo),
	semester varchar(15) not null,
	year number(5) not null,
	instructor varchar(15) not null
);

create table grade_report(
	student_no number(10) ,
	sectionID number(5) references section(sectionID) ,
	grade varchar(15) not null,
	constraint fk_grade foreign key (student_no) references student(student_no)
);

create table PreRequisite(
	courseNo varchar(15) references course(courseNo),
	Prerequisite_course varchar(15) references course(courseNo),
	constraint pk_pre PRIMARY KEY(courseNo, Prerequisite_course)
);
*/



--query1

select st.name, S.courseNo, S.semester, S.year, S.sectionID, G.grade 
from section S, grade_report G, student st 
where G.sectionId = S.sectionID AND st.student_no = G.student_no;


--query2
select name from student 
minus
select distinct S.name from Student S, grade_report G
where S.student_no = G.student_no AND G.grade != 'A';


-- NOT working
--select st.name from student st 
--where not exists (select distinct S.name from Student S, grade_report G
--where S.student_no = G.student_no AND G.grade != 'A');

--query3
select S.courseNo, count(student_no) from section S, grade_report G
where S.sectionID=G.sectionID group by S.courseNo;

--query4
select distinct  s.name from student s, section sec, grade_report G
where sec.sectionID = G.sectionID AND s.student_no=G.student_no AND sec.instructor='anderson';


--query5
--select s.name, C.courseName, C.creditHour from section sec, course C, grade_report G, student S
--where sec.courseNo=C.courseNo and sec.sectionID=G.sectionID and S.student_no=G.student_no AND year=&year;

select s.name, sum(C.creditHour) from section sec, course C, grade_report G, student S
where sec.courseNo=C.courseNo and sec.sectionID=G.sectionID and S.student_no=G.student_no AND year=&year
group by s.name;


--query6
drop view cs2;
CREATE VIEW cs2 as 
select s.name name ,count(s.name) cnt from section sec, grade_report G, student S
where sec.sectionID=G.sectionID AND S.student_no= G.student_no AND sec.courseNo like 'cs%'  
group by s.name;

select distinct s.name from section sec, grade_report G, student S
where sec.sectionID=G.sectionID AND S.student_no= G.student_no AND sec.courseNo like 'ma%'
INTERSECT
select name from cs2 where cnt=2;

--query7
--Don't do as this will delete records
--delete from course where courseNo='math2410';


--query8
drop view f2;
CREATE VIEW f2 as 
select s.name name ,count(s.name) cnt from section sec, grade_report G, student S
where sec.sectionID=G.sectionID AND S.student_no= G.student_no AND G.grade='F'  
group by s.name;

select name from f2 where cnt>1;

--query9
Update grade_report 
set grade = CASE
when grade='A' then '10'
when grade='B' then '9'
when grade='C' then '8'
when grade='D' then '7'
when grade='E' then '6'
when grade='F' then '5'
END;

select * from grade_report;


