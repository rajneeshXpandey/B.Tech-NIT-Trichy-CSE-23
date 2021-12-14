CREATE DATABASE companyDB;

CREATE TABLE Employee(
  EmpID varchar(255) NOT NULL,
  EmpName varchar(255),
  Address varchar(255),
  Doj varchar(255),
  Salary int,
  UNIQUE (EmpID),
  PRIMARY KEY (EmpID)
  );
  
CREATE TABLE Project(
  Projectno varchar(255) NOT NULL,
  Duration int,
  Projectname varchar(255),
  UNIQUE (Projectno),
  PRIMARY KEY (Projectno)
  );
  
CREATE TABLE Workson(
  Empid varchar(255),
  Projectno  varchar(255),
  FOREIGN KEY (Empid) REFERENCES Employee(Empid),
  FOREIGN KEY (Projectno) REFERENCES Project(Projectno)
  );
  
INSERT INTO Employee(EmpID,EmpName, Address, Doj, Salary)
VALUES 
 ('001','Harry','3427 Hall Valley Drive','12/28/1984',59000),
 ('002','Wilson','3950 Rinehart Road','5/18/1983',42000),
 ('003','Mildred','4768 Scenicview Drive','6/21/1969',78000),
 ('004','Anderson','78 Heritage Road','10/21/1995',49000),
 ('005','Bob','856 Tenmile Road','10/13/1960',50000);
 
INSERT INTO Project(Projectno,Duration, Projectname) 
VALUES 
 ('P1',5,'WebSite'),
 ('P2',8,'Android App'),
 ('P3',10,'iOS App'),
 ('P4',12,'Machine Learning');

INSERT INTO Workson(Projectno,Empid) 
VALUES 
  ('P3','002'),
  ('P2','004'),
  ('P1','003'),
  ('P4','001'),
  ('P2','005');
  
/* Queries */ 
/* 1. Display the Employee details in the descending order based on name. */ 

SELECT *
FROM Employee e
ORDER BY e.EmpName DESC;

/* 2. Display the project details if project id is given. */

SELECT * FROM Project;
SELECT * FROM Project WHERE Projectno='P4';

/* 3. Display the employee names starting with ‘B' */

SELECT EmpName 
from Employee
where EmpName LIKE 'B%';


/* 4. Display the employee ID's working in a particular project if project no is given. */

SELECT EmpID
FROM Workson  
WHERE projectno = 'P2';
 

 
 
 
  
  

