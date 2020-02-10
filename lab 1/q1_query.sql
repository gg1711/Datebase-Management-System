
--query a Always distinct 
select name,branch from Student 
where sroll in (select sroll from offer);

select distinct s.name, s.branch from Student s, offer o where s.sroll = o.sroll;

--query b
select sroll,name from Student 
where sroll in (select sroll from offer where osalary>100);

select s.name from student s, offer o where s.sroll = o.sroll AND o.osalary > 100;

--query c
select sroll,name from student
where sroll  in (select sroll from interview) AND sroll NOT in (select sroll from offer);

select s.name from student s, interview i where s.sroll = i.sroll
MINUS
select s.name from student s, offer o where s.sroll = o.sroll;

--query d
select sroll,name from Student 
where sroll in (select sroll from offer) AND programme='M.Tech';

select s.name from student s, offer o where s.sroll = o.sroll AND s.programme = 'M.Tech';

--query e
select sroll,name from Student 
where sroll in (select sroll from offer) AND gender='F';

select s.name from student s, offer o where s.sroll = o.sroll AND s.gender = 'F';

--query f
select branch,count(branch) from Student
where sroll in (select sroll from Offer)
group by branch;

select count(*), s.branch from student s, offer o where s.sroll = o.sroll
group by s.branch 
having count(*) = (select max(count(*))from student s, offer o where s.sroll = o.sroll
group by s.branch ) ;

--query g
select sroll,name from Student
where sroll in (select sroll from offer 
where osalary = (select max(osalary) from offer));

--query h
drop view mx;
create view mx as
select branch br ,max(osalary) sal from student S, Offer O
where O.sroll=S.sroll group by branch;

select s.name from student s, mx, offer o 
where s.sroll=o.sroll AND mx.br=s.branch AND mx.sal=o.osalary;

--query i
drop view br;
create view br as
select s.branch branch, count(s.branch) cnt from student s, offer o
where s.sroll=o.sroll group by s.branch ;

select branch from br
where cnt = (select max(cnt) from br);

--query j
select name from student
MINUS
select s.name from student s, offer o where s.sroll=o.sroll;

--query k
select s.name, s.gender, s.branch, c.name, c.specification, o.osalary 
from student s, company c, offer o
where c.company_id=o.company_id AND o.sroll=s.sroll;
