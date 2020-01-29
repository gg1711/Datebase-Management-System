
drop table grade_report;
drop table prerequisite;
drop table section;
drop table student;
drop table course;

create table STUDENT (
	name varchar(15) not null,
	student_no number(10) primary key,
	class number(5) not null,
	major varchar(15)
);


insert into STUDENT values ('Smith',17,1,'CS');

insert into STUDENT values ('Brown',8,2,'CS');

insert into STUDENT values ('Gaurav',15,5,'CSE');

insert into STUDENT values ('Rajat',7,8,'CSE');

insert into STUDENT values ('sai',2,8,'CSE');

insert into STUDENT values ('himanshu',12,10,'CSE');



--select * from student;

create table COURSE(
	courseName Varchar(15) not null,
	courseNo varchar(15) primary key,
	creditHour number(5) not null,
	department varchar(15) not null
);


insert into course values
  ('pds','cs1310',4,'CS');

insert into course values
  ('data structure','cs3320',4,'CS');

insert into course values
  ('discrete str','math2410',3,'MATH');

insert into course values
  ('database','cs3380',3,'CS');

--select * from course;



create table section(
	sectionID number(15) primary key,
	courseNo varchar(15) references course(courseNo) on delete cascade,
	semester varchar(15) not null,
	year number(5) not null,
	instructor varchar(15) not null
);


insert into section values (85,'math2410','fall',07,'Joy sir');

insert into section values (92,'cs1310','fall',07,'Adway sir');

insert into section values (115,'cs3380','fall',09,'Adway sir');

insert into section values (102,'cs3320','spring',08,'dogra sir');

insert into section values (112,'math2410','fall',08,'bera sir');

insert into section values (119,'cs1310','fall',08,'sudipta sir');

insert into section values (170,'cs3320','fall',08,'sudipta sir');

insert into section values (135,'cs3380','fall',08,'pinisetty sir');	

insert into section values (140,'cs1310','fall',08,'anderson');

insert into section values (150,'cs3380','fall',08,'anderson');

insert into section values (160,'cs3320','fall',09,'anderson');

insert into section values (180,'math2410','fall',07,'Joy sir');

insert into section values (190,'cs1310','fall',07,'Adway sir');


--select * from section;


create table grade_report(
	student_no number(10) ,
	sectionID number(5) references section(sectionID) on delete cascade,
	grade varchar(15) not null,
	constraint fk_grade foreign key (student_no) references student(student_no) on delete cascade
);



insert into grade_report values
	(17,112,'B');

insert into grade_report values
	(2,170,'F');

insert into grade_report values
	(12,180,'F');

insert into grade_report values
	(12,190,'F');

insert into grade_report values
	(17,115,'A');

insert into grade_report values
	(17,119,'C');

insert into grade_report values
	(8,85,'A');

insert into grade_report values
	(8,92,'A');

insert into grade_report values
	(8,102,'B');

insert into grade_report values
	(8,135,'A');

insert into grade_report values
	(15,140,'A');

insert into grade_report values
	(15,150,'A');

insert into grade_report values
	(7,160,'A');

--select * from grade_report;



create table PreRequisite(
	courseNo varchar(15) references course(courseNo) on delete cascade,
	Prerequisite_course varchar(15) references course(courseNo) on delete cascade,
	constraint pk_pre PRIMARY KEY(courseNo, Prerequisite_course)
);

insert into PreRequisite values('cs3380','cs3320');

insert into PreRequisite values('cs3380','math2410');

insert into PreRequisite values('cs3320','cs1310');

--select * from PreRequisite;


select * from student;

select * from course;

select * from section;

select * from grade_report;

select * from PreRequisite;

