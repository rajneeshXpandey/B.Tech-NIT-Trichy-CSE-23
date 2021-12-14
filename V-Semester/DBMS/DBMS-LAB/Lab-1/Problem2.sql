/* CREATE DATABASE collegeDB; */

CREATE TABLE Student(
	Rollno int NOT NULL,
	StudName varchar(255) NOT NULL,
	sub1 int,
	sub2 int,
	sub3 int,
	sub4 int,
	sub5 int,
	sub6 int,
	Total int,
	UNIQUE (Rollno),
	PRIMARY KEY(Rollno)
);

CREATE TABLE Department(
	DeptID int NOT NULL,
	Deptname varchar(255),
	HODname varchar(255),
	UNIQUE (DeptID),
	PRIMARY KEY (DeptID)
);
CREATE TABLE StudDep(
	Rollno int,
	DeptID int,
	FOREIGN KEY (Rollno) REFERENCES Student(Rollno),
	FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
 
 /* 1.Insert 10 student details and 3 department details. Insert details in the studdep table.  */
 
INSERT INTO Student(Rollno,StudName, sub1, sub2, sub3, sub4, sub5, sub6)
VALUES 
 (1,'Amar',70,80,90,80,100,90),
 (2,'Shivam',80,90,80,100,90,70),
 (3,'Radha',80,100,90,70,70,40),
 (4,'Nitin',40,60,50,80,60,70),
 (5,'Ritik',50,50,60,100,90,70),
 (6,'Vaibhav',100,100,100,100,100,90),
 (7,'Kartik',10,4,50,80,100,90),
 (8,'Ram',80,90,80,100,90,70),
 (9,'Tom',90,80,100,90,50,90),
 (10,'Katy',90,80,100,90,100,100);

SET SQL_SAFE_UPDATES = 0;
 
UPDATE Student SET Total = sub1 + sub2 + sub3 + sub4 + sub5 + sub6;

INSERT INTO Department(DeptID,Deptname,HODname)
VALUES 
 (1,'CSE','Dinesh'),
 (2,'Mech','Lakshmi'),
 (3,'ECE','Surya');
 
INSERT INTO StudDep(Rollno,DeptID) 
VALUES 
 (1,1),
 (2,1),
 (3,3),
 (4,2),
 (5,1),
 (6,2),
 (7,1),
 (8,3),
 (9,3),
 (10,2);


/*2.Display the Student details if deptid is given */

SELECT *  
FROM Student  
WHERE Rollno IN
(SELECT Rollno  
FROM StudDep  
WHERE DeptID=1 
);

/* 3.Display the department details if rollno is given */

SELECT *  
FROM Department  
WHERE DeptID IN
(SELECT DeptID  
FROM StudDep  
WHERE Rollno=5
);

/* 4.Display the student names who got total greater than 500  */

SELECT StudName  
FROM Student  
WHERE Total>500;

/* 5.Display the HOD name of the CSE department  */

SELECT HODName  
FROM Department  
WHERE Deptname='CSE';

/* 6.Display the student rollnos of the CSE department */

SELECT Rollno 
FROM StudDep  
WHERE DeptID IN
(SELECT DeptID  
FROM Department  
WHERE Deptname='CSE'
);
