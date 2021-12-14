
Create table sp(
ssn integer primary key,
name varchar(20),
starty integer,
dno integer);

Create table trip(
tripid integer primary key,
ssn integer references sp(ssn),
fcity varchar(20),
tocity varchar(20),
departdate integer,
returndate integer);

create table spexp(
tripid integer references trip(tripid),
amount integer,
type varchar(6));

insert into sp values(1,'a',10,11);
insert into sp values(2,'ab',13,11);
insert into sp values(3,'aab',19,11);
insert into sp values(4,'abcd',20,11);

insert into trip values(11,1,'chen','hyd',123,2344);
insert into trip values(21,2,'guntur','hyd',623,2344);
insert into trip values(31,3,'banglore','hyd',923,2344);
insert into trip values(41,4,'chen','vtz',1203,2344);

insert into spexp values(11,1234,'Travel');
insert into spexp values(21,4234,'Travel');
insert into spexp values(31,3234,'Food');
insert into spexp values(41,6234,'Stay');


/*
1)
mysql> select * from trip inner join spexp on trip.tripid=spexp.tripid where spexp.amount>2000;
+--------+------+----------+--------+------------+------------+--------+--------+--------+
| tripid | ssn  | fcity    | tocity | departdate | returndate | tripid | amount | type   |
+--------+------+----------+--------+------------+------------+--------+--------+--------+
|     21 |    2 | guntur   | hyd    |        623 |       2344 |     21 |   4234 | Travel |
|     31 |    3 | banglore | hyd    |        923 |       2344 |     31 |   3234 | Food   |
|     41 |    4 | chen     | vtz    |       1203 |       2344 |     41 |   6234 | Stay   |
+--------+------+----------+--------+------------+------------+--------+--------+--------+

2)
mysql> insert into trip values(51,2,'wehfjd','hyd',23,457);
Query OK, 1 row affected (0.05 sec)

mysql> select sp.ssn,count(sp.ssn) as a from trip,sp where sp.ssn=trip.ssn and trip.tocity='hyd' group by sp.ssn having a>1;
+-----+---+
| ssn | a |
+-----+---+
|   2 | 2 |
+-----+---+
1 row in set (0.00 sec)

3)
mysql> insert into spexp values(51,7234,'Stay');
Query OK, 1 row affected (0.32 sec)


mysql> select sum(spexp.amount) from spexp,sp,trip where sp.ssn=2 and sp.ssn=trip.ssn and trip.tripid=spexp.tripid;
+-------------------+
| sum(spexp.amount) |
+-------------------+
|             11468 |
+-------------------+
1 row in set (0.00 sec)

4)
mysql> select * from sp order by sp.name desc;
+-----+------+--------+------+
| ssn | name | starty | dno  |
+-----+------+--------+------+
|   4 | abcd |     20 |   11 |
|   2 | ab   |     13 |   11 |
|   3 | aab  |     19 |   11 |
|   1 | a    |     10 |   11 |
+-----+------+--------+------+
4 rows in set (0.00 sec)


*/


