
Create table student(
rno integer primary key,
name varchar(20),
m1 integer,
m2 integer,
m3 integer,
m4 integer,
m5 integer,
m6 integer
);

Create table department(
did integer primary key,
dname varchar(20),
hname varchar(20));

create table studdept(
rno integer references student(rno),
did integer references department(did));

insert into student values(1,'a',10,11,12,13,14,15);
insert into student values(2,'b',20,21,12,13,14,15);
insert into student values(3,'c',30,31,12,13,34,15);
insert into student values(4,'d',40,11,42,13,44,15);
insert into student values(5,'e',10,31,32,33,34,15);
insert into student values(6,'f',10,41,12,43,14,45);

insert into department values(11,'cse','ab');
insert into department values(12,'ece','cd');

insert into department values(13,'eee','ef');

insert into studdept values(1,11);
insert into studdept values(2,11);
insert into studdept values(3,12);
insert into studdept values(4,12);
insert into studdept values(5,13);
insert into studdept values(6,13);


/*

2)mysql> select * from student inner join  studdept on studdept.rno=student.rno where studdept.did=12;
+-----+------+------+------+------+------+------+------+------+------+
| rno | name | m1   | m2   | m3   | m4   | m5   | m6   | rno  | did  |
+-----+------+------+------+------+------+------+------+------+------+
|   3 | c    |   30 |   31 |   12 |   13 |   34 |   15 |    3 |   12 |
|   4 | d    |   40 |   11 |   42 |   13 |   44 |   15 |    4 |   12 |
+-----+------+------+------+------+------+------+------+------+------+
2 rows in set (0.00 sec)

3)mysql> select * from department inner join studdept on studdept.did=department.did where studdept.rno=1;
+-----+-------+-------+------+------+
| did | dname | hname | rno  | did  |
+-----+-------+-------+------+------+
|  11 | cse   | ab    |    1 |   11 |
+-----+-------+-------+------+------+
1 row in set (0.00 sec)

4)mysql> alter table student add tot integer;
Query OK, 0 rows affected (0.89 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> update student set tot=m1+m2+m3+m4+m5+m6;
Query OK, 6 rows affected (0.34 sec)
Rows matched: 6  Changed: 6  Warnings: 0

mysql> select * from student;
+-----+------+------+------+------+------+------+------+------+
| rno | name | m1   | m2   | m3   | m4   | m5   | m6   | tot  |
+-----+------+------+------+------+------+------+------+------+
|   1 | a    |   10 |   11 |   12 |   13 |   14 |   15 |   75 |
|   2 | b    |   20 |   21 |   12 |   13 |   14 |   15 |   95 |
|   3 | c    |   30 |   31 |   12 |   13 |   34 |   15 |  135 |
|   4 | d    |   40 |   11 |   42 |   13 |   44 |   15 |  165 |
|   5 | e    |   10 |   31 |   32 |   33 |   34 |   15 |  155 |
|   6 | f    |   10 |   41 |   12 |   43 |   14 |   45 |  165 |
+-----+------+------+------+------+------+------+------+------+
6 rows in set (0.01 sec)

mysql> select * from student where tot>100;
+-----+------+------+------+------+------+------+------+------+
| rno | name | m1   | m2   | m3   | m4   | m5   | m6   | tot  |
+-----+------+------+------+------+------+------+------+------+
|   3 | c    |   30 |   31 |   12 |   13 |   34 |   15 |  135 |
|   4 | d    |   40 |   11 |   42 |   13 |   44 |   15 |  165 |
|   5 | e    |   10 |   31 |   32 |   33 |   34 |   15 |  155 |
|   6 | f    |   10 |   41 |   12 |   43 |   14 |   45 |  165 |
+-----+------+------+------+------+------+------+------+------+
4 rows in set (0.00 sec)

5)
mysql> select hname from department where dname='cse';
+-------+
| hname |
+-------+
| ab    |
+-------+
1 row in set (0.00 sec)

6)
mysql> select rno from studdept inner join department on department.did=studdept.did where dname='cse'; 
+------+
| rno  |
+------+
|    1 |
|    2 |
+------+
2 rows in set (0.00 sec)




*/


