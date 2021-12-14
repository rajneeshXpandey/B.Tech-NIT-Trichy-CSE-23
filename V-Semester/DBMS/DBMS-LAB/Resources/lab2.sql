create table dept
(
	Dno int,
	Dname varchar(255),
	Managername varchar(255),
	primary key (Dno)
);
create table emp 
(
	Empno int,
	Ename varchar(255),
	Address varchar(255),
	Sex 	varchar(15),
	DOB     date,
	Dateofjoining date,
	Deptno int,
	Division varchar(7),
	Desig varchar(31),
	Salary int,
	primary Key(Empno),
	Foreign Key (Deptno) references dept(Dno)
);
insert into dept
values(1,'CSE','CSManager');

insert into dept
values(2,'ECE','ECManager');

insert into dept
values(3,'EEE','EEManager');

insert into dept
values(4,'NA','Anonymous');


insert into emp
values(1,'Emp1','City1','Male','1990-01-02','2013-07-03',1,'se','research',25000);


insert into emp
values(2,'Emp2','City2','Female','1987-06-02','2012-07-03',1,'se','engineering',35000);


insert into emp
values(3,'CSManager','City1','Male','1985-01-02','2010-07-03',1,'se','manager',30000);


insert into emp
values(4,'Emp4','City3','Male','1990-04-02','2013-07-03',2,'se','research',20000);

insert into emp
values(5,'Emp5','City2','Male','1991-01-02','2015-07-03',2,'ne','engineering',27000);


insert into emp
values(6,'ECManager','City1','Male','1980-01-02','2007-07-03',2,'ne','manager',26000);


insert into emp
values(7,'Emp7','City1','Female','1989-01-02','2012-07-03',3,'se','research',18000);

insert into emp
values(8,'Emp8','City3','Female','1990-01-02','2013-07-03',3,'ne','engineering',37000);


insert into emp
values(9,'EEManager','City1','Male','1985-01-02','2011-07-03',3,'se','manager',32000);


/*
1)
mysql> select Ename from emp where Salary>20000 or Salary<10000;
+-----------+
| Ename     |
+-----------+
| Emp1      |
| Emp2      |
| CSManager |
| Emp5      |
| ECManager |
| Emp8      |
| EEManager |
+-----------+
7 rows in set (0.00 sec)

2)mysql> select e.Ename, Dname from emp e,dept d where e.Deptno = d.Dno and Dname in ('ECE','EEE'); +-----------+-------+
| Ename     | Dname |
+-----------+-------+
| Emp4      | ECE   |
| Emp5      | ECE   |
| ECManager | ECE   |
| Emp7      | EEE   |
| Emp8      | EEE   |
| EEManager | EEE   |
+-----------+-------+
6 rows in set (0.00 sec)
mysql> select e.Ename, Dname from emp e,dept d where e.Deptno = d.Dno and Dname = 'CSE' union select e.Ename, Dname from emp e,dept d where e.Deptno = d.Dno and Dname='ECE';
+-----------+-------+
| Ename     | Dname |
+-----------+-------+
| Emp1      | CSE   |
| Emp2      | CSE   |
| CSManager | CSE   |
| Emp4      | ECE   |
| Emp5      | ECE   |
| ECManager | ECE   |
+-----------+-------+
6 rows in set (0.00 sec)

mysql> select e.Ename from emp e where e.Division='se' or e.Division='ne'; +-----------+
| Ename     |
+-----------+
| Emp1      |
| Emp2      |
| CSManager |
| Emp4      |
| Emp5      |
| ECManager |
| Emp7      |
| Emp8      |
| EEManager |
+-----------+
9 rows in set (0.01 sec)
mysql> select e.Ename from emp e where e.Salary in (select max(Salary) from emp);
+-------+
| Ename |
+-------+
| Emp8  |
+-------+
1 row in set (0.00 sec)

mysql> select Desig,avg(Salary) from emp group by Desig;
+-------------+-------------+
| Desig       | avg(Salary) |
+-------------+-------------+
| engineering |  33000.0000 |
| manager     |  29333.3333 |
| research    |  21000.0000 |
+-------------+-------------+
3 rows in set (0.00 sec)

mysql> select Ename from emp e where e.Salary=(select min(Salary) from emp e1 group by Deptno having e1.Deptno=e.Deptno);
+-------+
| Ename |
+-------+
| Emp1  |
| Emp4  |
| Emp7  |
+-------+
3 rows in set (0.01 sec)

mysql> select * from emp e where e.Salary>(select avg(Salary) from emp e1 group by Deptno having e1.Deptno=e.Deptno);
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
| Empno | Ename     | Address | Sex    | DOB        | Dateofjoining | Deptno | Division | Desig       | Salary |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
|     2 | Emp2      | City2   | Female | 1987-06-02 | 2012-07-03    |      1 | se       | engineering |  35000 |
|     5 | Emp5      | City2   | Male   | 1991-01-02 | 2015-07-03    |      2 | ne       | engineering |  27000 |
|     6 | ECManager | City1   | Male   | 1980-01-02 | 2007-07-03    |      2 | ne       | manager     |  26000 |
|     8 | Emp8      | City3   | Female | 1990-01-02 | 2013-07-03    |      3 | ne       | engineering |  37000 |
|     9 | EEManager | City1   | Male   | 1985-01-02 | 2011-07-03    |      3 | se       | manager     |  32000 |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
5 rows in set (0.01 sec)

ysql> SELECT * from emp where Desig NOT LIKE 'Manager';
+-------+-------+---------+--------+------------+---------------+--------+----------+-------------+--------+
| Empno | Ename | Address | Sex    | DOB        | Dateofjoining | Deptno | Division | Desig       | Salary |
+-------+-------+---------+--------+------------+---------------+--------+----------+-------------+--------+
|     1 | Emp1  | City1   | Male   | 1990-01-02 | 2013-07-03    |      1 | se       | research    |  25000 |
|     2 | Emp2  | City2   | Female | 1987-06-02 | 2012-07-03    |      1 | se       | engineering |  35000 |
|     4 | Emp4  | City3   | Male   | 1990-04-02 | 2013-07-03    |      2 | se       | research    |  20000 |
|     5 | Emp5  | City2   | Male   | 1991-01-02 | 2015-07-03    |      2 | ne       | engineering |  27000 |
|     7 | Emp7  | City1   | Female | 1989-01-02 | 2012-07-03    |      3 | se       | research    |  18000 |
|     8 | Emp8  | City3   | Female | 1990-01-02 | 2013-07-03    |      3 | ne       | engineering |  37000 |
+-------+-------+---------+--------+------------+---------------+--------+----------+-------------+--------+
6 rows in set (0.00 sec)


mysql> select * from emp e where e.Salary>(select min(Salary) from emp where emp.Desig='Manager');
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
| Empno | Ename     | Address | Sex    | DOB        | Dateofjoining | Deptno | Division | Desig       | Salary |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
|     2 | Emp2      | City2   | Female | 1987-06-02 | 2012-07-03    |      1 | se       | engineering |  35000 |
|     3 | CSManager | City1   | Male   | 1985-01-02 | 2010-07-03    |      1 | se       | manager     |  30000 |
|     5 | Emp5      | City2   | Male   | 1991-01-02 | 2015-07-03    |      2 | ne       | engineering |  27000 |
|     8 | Emp8      | City3   | Female | 1990-01-02 | 2013-07-03    |      3 | ne       | engineering |  37000 |
|     9 | EEManager | City1   | Male   | 1985-01-02 | 2011-07-03    |      3 | se       | manager     |  32000 |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
5 rows in set (0.00 sec)

mysql> select Dname from dept where (select count(Ename) from emp where Dno=Deptno)=0;
+-------+
| Dname |
+-------+
| NA    |
+-------+
1 row in set (0.00 sec)
'
mysql> select * from emp e where e.Salary>(select max(Salary) from emp where emp.Desig='Manager');
+-------+-------+---------+--------+------------+---------------+--------+----------+-------------+--------+
| Empno | Ename | Address | Sex    | DOB        | Dateofjoining | Deptno | Division | Desig       | Salary |
+-------+-------+---------+--------+------------+---------------+--------+----------+-------------+--------+
|     2 | Emp2  | City2   | Female | 1987-06-02 | 2012-07-03    |      1 | se       | engineering |  35000 |
|     8 | Emp8  | City3   | Female | 1990-01-02 | 2013-07-03    |      3 | ne       | engineering |  37000 |
+-------+-------+---------+--------+------------+---------------+--------+----------+-------------+--------+
2 rows in set (0.00 sec)
mysql> select Ename,(Year(curdate())-Year(DOB))as age from emp;
+-----------+------+
| Ename     | age  |
+-----------+------+
| Emp1      |   29 |
| Emp2      |   32 |
| CSManager |   34 |
| Emp4      |   29 |
| Emp5      |   28 |
| ECManager |   39 |
| Emp7      |   30 |
| Emp8      |   29 |
| EEManager |   34 |
+-----------+------+
9 rows in set (0.00 sec)

mysql> select Ename from emp where (Year(curdate())-Year(Dateofjoining))>10;
+-----------+
| Ename     |
+-----------+
| ECManager |
+-----------+
1 row in set (0.00 sec)


mysql> Create view v1 as select * from emp;
Query OK, 0 rows affected (0.32 sec)

mysql> select * from v1;
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
| Empno | Ename     | Address | Sex    | DOB        | Dateofjoining | Deptno | Division | Desig       | Salary |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
|     1 | Emp1      | City1   | Male   | 1990-01-02 | 2013-07-03    |      1 | se       | research    |  25000 |
|     2 | Emp2      | City2   | Female | 1987-06-02 | 2012-07-03    |      1 | se       | engineering |  35000 |
|     3 | CSManager | City1   | Male   | 1985-01-02 | 2010-07-03    |      1 | se       | manager     |  30000 |
|     4 | Emp4      | City3   | Male   | 1990-04-02 | 2013-07-03    |      2 | se       | research    |  20000 |
|     5 | Emp5      | City2   | Male   | 1991-01-02 | 2015-07-03    |      2 | ne       | engineering |  27000 |
|     6 | ECManager | City1   | Male   | 1980-01-02 | 2007-07-03    |      2 | ne       | manager     |  26000 |
|     7 | Emp7      | City1   | Female | 1989-01-02 | 2012-07-03    |      3 | se       | research    |  18000 |
|     8 | Emp8      | City3   | Female | 1990-01-02 | 2013-07-03    |      3 | ne       | engineering |  37000 |
|     9 | EEManager | City1   | Male   | 1985-01-02 | 2011-07-03    |      3 | se       | manager     |  32000 |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
9 rows in set (0.00 sec)

mysql> CREATE VIEW v2 as select * from v1 where Deptno = 1;
Query OK, 0 rows affected (0.31 sec)

mysql> select * from v2;
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
| Empno | Ename     | Address | Sex    | DOB        | Dateofjoining | Deptno | Division | Desig       | Salary |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
|     1 | Emp1      | City1   | Male   | 1990-01-02 | 2013-07-03    |      1 | se       | research    |  25000 |
|     2 | Emp2      | City2   | Female | 1987-06-02 | 2012-07-03    |      1 | se       | engineering |  35000 |
|     3 | CSManager | City1   | Male   | 1985-01-02 | 2010-07-03    |      1 | se       | manager     |  30000 |
+-------+-----------+---------+--------+------------+---------------+--------+----------+-------------+--------+
3 rows in set (0.00 sec)


*/




