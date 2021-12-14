CREATE TABLE Hostel(hno int PRIMARY KEY, hname varchar(100), type varchar(100));
CREATE TABLE Menu(hno int REFERENCES Hostel(hno), day varchar(20), breakfast varchar(50), lunch varchar(50), dinner varchar(50));
CREATE TABLE Warden(wname varchar(100), qual varchar(100), hno int REFERENCES Hostel(hno));
CREATE TABLE Student(sid int PRIMARY KEY, sname varchar(100), gender varchar(10), year int, hno int REFERENCES Hostel(hno));

INSERT INTO Hostel (hno, hname, type) VALUES (1, 'Hostel 1', 'boys');
INSERT INTO Hostel (hno, hname, type) VALUES (2, 'Hostel 2', 'girls');
INSERT INTO Hostel (hno, hname, type) VALUES (3, 'Hostel 3', 'boys');
INSERT INTO Hostel (hno, hname, type) VALUES (4, 'Hostel 4', 'girls');
INSERT INTO Hostel (hno, hname, type) VALUES (5, 'Hostel 5', 'boys');

INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Sunday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Monday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Tuesday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Wednesday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Thursday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Friday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (1, 'Saturday', 'Idly', 'Rice', 'Dosa');


INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Sunday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Monday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Tuesday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Wednesday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Thursday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Friday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (2, 'Saturday', 'Dosa', 'Rice', 'Idly');

INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Sunday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Monday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Tuesday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Wednesday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Thursday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Friday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (3, 'Saturday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (4, 'Monday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (4, 'Tuesday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (4, 'Wednesday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (4, 'Thursday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (4, 'Friday', 'Dosa', 'Rice', 'Idly');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (4, 'Saturday', 'Dosa', 'Rice', 'Idly');

INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Sunday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Monday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Tuesday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Wednesday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Thursday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Friday', 'Idly', 'Rice', 'Dosa');
INSERT INTO Menu (hno, day, breakfast, lunch, dinner) VALUES (5, 'Saturday', 'Idly', 'Rice', 'Dosa');

INSERT INTO Warden (wname, qual, hno) VALUES ('AAA', 'B. Tech', 1);
INSERT INTO Warden (wname, qual, hno) VALUES ('BBB', 'B. Com', 2);
INSERT INTO Warden (wname, qual, hno) VALUES ('CCC', 'B. Tech', 3);
INSERT INTO Warden (wname, qual, hno) VALUES ('DDD', 'B. Com', 4);
INSERT INTO Warden (wname, qual, hno) VALUES ('EEE', 'B. Tech', 5);

INSERT INTO Student (sid, sname, gender, year, hno) VALUES (1, 'A1', 'male', 1, 1);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (2, 'B1', 'male', 1, 1);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (3, 'A2', 'male', 2, 1);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (4, 'B2', 'male', 2, 1);

INSERT INTO Student (sid, sname, gender, year, hno) VALUES (5, 'a1', 'female', 1, 2);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (6, 'a2', 'female', 2, 2);

INSERT INTO Student (sid, sname, gender, year, hno) VALUES (7, 'A3', 'male', 3, 3);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (8, 'B3', 'male', 3, 3);

INSERT INTO Student (sid, sname, gender, year, hno) VALUES (9, 'a3', 'female', 3, 4);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (10, 'a4', 'female', 4, 4);

INSERT INTO Student (sid, sname, gender, year, hno) VALUES (11, 'A4', 'male', 4, 5);
INSERT INTO Student (sid, sname, gender, year, hno) VALUES (12, 'B4', 'male', 4, 5);

/*
mysql> select count(*) from Hostel where type='boys';
+----------+
| count(*) |
+----------+
|        3 |
+----------+
1 row in set (0.00 sec)

mysql> select *  from Menu where hno=2 and day like 'Tuesday';
+------+---------+-----------+-------+--------+
| hno  | day     | breakfast | lunch | dinner |
+------+---------+-----------+-------+--------+
|    2 | Tuesday | Dosa      | Rice  | Idly   |
+------+---------+-----------+-------+--------+
1 row in set (0.00 sec)

mysql> select count(*) from Warden group by hno;
+----------+
| count(*) |
+----------+
|        1 |
|        1 |
|        1 |
|        1 |
|        1 |
+----------+
5 rows in set (0.00 sec)

mysql> select count(*) from Student group by hno;
+----------+
| count(*) |
+----------+
|        4 |
|        2 |
|        2 |
|        2 |
|        2 |
+----------+
5 rows in set (0.00 sec)

mysql> update Menu set breakfast='Noodels' where hno=1 and day='Thursday';
Query OK, 1 row affected (2.14 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select h.hname,w.wname from Hostel h inner join Warden w on h.hno=w.hno && qual="B. Com";
+----------+-------+
| hname    | wname |
+----------+-------+
| Hostel 2 | BBB   |
| Hostel 4 | DDD   |
+----------+-------+
2 rows in set (0.00 sec)
mysql> select count(*) from Student where sname like 'A%' group by hno;
+----------+
| count(*) |
+----------+
|        2 |
|        2 |
|        1 |
|        2 |
|        1 |
+----------+
5 rows in set (0.00 sec)

mysql> SELECT year, count(*) AS Student_Count from Student WHERE gender = 'male' GROUP BY year;
+------+---------------+
| year | Student_Count |
+------+---------------+
|    1 |             2 |
|    2 |             2 |
|    3 |             2 |
|    4 |             2 |
+------+---------------+
4 rows in set (0.00 sec)

SELECT h.hname, w.wname FROM Hostel h INNER JOIN Warden w ON h.hno = w.hno && h.type="girls";
+----------+-------+
| hname    | wname |
+----------+-------+
| Hostel 2 | BBB   |
| Hostel 4 | DDD   |
+----------+-------+

mysql> select distinct w.wname,h.hname from Warden w,Hostel h,Student s where h.hno=s.hno and h.hno=w.hno and s.year=3;
+-------+----------+
| wname | hname    |
+-------+----------+
| CCC   | Hostel 3 |
| DDD   | Hostel 4 |
+-------+----------+
2 rows in set (0.00 sec)

mysql> create view Veiw1
    -> as
    -> select sname,gender,h.hno,wname from Student s,Hostel h,Warden w
    -> where w.hno=s.hno and h.hno=w.hno;
Query OK, 0 rows affected (0.34 sec)



mysql> select * from Veiw1;
+-------+--------+-----+-------+
| sname | gender | hno | wname |
+-------+--------+-----+-------+
| A1    | male   |   1 | AAA   |
| B1    | male   |   1 | AAA   |
| A2    | male   |   1 | AAA   |
| B2    | male   |   1 | AAA   |
| a1    | female |   2 | BBB   |
| a2    | female |   2 | BBB   |
| A3    | male   |   3 | CCC   |
| B3    | male   |   3 | CCC   |
| a3    | female |   4 | DDD   |
| a4    | female |   4 | DDD   |
| A4    | male   |   5 | EEE   |
| B4    | male   |   5 | EEE   |
+-------+--------+-----+-------+
12 rows in set (0.00 sec)






*/
