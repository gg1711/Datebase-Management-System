/*
create table DEPARTMENT(
	Dname varchar(20) not null ,
	Dnumber int not null primary key,
	Mgr_ssn varchar(20),
	Mgr_start_date date not null
);

create table EMPLOYEE(
	Fname varchar(20) not null,
	Minit char not null,
	Lname varchar(20) not null,
	Ssn varchar(20) not null primary key,
	Bdate date not null,
	Address varchar(30) not null,
	Sex char not null,
	Salary int not null, 
	Super_ssn varchar(20),
	Dno int not null references DEPARTMENT(Dnumber)
	);

create table DEPT_LOCATIONS(
	Dnumber int not null references DEPARTMENT(Dnumber),
	Dlocation varchar(20) not null
);

create table PROJECT(
	Pname varchar(20) not null,
	Pnumber int not null primary key,
	Plocation varchar(20) not null,
	Dnum int not null references DEPARTMENT(Dnumber)
);

create table WORKS_ON(
	Essn varchar(20) not null references EMPLOYEE(Ssn),
	Pno int not null references PROJECT(Pnumber),
	Hours float
);

create table DEPENDENT(
	Essn varchar(20) not null references EMPLOYEE(Ssn),
	Dependent_name varchar(20) not null,
	Sex char not null,
	Bdate date not null,
	Relationship varchar(20) not null
);
*/

--a
select P.pname, D.Dname, E.Fname, E.Address, E.Bdate from PROJECT P, DEPARTMENT D, EMPLOYEE E
where P.Dnum=D.Dnumber AND D.Mgr_ssn=E.Ssn AND P.Plocation='Stafford'; 

--b
select E.Fname, E.Salary*1.1 from Project P, EMPLOYEE E, WORKS_ON W
where E.Ssn=W.Essn AND W.Pno=P.Pnumber AND P.Pnumber = (select distinct pr.Pnumber from Project pr where Pname='ProductX');

--c
select E.Fname, E.Lname, P.Pname, D.Dnumber from EMPLOYEE E,PROJECT P, DEPARTMENT D
where P.Dnum=D.Dnumber AND E.Dno=D.Dnumber 
order by D.Dnumber ASC, E.Lname ASC, E.Fname DESC; 

--d
drop view d1;
create view d1 as 
select distinct E.Fname as Fname, E.Super_ssn as Super_ssn from EMPLOYEE E, DEPARTMENT D, PROJECT P, WORKS_ON W 
where W.Pno=P.Pnumber AND W.Essn=E.Ssn
AND P.Pnumber = (select pr.Pnumber from project pr where pr.Pname='ProductX')
AND W.Hours > 10;

select d1.Fname, E.Fname from d1, EMPLOYEE E
where d1.Super_ssn=E.Ssn AND E.Dno=5;

--e
drop view e1;
create view e1 as 
select distinct P.Pnumber as Pnumber, W.Hours as Hours from EMPLOYEE E, DEPARTMENT D, PROJECT P, WORKS_ON W 
where W.Pno=P.Pnumber AND W.Essn=E.Ssn AND E.Ssn='123456789';

--select * from e1;

select distinct E.ssn, E.Fname from  e1, EMPLOYEE E, DEPARTMENT D, PROJECT P, WORKS_ON W 
where W.Pno=P.Pnumber AND W.Essn=E.Ssn AND e1.Pnumber=P.Pnumber AND e1.Hours=W.Hours;

--f
select E.fname from EMPLOYEE E, DEPENDENT DD 
where E.ssn=Dd.Essn AND E.Fname=DD.Dependent_name AND E.Sex=DD.Sex;

--g
select sum(Salary),max(salary),avg(salary),min(salary) from EMPLOYEE E, DEPARTMENT D 
where E.Dno=D.Dnumber AND D.Dnumber = (select dep.Dnumber from DEPARTMENT dep where dep.dname='Research');

 --h
 drop view h1;
 create view h1 as
 select D.Dnumber as Dnumber, count(D.Dnumber) as cnt from DEPARTMENT D, EMPLOYEE E
 where D.Dnumber=E.Dno 
 group by D.Dnumber;

select D.Dnumber, E.fname from EMPLOYEE E, DEPARTMENT D, h1
where E.Dno=D.dnumber AND h1.Dnumber=D.Dnumber AND h1.cnt > 3;

--i
update employee set salary= 1.1*salary
where ssn in (select Essn from DEPENDENT where Relationship='Daughter');
select fname,salary from employee;

--j
update employee EE set Dno=
(select Dl.dnumber from DEPT_LOCATIONS Dl
where Dl.Dlocation='Stafford')
where EE.Bdate like '1965%' ;

select E.fname,E.Dno from employee E;

--k
drop view k1;
create view k1 as 
select Pno from WORKS_ON 
where Essn = (select ssn from EMPLOYEE where Lname='Smith');

--select * from k1;

drop view k2;
create view k2 as 
select W.essn essn ,count(W.Pno) pno from WORKS_ON W
where W.pno = ANY (select k1.Pno from k1)
group by W.essn having count(W.Pno) = (select count(pno) from k1);

--select * from k2;

select E.fname from EMPLOYEE E, k2
where E.ssn = k2.Essn AND E.Lname!='Smith';

s

--l
drop view dept_empdetails;
create view dept_empdetails as
select sum(salary) dsal, count(Dno) dcnt from EMPLOYEE
group by Dno;

select * from dept_empdetails;

insert into EMPLOYEE values('Gaurav', 'A', 'Englisdh', '455453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', '25000', '333445555', '5');

select * from dept_empdetails;

--m
Alter table EMPLOYEE
ADD commision int;

update  EMPLOYEE set commision=1000 where dno=5;
update  EMPLOYEE set commision=2000 where dno=4;
update  EMPLOYEE set commision=NULL where dno=1;

select * from EMPLOYEE;

--n
select * from project;
delete from PROJECT where Pname='Newbenefits';
select * from project;

--o
--select * from WORKS_ON;
drop view o1;
create view o1 as
select P.Pnumber as Pno from Project P where Plocation='Houston';

--select * from o1;

drop view o2;
create view o2 as
select essn from WORKS_ON
where pno = ANY(select o1.pno from o1)
group by essn having count(essn) = (select count(o1.pno) from o1);

--select * from o2;

select e.fname from EMPLOYEE e, o2
where e.ssn=o2.Essn;

--p
select 2020-substr(Bdate,1,4), salary from EMPLOYEE
where Dno = (select Dnumber from DEPARTMENT where dname='&d');

--q
drop view payroll;
create view payroll as
select ssn, fname, dno,salary from EMPLOYEE;

--select * from payroll;

update payroll set salary=1.2*salary where dno=5;

--select * from payroll;
select salary from EMPLOYEE;
