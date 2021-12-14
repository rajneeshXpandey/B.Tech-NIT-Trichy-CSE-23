create table Employee(
fname varchar(20),
lname varchar(20),
ssn int primary key,
bdate date,

sex varchar(10),
salary int,
superssn int,
dno int references Department(dno),
workexp int);
create table Department(
dname varchar(20),
dno int primary key,
mgrssn int,
dlocation varchar(20));
create table Project(
pname varchar(20),
pnumber int primary key,
plocation varchar(20),
dno int references Department(dno));
 
insert into Employee values('a','b',1,12-03-1991,'M',12000,11,111,2);

