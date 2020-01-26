drop table offer;
drop table interview;
drop table student;
drop table company;


CREATE TABLE Student(
sroll varchar(10) not null primary key,
name varchar(20) not null,
gender varchar(1) not null,
branch varchar(5) not null,
programme varchar(10) not null,
CGPA number(4,2) not null
);

INSERT INTO Student VALUES('17CS01032','YASH','M','CSE','B.Tech',8.02);
INSERT INTO Student VALUES('17EE01033','RAJAT','M','EE','B.Tech',8.00);
INSERT INTO Student VALUES('17CS01055','GAURAV','M','CSE','M.Tech',8.02);
INSERT INTO Student VALUES('17EE01003','RAHUL','M','EE','B.Tech',8.50);
INSERT INTO Student VALUES('17CE01019','SAI','M','CE','M.Tech',8.22);
INSERT INTO Student VALUES('17EE01065','BALAJI','F','EE','M.Tech',9.32);
INSERT INTO Student VALUES('17ECE01040','HIMANSHU','F','ECE','B.Tech',8.63);

CREATE TABLE Company(
company_id varchar(10) not null primary key,
name varchar(20) not null,
specification varchar(20) not null
);


INSERT INTO Company VALUES('GMS','GOLDMAN','SOFTWARE');
INSERT INTO Company VALUES('MS','MICROSOFT','SOFTWARE');
INSERT INTO Company VALUES('TSC','TESCO','SOFTWARE');
INSERT INTO Company VALUES('GG','GOOGLE','SOFTWARE');
INSERT INTO Company VALUES('GE','GENERAL ELECRICS','SOFTWARE');
INSERT INTO Company VALUES('LNT','LNT','CONSTRUCTION');

CREATE TABLE Interview(
sroll varchar(10) references Student(sroll),
company_id varchar(20) references Company(company_id),
idate DATE NOT NULL, 
constraint pk_interview PRIMARY KEY(sroll,company_id)
);

INSERT INTO Interview VALUES('17CS01032','GMS',TO_DATE('2019/10/21','YYYY/MM/DD'));
INSERT INTO Interview VALUES('17EE01033','GMS',TO_DATE('2019/10/21','YYYY/MM/DD'));
INSERT INTO Interview VALUES('17EE01003','MS',TO_DATE('2019/10/23','YYYY/MM/DD'));
INSERT INTO Interview VALUES('17CE01019','LNT',TO_DATE('2019/11/21','YYYY/MM/DD'));
INSERT INTO Interview VALUES('17CS01055','TSC',TO_DATE('2019/10/26','YYYY/MM/DD'));
INSERT INTO Interview VALUES('17EE01065','GE',TO_DATE('2019/10/21','YYYY/MM/DD'));


CREATE TABLE Offer(
sroll varchar(10) references Student(sroll) ,
company_id varchar(20) references Company(company_id),
osalary number(10),
constraint pk_offer PRIMARY KEY(sroll,company_id)
);

INSERT INTO Offer VALUES('17CS01032','GMS',85);
INSERT INTO Offer VALUES('17EE01033','GMS',150);
INSERT INTO Offer VALUES('17EE01003','MS',180);
INSERT INTO Offer VALUES('17EE01065','GE',150);
INSERT INTO Offer VALUES('17CS01055','TSC',75);
INSERT INTO Offer VALUES('17CE01019','LNT',159);


select * from Student;

select * from Company;

select * from Interview;

select * from Offer;

