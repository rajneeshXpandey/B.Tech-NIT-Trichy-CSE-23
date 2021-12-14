CREATE DATABASE orderDB;
USE orderDB;

CREATE TABLE salesman(
	salesman_id int NOT NULL,
	sm_name varchar(255),
	city varchar(255),
	commission DECIMAL(5,3),
	UNIQUE (salesman_id),
	PRIMARY KEY (salesman_id)
);

INSERT INTO salesman (salesman_id, sm_name, city, commission) 
VALUES 
        ('5001', 'James Hoog', 'New York', '0.15'),
        ('5002', 'Nail Knite', 'Paris', '0.13'),
        ('5005', 'Pit Alex', 'London', '0.11'),
        ('5006', 'Mc Lyon', 'Paris', '0.14'),
        ('5007', 'Paul Adam', 'Rome', '0.13'),
        ('5003', 'Lauson Hen', 'San Jose', '0.12');


CREATE TABLE customer(
	customer_id int NOT NULL,
	cust_name varchar(255),
	city varchar(255),
	grade int,
	salesman_id int,
	UNIQUE (customer_id),
	PRIMARY KEY (customer_id),
	FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customer(customer_id, cust_name, city, 
					grade, salesman_id) 
 VALUES 
 (3002 , 'Nick Rimando' , 'New York' , 100 , 5001),
 (3007 , 'Brad Davis' , 'New York' , 200 , 5001),
 (3005 , 'Graham Zusi' , 'California' , 200 , 5002),
 (3008 , 'Julian Green' , 'London' , 300 , 5002),
 (3004 , 'Fabian Johnson' , 'Paris' , 300 , 5006),
 (3009 , 'Geoff Cameron' , 'Berlin' , 100 , 5003),
 (3003 , 'Jozy Altidor' , 'Moscow' , 200 , 5007),
 (3001 , 'Brad Guzan' , 'London' , 300 , 5005);
 
CREATE TABLE orders( 
    ord_no INT NOT NULL,
    purch_amt DECIMAL(8,3) NOT NULL,
    ord_date DATE NOT NULL,
    customer_id INT NOT NULL,
    salesman_id INT NOT NULL,
    PRIMARY KEY (ord_no),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
    );

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) 
VALUES 
        ('70001', '150.5', '2012-10-05', '3005', '5002'),
        ('70009', '270.65', '2012-09-10', '3001', '5005'),
        ('70002', '65.26', '2012-10-05', '3002', '5001'),
        ('70004', '110.5', '2012-08-17', '3009', '5003'),
        ('70007', '948.5', '2012-09-10', '3005', '5002'),
        ('70005', '2400.6', '2012-07-27', '3007', '5001'),
        ('70008', '5760', '2012-09-10', '3002', '5001'),
        ('70010', '1983.43', '2012-10-10', '3004', '5006'),
        ('70003', '2480.4', '2012-10-10', '3009', '5003'),
        ('70012', '250.45', '2012-06-27', '3008', '5002'),
        ('70011', '75.29', '2012-08-17', '3003', '5007'),
        ('70013', '3045.6', '2012-04-25', '3002', '5001');


							/*------------------------Queries--------------------------*/ 

	SELECT * FROM customer;
	SELECT * FROM salesman;
	SELECT * FROM orders;

-- 1 From the table, create a view to count the number of customers in each grade. 

	CREATE VIEW Grade_Count (Grade, Number)
	AS SELECT grade, COUNT(*)
	FROM customer
	GROUP BY grade;
	SELECT * FROM Grade_Count;

/* 2 From the following table, create a view to count the number of unique
customer, compute average and total purchase amount of customer orders by
each date. */

	CREATE VIEW Day_Wise_Info (Ord_Date, Unique_Cust, Avg_Purch, Total_Purch)
	AS SELECT ord_date, COUNT(DISTINCT customer_id),
	AVG(purch_amt), SUM(purch_amt)
	FROM orders
	GROUP BY ord_date;
  
	SELECT * FROM Day_Wise_Info;

/* 3 create a view to get the salesperson and customer by name. Return order
name, purchase amount, salesperson ID, name, customer name. */

	CREATE VIEW Orders_by_Name (Ord_No,Purch_Amt,Salesman_ID, Salesman_Name, Cust_Name)
	AS SELECT ord_no, purch_amt, a.salesman_id, sm_name, cust_name
	FROM orders a, customer b, salesman c
	WHERE a.customer_id = b.customer_id
	AND a.salesman_id = c.salesman_id;

	SELECT * FROM Orders_by_Name;

/* 4 create a view to find the salespersons who issued orders on October 10th,
2012. Return all the fields of salesperson. */

	CREATE VIEW Ten_Oct_Salesman (Salesman_ID, Salesman_Name, City, Commission)
	AS SELECT *
	FROM salesman
	WHERE salesman_id IN
		(SELECT salesman_id
			 FROM orders
			 WHERE ord_date = '2012-10-10');

	SELECT * FROM Ten_Oct_Salesman;









