create table Student(
Rollno int primary key,
deptid int references Dept(deptid),
Name varchar(20),
Math int,
Phy int,
Chem int,
Year_of_study int);
Create table Dept(
deptid int primary key,
dname varchar(25),
location varchar(20),
HOD varchar(20));

insert into Student values(1,11,'A',90,90,90,2);
insert into Student values(2,12,'B',91,91,91,2);
insert into Student values(3,11,'C',92,92,92,4);
insert into Student values(4,12,'D',93,93,93,3);
insert into Student values(5,11,'E',94,94,94,2);

insert into Dept values(11,'CSE','AA','AAA');
insert into Dept values(12,'ECESE','AA','ABA');

