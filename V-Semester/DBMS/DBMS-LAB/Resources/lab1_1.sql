
Create table emp1(
eid integer primary key,
ename varchar(20),
addr varchar(20),
doj varchar(20),
salary integer);

Create table proj(
no integer primary key,
dur integer,
pname varchar(20));

create table work(
eid integer references emp1(eid),
no integer references proj(no));

insert into emp1 values(1,'a','asdf','2019','25000');

insert into emp1 values(2,'b','bsdf','2029','35000');

insert into emp1 values(3,'c','csdf','2019','45000');

insert into emp1 values(4,'d','dsdf','2019','55000');

insert into emp1 values(5,'e','esdf','2019','65000');

insert into proj values(11,2,'ab');

insert into proj values(21,3,'2ab');

insert into proj values(31,2,'3ab');

insert into proj values(41,2,'4bb');

insert into work values(1,11);

insert into work values(2,21);

insert into work values(3,31);

insert into work values(4,41);

insert into work values(5,31);


/*
mysql> select * from emp1;
+-----+-------+------+------+--------+
| eid | ename | addr | doj  | salary |
+-----+-------+------+------+--------+
|   1 | a     | asdf | 2019 |  25000 |
|   2 | b     | bsdf | 2029 |  35000 |
|   3 | c     | csdf | 2019 |  45000 |
|   4 | d     | dsdf | 2019 |  55000 |
|   5 | e     | esdf | 2019 |  65000 |
+-----+-------+------+------+--------+
5 rows in set (0.00 sec)

mysql> select * from proj;
+----+------+-------+
| no | dur  | pname |
+----+------+-------+
| 11 |    2 | ab    |
| 21 |    3 | 2ab   |
| 31 |    2 | 3ab   |
| 41 |    2 | 4bb   |
+----+------+-------+
4 rows in set (0.00 sec)

mysql> select * from work;
+------+------+
| eid  | no   |
+------+------+
|    1 |   11 |
|    2 |   21 |
|    3 |   31 |
|    4 |   41 |
|    5 |   31 |
+------+------+
5 rows in set (0.00 sec)
1)

mysql> select * from emp1 order by ename DESC;
+-----+-------+------+------+--------+
| eid | ename | addr | doj  | salary |
+-----+-------+------+------+--------+
|   5 | e     | esdf | 2019 |  65000 |
|   4 | d     | dsdf | 2019 |  55000 |
|   3 | c     | csdf | 2019 |  45000 |
|   2 | b     | bsdf | 2029 |  35000 |
|   1 | a     | asdf | 2019 |  25000 |
+-----+-------+------+------+--------+
5 rows in set (0.00 sec)

2)mysql> select * from proj where no=31;
+----+------+-------+
| no | dur  | pname |
+----+------+-------+
| 31 |    2 | 3ab   |
+----+------+-------+
1 row in set (0.00 sec)

3)
mysql> select * from proj where pname like '3%';
+----+------+-------+
| no | dur  | pname |
+----+------+-------+
| 31 |    2 | 3ab   |
+----+------+-------+
1 row in set (0.00 sec)

4)mysql> select * from proj where pname like '3%';
+----+------+-------+
| no | dur  | pname |
+----+------+-------+
| 31 |    2 | 3ab   |
+----+------+-------+
1 row in set (0.00 sec)

*/


