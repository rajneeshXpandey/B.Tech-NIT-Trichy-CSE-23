CREATE DATABASE schoolDB;

use schoolDB;
 
drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;


create table Highschooler(
        ID int, 
        name text, 
        grade int);

create table Friend(
        ID1 int,
        ID2 int);
create table Likes(
        ID1 int,
        ID2 int);

/* Populate the tables with our data */
insert into Highschooler 
        values 
            (1468, 'Kris', 10),
            (1510, 'Jordan', 9),
            (1689, 'Gabriel', 9),
            (1381, 'Tiffany', 9),
            (1709, 'Cassandra', 9),
            (1101, 'Haley', 10),
            (1782, 'Andrew', 10),
            (1641, 'Brittany', 10),
            (1247, 'Alexis', 11),
            (1316, 'Austin', 11),
            (1911, 'Gabriel', 11),
            (1501, 'Jessica', 11),
            (1304, 'Jordan', 12),
            (1025, 'John', 12),
            (1934, 'Kyle', 12),
            (1661, 'Logan', 12);

insert into Friend 
                values 
                    (1510, 1381),
                    (1510, 1689),
                    (1689, 1709),
                    (1381, 1247),
                    (1709, 1247),
                    (1689, 1782),
                    (1782, 1468),
                    (1782, 1316),
                    (1782, 1304),
                    (1468, 1101),
                    (1468, 1641),
                    (1101, 1641),
                    (1247, 1911),
                    (1247, 1501),
                    (1911, 1501),
                    (1501, 1934),
                    (1316, 1934),
                    (1934, 1304),
                    (1304, 1661),
                    (1661, 1025);

insert into Friend select ID2, ID1 from Friend;

insert into Likes values
                (1689, 1709),
                (1709, 1689),
                (1782, 1709),
                (1911, 1247),
                (1247, 1468),
                (1641, 1468),
                (1316, 1304),
                (1501, 1934),
                (1934, 1501),
                (1025, 1101);



-- Write two triggers to maintain symmetry in friend relationships.
-- “ If (A,B) is deleted from Friend, then (B,A) should be deleted too”
DELIMITER // 
create trigger Del
after delete on Friend
	for each row
			begin
			  delete from Friend
			  where (ID1 = Old.ID2 and ID2 = Old.ID1);
			end //

DELIMITER ;
DELIMITER // 
create trigger Ins
after insert on Friend
	for each row
			begin
			  insert into Friend values (New.ID2, New.ID1);
			end //

DELIMITER ;

select * from Highschooler;
select * from Friend;
select * from Likes;


insert into Friend values (1510, 1782);
select * from Friend;
 