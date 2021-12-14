CREATE DATABASE CompanyDB; 
USE CompanyDB;

CREATE TABLE Department  (
	Dept_No VARCHAR (20) PRIMARY KEY,  
	Dept_Name VARCHAR (20),  
	Location VARCHAR (20)
);  

CREATE TABLE Employee (
	Emp_No VARCHAR (20) PRIMARY KEY,
	Emp_Name VARCHAR (20),
	Address VARCHAR (20),
	sex CHAR (1),
	Salary INTEGER,
    Dept_No VARCHAR (20),
	foreign key (Dept_No) REFERENCES Department (Dept_No)
); 

INSERT INTO Department 
    VALUES 
        (1,'ACCOUNTS','Trichy'),
        (2,'IT','Chennai'),
        (3,'ECE','Salem'),
        (4,'ISE','Coimbatore'),
        (5,'CSE','Chennai'); 

INSERT INTO Employee
 VALUES 
       ('ECE01','PREETI','BANGALORE','F', 40000,3), 
       ('CSE01','JAMES','BANGALORE','M', 50000,5),   
       ('CSE02','HEARN','BANGALORE','M', 70000,5),   
       ('CSE03','EDWARD','MYSORE','M', 50000,5),   
       ('CSE04','PAVAN','MANGALORE','M', 15000,5),   
       ('CSE05','GIRISH','MYSORE','M', 20000,5),  
       ('CSE06','NEHA','BANGALORE','F', 80000,5),   
       ('ACC01','AHANA','MANGALORE','F', 35000,1),   
       ('ACC02','SANTHOSH','MANGALORE','M', 30000,1),   
       ('ISE01','VEENA','MYSORE','M', 10000,4),   
       ('IT01','NAGESH','BANGALORE','M', 50000,2);    
       
 							/*------------Queries-------------*/
                         
SELECT * FROM Department; 
SELECT * FROM Employee;       

                     
/*1. Write a procedure to display employee details given the Emp_No.*/

DELIMITER $$
CREATE PROCEDURE display_Emp(IN X VARCHAR(20))
	BEGIN
		SELECT * FROM Employee
        WHERE Emp_No=X;
	END$$
    
CALL display_Emp('CSE05')$$

/*2. Write a procedure to delete an employee record given the Emp_Name.*/

DELIMITER //
CREATE PROCEDURE delete_Emp(IN NAME VARCHAR(20))
	BEGIN
		SET SQL_SAFE_UPDATES = 0;
		DELETE FROM Employee WHERE Emp_Name=NAME;
		SET SQL_SAFE_UPDATES = 1;
	END//
    
CALL delete_Emp('VEENA')//

SELECT * FROM Employee//

/*3. Write a procedure to list all the employee names belonging to a particular department given the Dept_No.*/

DELIMITER %%
CREATE PROCEDURE list_Emp(IN X INT)
	BEGIN
		SELECT * FROM Employee
        WHERE Dept_No=X;
	END%%
    
CALL list_Emp(1)%%

/*4. Write a procedure to display the number of employees whose salary is greater than 30K.*/

DELIMITER &&
CREATE PROCEDURE num_Emp()
	BEGIN
		SELECT COUNT(*) FROM Employee
        WHERE Salary>30000;
	END&&
CALL num_Emp()&&

