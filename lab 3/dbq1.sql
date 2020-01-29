ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
drop table DEPENDENT;
drop table WORKS_ON;
drop table PROJECT;
drop table DEPT_LOCATIONS;
drop table EMPLOYEE;
drop table DEPARTMENT;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

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
	Dno int not null references DEPARTMENT(Dnumber) on delete cascade
	);

create table DEPT_LOCATIONS(
	Dnumber int not null references DEPARTMENT(Dnumber) on delete cascade,
	Dlocation varchar(20) not null
);

create table PROJECT(
	Pname varchar(20) not null,
	Pnumber int not null primary key,
	Plocation varchar(20) not null,
	Dnum int not null references DEPARTMENT(Dnumber) on delete cascade
);

create table WORKS_ON(
	Essn varchar(20) not null references EMPLOYEE(Ssn) on delete cascade,
	Pno int not null references PROJECT(Pnumber) on delete cascade,
	Hours float
);

create table DEPENDENT(
	Essn varchar(20) not null references EMPLOYEE(Ssn) on delete cascade,
	Dependent_name varchar(20) not null,
	Sex char not null,
	Bdate date not null,
	Relationship varchar(20) not null
);

--------------------------------------------------------------------------------------------------------------------------------------------------

insert into DEPARTMENT values('Research', '5', '333445555', '1988-05-22');
insert into DEPARTMENT values('Administration', '4', '987654321', '1995-01-01');
insert into DEPARTMENT values('Headquarters', '1', '888665555', '1981-06-19');

insert into EMPLOYEE values('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', '30000', '333445555', '5');
insert into EMPLOYEE values('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', '40000', '888665555', '5');
insert into EMPLOYEE values('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', '25000', '987654321', '4');
insert into EMPLOYEE values('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', '43000', '888665555', '4');
insert into EMPLOYEE values('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', '38000', '333445555', '5');
insert into EMPLOYEE values('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', '25000', '333445555', '5');
insert into EMPLOYEE values('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', '25000', '987654321', '4');
insert into EMPLOYEE values('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', '55000', NULL, '1');

insert into DEPT_LOCATIONS values('1', 'Housten');
insert into DEPT_LOCATIONS values('4', 'Stafford');
insert into DEPT_LOCATIONS values('5', 'Bellaire');
insert into DEPT_LOCATIONS values('5', 'Sugarland');
insert into DEPT_LOCATIONS values('5', 'Housten');

insert into PROJECT values('ProductX', '1', 'Bellaire', '5');
insert into PROJECT values('ProductY', '2', 'Sugarland', '5');
insert into PROJECT values('ProductZ', '3', 'Houston', '5');
insert into PROJECT values('Computerization', '10', 'Stafford', '4');
insert into PROJECT values('Reorganization', '20', 'Houston', '1');
insert into PROJECT values('Newbenefits', '30', 'Stafford', '4');

insert into WORKS_ON values('123456789', '1', '32.5');
insert into WORKS_ON values('123456789', '2', '7.5');
insert into WORKS_ON values('666884444', '3', '40.0');
insert into WORKS_ON values('453453453', '1', '20.0');
insert into WORKS_ON values('453453453', '2', '20.0');
insert into WORKS_ON values('333445555', '2', '10.0');
insert into WORKS_ON values('333445555', '3', '10.0');
insert into WORKS_ON values('333445555', '10', '10.0');
insert into WORKS_ON values('333445555', '20', '10.0');
insert into WORKS_ON values('999887777', '30', '30.0');
insert into WORKS_ON values('999887777', '10', '10.0');
insert into WORKS_ON values('987987987', '10', '35.0');
insert into WORKS_ON values('987987987', '30', '5.0');
insert into WORKS_ON values('987654321', '30', '20.0');
insert into WORKS_ON values('987654321', '20', '15.0');
insert into WORKS_ON values('888665555', '20', NULL);

insert into DEPENDENT values('333445555', 'Alice', 'F', '1986-04-05', 'Daughter');
insert into DEPENDENT values('333445555', 'Theodore', 'M', '1983-10-25', 'Son');
insert into DEPENDENT values('333445555', 'Joy', 'F', '1958-05-03', 'Spouse');
insert into DEPENDENT values('987654321', 'Abner', 'M', '1942-02-28', 'Spouse');
insert into DEPENDENT values('123456789', 'Michael', 'M', '1988-01-04', 'Son');
insert into DEPENDENT values('123456789', 'Alice', 'F', '1988-12-30', 'Daughter');
insert into DEPENDENT values('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

select * from department;
select * from EMPLOYEE;
select * from DEPT_LOCATIONS;
select * from WORKS_ON;
select * from PROJECT;
select * from DEPENDENT;

set serveroutput on;

--a
DECLARE 
	essn EMPLOYEE.Ssn%TYPE;
	mssn DEPARTMENT.Mgr_ssn%TYPE;
	dno EMPLOYEE.Dno%TYPE;
	sal EMPLOYEE.Salary%TYPE;
	name EMPLOYEE.fname%TYPE;
	cnt int;

	cursor c IS
		select dno,Salary,ssn,fname from EMPLOYEE;
BEGIN
	open c;
	
LOOP
	fetch c into dno,sal,essn,name;
		
	select count(*) INTO cnt from DEPARTMENT where essn=Mgr_ssn;
	
	IF (cnt > 0) then
		dbms_output.put_line('manager '|| sal*1.2 || ' ' || essn);
		update EMPLOYEE E set E.Salary=sal*1.2 where E.ssn=essn;
	ELSIF (dno = 1) then
		dbms_output.put_line(' dno=1 '|| sal*1.1 || ' ' || essn);
		update EMPLOYEE E set E.Salary=sal*1.1 where E.dno = dno;
	ELSIF (dno = 4) then
		dbms_output.put_line('dno=4 '|| sal*1.15 || ' ' || essn);
		update EMPLOYEE E set E.Salary=sal*1.15 where E.dno = dno;
	ELSIF (dno = 5) then
		dbms_output.put_line('dno=5 '|| sal*1.18 || ' ' || essn);
		update EMPLOYEE E set E.Salary=sal*1.18 where E.dno = dno;
	END IF;

	EXIT when (c%NOTFOUND = TRUE);
END LOOP;
close c;
END;
/

--b
DECLARE
	max_sal EMPLOYEE.Salary%TYPE;
	sal EMPLOYEE.Salary%TYPE;
	ename EMPLOYEE.fname%TYPE;

	cursor c IS
	select Salary,fname from EMPLOYEE;

BEGIN
	select max(Salary) into max_sal from EMPLOYEE;
	open c;
	LOOP
		fetch c into sal,ename;
		exit when (c%NOTFOUND = TRUE);
		if(sal=max_sal) then
		dbms_output.put_line(ename || ' ' ||sal);
		end if;

	end LOOP;
	close c;
END;
/
--c

DECLARE
	n int;
	ename EMPLOYEE.fname%TYPE;
	sal EMPLOYEE.Salary%type;

	cursor c IS
	select fname, Salary from EMPLOYEE order by salary DESC;

BEGIN
	select count(*) into n from EMPLOYEE;
	dbms_output.put_line(n);
	n:=n/2;
	dbms_output.put_line(n); --WEIRD 9/2 =5
	open c;
	LOOP
		fetch c into ename,sal;
		dbms_output.put_line(ename || ' ' || sal);
		n:=n-1;

		EXIT when (n=0);
	end LOOP;
end;
/
