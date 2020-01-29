
drop table graph;

create table graph(
	v1 int not null,
	v2 int not null,
	cost int not null
);

insert into graph values(1,2,5);
insert into graph values(2,3,6);
insert into graph values(3,4,4);
insert into graph values(2,6,2);
insert into graph values(1,5,3);
insert into graph values(5,6,6);
insert into graph values(6,1,8);
insert into graph values(6,3,12);
insert into graph values(3,6,12);
insert into graph values(6,7,9);

select * from graph;

set serveroutput on
DECLARE
	max_dgr int;
	min_dgr int;
	ver1 graph.v2%type;
	ver2 int;
	cnt int;
	cnt2 int;
	pcost int;

	cursor c1 is
		select count(*),v1 from graph g group by v1;

	cursor c2 is
		select count(*),v1 from graph g group by v1;

	cursor d is
		select 0,g1.v2 from graph g1
		where (select count(*) from graph g2 where g1.v2=g2.v1) = 0;

	CURSOR e is
		select g1.v1, g2.v2,g1.cost+g2.cost from graph g1,graph g2
		where g1.v2=g2.v1 AND g1.cost+g2.cost<10;
BEGIN
	select max(count(*)) into max_dgr from graph group by v1;

	select count(*) into cnt from graph g1
	where (select count(*) from graph g2 where g1.v2=g2.v1) = 0;

	select min(count(*)) into min_dgr from graph group by v1;
	
	dbms_output.put_line('Min_degree');
	
	if(cnt>0) then
		open d;
		LOOP
			fetch d into cnt2, ver1;
			exit when d%notfound;
			dbms_output.put_line(cnt2 || ' ' || ver1);

		end LOOP;
		close d;
	ELSE
		open c1;
		loop
			fetch c1 into cnt2,ver1;
			exit when c1%notfound;
			if(cnt2=min_dgr) then
				dbms_output.put_line(cnt2 || ' ' || ver1);
			end if;

		end loop;
		close c1;
	end if;

	dbms_output.put_line('MAX_degree');

	open c2;
	loop
		fetch c2 into cnt2,ver1;
		exit when c2%notfound;
		if(cnt2=max_dgr) then
			dbms_output.put_line(cnt2 || ' ' || ver1);
		end if;

	end loop;
	close c2;

	dbms_output.put_line(' PATH_WITH_COST<10 ');

	open e;
	loop
		fetch e into ver1,ver2,pcost;
		exit when e%notfound;
		dbms_output.put_line(ver1 || ' ' || ver2 || ' ' || pcost);
	end loop;
	close e;

END;
/

