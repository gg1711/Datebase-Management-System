/*
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

drop table OPD_payments;
drop table Appointment;
drop table OPD_schedule;
drop table Patient;
drop table Doctor;


Create table Patient(
	patient_id int primary key,
	patient_name varchar(25),
	dob date,
	sex varchar(5)
);

Create table Doctor(
	doctor_id int primary key,
	doctor_name varchar(25),
	specialization varchar(10),
	unit varchar(15)
);

Create table OPD_schedule(
	doctor_id int references doctor(doctor_id),
	opd_date date,
	fees int
);

Create table Appointment (
	appointment_no int primary key,
	patient_id int references Patient(patient_id), 
	doctor_id int references Doctor(doctor_id), 
	app_date date
);

Create table OPD_payments(
	appointment_no int primary key,
	patient_id int references Patient(patient_id), 
	amt int, 
	date_payment date
);
----------------------CREATING CURSOR FOR Part 2 -------------------------------------
--2
CREATE OR REPLACE trigger pay
after insert on appointment
for each row
declare
	amt int;
	age int;
	sex char;

begin
	select o.fees into amt from opd_schedule o where :new.doctor_id = o.doctor_id;

	age := 0;

	select 2020 - substr(p.dob,1,4) into age from Patient p 
	where :new.patient_id = p.patient_id ;

	select p.sex into sex from Patient p 
	where :new.patient_id = p.patient_id ; 

	if (age  > 50 AND sex = 'F') then
		amt := amt / 2;
	end if;

	insert into OPD_payments values(:new.appointment_no, :new.patient_id, amt, :new.app_date);
end;
/
 -------------------------------------------------------------------------------------

insert into patient values(111,'ravi','2000-11-03','M');
insert into patient values(112,'rama','1999-12-04','F');
insert into patient values(113,'nidhi','1960-12-04','F');
insert into patient values(114,'raju','2000-10-02','M');

insert into doctor values(221,'ram','nuero','2');
insert into doctor values(222,'raj','cardio','3');
insert into doctor values(223,'sai','derma','1');

insert into opd_schedule values (221,'2020-02-02',3000);
insert into opd_schedule values (222,'2020-02-02',4000);
insert into opd_schedule values (223,'2020-02-02',5000);

insert into appointment values (1,111,221,'2020-02-02');
insert into appointment values (2,111,221,'2020-02-03');
insert into appointment values (3,111,222,'2020-02-04');
insert into appointment values (4,112,223,'2020-02-05');
insert into appointment values (5,112,223,'2020-02-06');
insert into appointment values (6,112,223,'2020-02-07');
insert into appointment values (7,113,221,'2020-02-08');
insert into appointment values (8,113,223,'2020-02-09');
insert into appointment values (9,114,221,'2020-02-03');
insert into appointment values (10,114,222,'2020-02-04');


select * from Patient;
select * from Doctor;
select * from OPD_schedule;
select * from Appointment;
select * from OPD_payments;
*/
/*
--1
set serveroutput on;

declare
	pname patient.patient_name%TYPE;
	pId patient.patient_id%TYPE;
	dId appointment.doctor_id%TYPE;

	pname2 patient.patient_name%TYPE;
	pId2 patient.patient_id%TYPE;
	dId2 appointment.doctor_id%TYPE;
	cnt int;

	cursor c is
	select p.patient_name, a.patient_id, a.doctor_id from appointment a, patient p
	where p.patient_id = a.patient_id order by a.patient_id, a.doctor_id;

begin
	open c;
	cnt := 1;
	fetch c into pname, pid, did;
	LOOP
		fetch c into pname2, pid2, did2;
		exit when (c%NOTFOUND = true);
		if (pid = pid2 AND did = did2) then
			cnt := cnt+1;
		end if;
		if(pid != pid2 OR did != did2) then
			if(cnt > 2) then 
				dbms_output.put_line(pname || ' ' || pid || ' '|| did);
			end if;
			pname := pname2; pid := pid2; did := did2; cnt := 1;
		end if;
	END loop;
	close c;
end;
/

--2 DONE Before Inserting

--3
select d.unit , count(*) from doctor d, appointment a
where d.doctor_id = a.doctor_id group by d.unit;

select a.app_date , count(*) from doctor d, appointment a
where d.doctor_id = a.doctor_id group by a.app_date;

--4
create or replace view v4 as
	select * from opd_schedule;

select * from v4;

update v4 
	set opd_date = '&enter_date'
	where doctor_id = '&enter_doctor_id';

select * from opd_schedule;

--5
create view opd_log as
	select p.patient_name, 2020 - substr(p.dob,1,4) as age, a.app_date, d.doctor_name
	from patient p, appointment a, doctor d
	where p.patient_id = a.patient_id AND d.doctor_id = a.doctor_id;

select * from opd_log ;

--6
create or replace view v6 as
	select * from opd_schedule;

select * from v6;

update v6 
	set fees = '&enter_new_fees'
	where doctor_id = '&enter_doctor_id';

select * from opd_schedule;
*/
