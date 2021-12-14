CREATE DATABASE CompanyDB; 
USE CompanyDB;

CREATE TABLE Departments  (
    dept_id VARCHAR (20) NOT NULL PRIMARY KEY,  
    dept_name VARCHAR (20),  
    dept_location VARCHAR (20)
);  

CREATE TABLE Employees (
  emp_id INT NOT NULL PRIMARY KEY,
  emp_name VARCHAR(100),
  email VARCHAR(100),
  dept_id  INT,
  designation VARCHAR(100),
  doj DATE,
  phone_num VARCHAR(45),
  emp_salary DECIMAL(12,3)
);

create table messages
(
    id int(11) not null auto_increment primary key,
    message varchar(255) default null,
    time timestamp null default current_timestamp on update current_timestamp
);
 
 
-- /** ----------------------------- Queries -------------------------------**/

-- -- Create a trigger for:-

-- -- a) Calculating the number of rows inserted so far.

-- delimiter //

-- create trigger trig1A 
--  before insert on departments 
--   for each row 
--   set @dept_rows = @dept_rows+1//
--   
-- set @dept_rows = 0//

-- delimiter ;

-- insert into departments
-- values
--     ('1', 'sales', 'chennai'),
--     ('2', 'marketing', 'bombay'),
--     ('3', 'management', 'bengaluru');

-- SELECT @dept_rows;

-- -- b) Displays message prior to insert operation on Employee Table

-- delimiter //

-- create trigger display_message before insert on employees
--     for each row
--     begin
--     insert into messages (message) values('Inserted Row in Employees');
--     end;//

-- delimiter ;

-- insert into employees
-- values
--     ('100','timber', 'timber@gmail.com','1', 'salseman', '2019-01-12', '9842042345', '100000'),
--     ('101','jaanu', 'jaanu@gmail.com', '2', 'senior manager', '2020-01-01', '9865161122', '15000'),
--     ('102','jen', 'jen@gmail.com', '3', 'junior manager', '2019-10-12', '9042842344', '60000'),
--     ('103','jack', 'jack@gmail.com', '2', 'assistant', '2016-03-01', '9498853055', '50000');

-- SELECT * FROM messages;

-- -- c) Ensuring that the Employee Table does not contain duplicates or null value in the Name column

-- delimiter //
-- create trigger NULL_val_trigger before insert on employees
-- for each row
-- begin
--     if (exists(select 1 from employees where emp_name = new.emp_name or new.emp_name is null))
--     then
--     signal sqlstate '45001' set message_text = "INSERT failed due to duplicate or null emp_name";
--     end if;
-- end//

-- insert into employees
--   values ('104', 'jen', 'xjen@gmail.com', '3', 'junior manager', '2019-09-10', '7561994181', '62000')//

-- delimiter ;
-- select * from employees;

-- -- d) To insert Employee details into Employee Table only of DOJ > 2018

-- DELIMITER //
-- CREATE TRIGGER NOT_BELOW_2018
--     BEFORE INSERT
--     ON EMPLOYEES
--     FOR EACH ROW
-- BEGIN 
--     IF(NEW.doj < '2018-01-01') THEN
--         SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'EMPLOYEE BELOW 2018 DOJ CANNOT BE INSERTED';
--     END IF;
-- END //
-- insert into employees
--  values (104, 'raj', 'rajx@gmail.com', '2', 'field officer', '2017-03-10','9680988342','34000')//
-- DELIMITER ;

-- -- e) To Prevent any Employee Named Tom to be inserted into the table  
-- DELIMITER //
-- create trigger prevent_name before insert on employees
--     for each row
--     begin
--     if new.emp_name = "tom" then signal sqlstate '45000' set message_text= "tom is prohibited from insertion !!!";
--     end if;
--     end//
-- DELIMITER ;

-- insert into employees values 
--   ('107', 'tom', 'tommy@gmail.com', '6', 'assistant doctor', '2020-02-22', '7373558197','25000');

-- select * from employees;
