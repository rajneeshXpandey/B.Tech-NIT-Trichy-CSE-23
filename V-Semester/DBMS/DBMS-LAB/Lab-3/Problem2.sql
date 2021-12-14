CREATE DATABASE employeeDB;

CREATE TABLE `employee`(
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `hire_date` DATE NOT NULL,
  `job_id` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(12,3) NOT NULL,
  `commission_pct` DECIMAL(5,3) NOT NULL,
  `manager_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`)
  );

INSERT INTO employee (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`)  VALUES  
		('100', 'Steven', 'King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000.00, '0.00', '0', '90'),
		('101', 'Neena', 'Kochhar', 'NKOCHHAR ', '515.123.4568 ', ' 2005-09-21 ', 'AD_VP', 17000.00, '0.00', '100', '40'),
		('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13 ', 'AD_VP', 17000.00, '0.00', '100', '90'),
		('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000.00, '0.00', '102', '60'),
		('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568 ', '2007-05-21', 'IT_PROG', 6000.00, '0.00', '103', '60'),
		('105', 'David', 'Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800.00, '0.00', '103', '40'),
		('106', 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800.00, '0.00', '103', '60'),
		('107', 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200.00, '0.00', '103', '60'),
		('108', 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008.00, '0.00', '101', '100'),
		('109', 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000.00, '0.00', '108', '100'),
		('110', 'John', 'Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200.00, '0.00', '108', '40');
      
-- Query :-

-- Show Tables :   

	SELECT * FROM employee;	
      
--   a) Write a query to display the employee name (first name and last name) and department for all employees for any existence of those employees whose salary is more than 3700.
     
	SELECT first_name, last_name, department_id
		FROM employee
		WHERE EXISTS (SELECT *
			  FROM employee
			  WHERE salary > 3700.00);
     
--   b) Write a query to display the department id and the total salary for those departments which contains at least one employee. 
        
	SELECT department_id,
		   SUM(salary) AS Total_Salary 
	FROM employee
	WHERE department_id IN (SELECT DISTINCT department_id FROM employee)
	GROUP BY department_id;     

--   c) Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them. 
        
	SELECT DISTINCT department_id FROM employee;
        
--   d) Write a query in SQL to display the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary. 

	SELECT first_name, last_name, salary, department_id
	  FROM employee
	  WHERE salary > (SELECT AVG(salary)
				FROM employee)
	  ORDER BY salary DESC;   
     
--   e) Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
       
      SELECT first_name, last_name, salary, department_id
		  FROM employee
		  WHERE salary > (SELECT MAX(salary)
					FROM employee
							WHERE department_id = 40);
