CREATE DATABASE orderDB;
USE orderDB;

CREATE TABLE customer(
	customer_id int NOT NULL,
	cust_name varchar(255),
	city varchar(255),
	salesman_id int,
	UNIQUE (customer_id),
	PRIMARY KEY (customer_id)
);

INSERT INTO customer
 VALUES 
    (3002 , 'Nick Rimando' , 'New York' , 5001),
    (3007 , 'Brad Davis' , 'New York'  , 5001),
    (3005 , 'Graham Zusi' , 'California' , 5002),
    (3008 , 'Julian Green' , 'London' , 5002),
    (3004 , 'Fabian Johnson' , 'Paris' , 5006),
    (3009 , 'Geoff Cameron' , 'Berlin' , 5003),
    (3003 , 'Jozy Altidor' , 'Moscow' , 5007),
    (3001 , 'Brad Guzan' , 'London' , 5005);
 
CREATE TABLE orders( 
    ord_no INT NOT NULL,
    purch_amt DECIMAL(8,3) NOT NULL,
    ord_date DATE NOT NULL,
    customer_id INT NOT NULL,
    salesman_id INT NOT NULL,
    PRIMARY KEY (ord_no),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    );

INSERT INTO orders
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

        /*----------------------------- Queries----------------------------- */

SET GLOBAL log_bin_trust_function_creators = 1;
            
SELECT * FROM customer;
SELECT * FROM orders;

/*  1. Use SQL functions to find the highest purchase amount ordered by 
       each customer with their ID and highest purchase amount */

SELECT customer_id,MAX(purch_amt) AS highest_purch_amt 
FROM orders 
GROUP BY customer_id;

--  2. Use SQL functions to find the number of customers in each city.

SELECT city,COUNT(customer_id) AS num_of_cust
FROM customer
GROUP BY city;

--  3. Write a user defined function to display customer details given the customer_id.
DELIMITER %%
CREATE FUNCTION display_cust(c int)
RETURNS varchar(255)
	BEGIN
		DECLARE ret_val varchar(255);
		SELECT cust_name INTO ret_val FROM customer
		WHERE customer_id=c;
		RETURN ret_val;
	END%%
    
SELECT display_cust(3002)%%

--  4. Write a user defined function to decrease the purch_amt of an order by 5% given the ord_no.
DELIMITER $$
CREATE FUNCTION decrease_purch_amt( ord_no int) 
RETURNS DECIMAL(8,3) DETERMINISTIC
BEGIN
    DECLARE Reduced_purch_amt DECIMAL(8,3);
    SELECT 0.95 * purch_amt INTO Reduced_purch_amt FROM orders WHERE orders.ord_no = ord_no;
    RETURN Reduced_purch_amt;
END$$

SELECT decrease_purch_amt(70009)$$