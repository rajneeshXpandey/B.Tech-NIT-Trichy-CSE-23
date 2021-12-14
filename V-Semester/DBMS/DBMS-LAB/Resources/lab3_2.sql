create table D
(
	deptid int,
	deptname varchar(255),
	primary key(deptid)
);

create table S
(
	rollno int,
	name varchar(255),
	gender varchar(15),
	mark1 int ,
	mark2 int,
	mark3 int,
	total int,
	average int,
	deptid int,
	primary key(rollno),
	foreign key(deptid) references D(deptid)
);

create table Staff
(
	staffid int,
	name varchar(255),
	designation varchar(31),
	qualification varchar(15),
	deptid int,
	primary key(staffid),
	foreign key(deptid) references D(deptid)
);	

create table Tutor
(
	rollno int, staffid int,
	foreign key(rollno) references S(rollno),
	foreign key(staffid) references Staff(staffid)
);
insert into  D
values(1,'CSE');
insert into  D
values(2,'ECE');

insert into S
values(1,'RStudent1','male',97,75,65,0,0,1);
insert into S
values(2,'Student2','male',94,75,85,0,0,1);
insert into S
values(3,'Student3','female',93,95,75,0,0,1);
insert into S
values(4,'Student4','male',97,75,55,0,0,2);
insert into S
values(5,'Student5','female',81,75,75,0,0,2);
insert into S
values(6,'RStudent6','female',86,75,55,0,0,2);

insert into Staff
values (1,'Staff1','Professor','B.Tech',1);
insert into Staff
values (2,'Staff2','Asst. Professor','B.Tech',1);
insert into Staff
values (3,'Staff3','Professor','B.Sc',1);
insert into Staff
values (4,'Staff4','Professor','B.Tech',2);
insert into Staff
values (5,'Staff5','Asst. Professor','B.Tech',2);
insert into Staff
values (6,'Staff6','Professor','B.Sc',2);

insert into Tutor
values(1,1);
insert into Tutor
values(2,2);
insert into Tutor
values(3,3);
insert into Tutor
values(4,4);
insert into Tutor
values(5,6);
insert into Tutor
values(6,5);

update S
set total=mark1+mark2+mark3;

update S
set average=total/3;



