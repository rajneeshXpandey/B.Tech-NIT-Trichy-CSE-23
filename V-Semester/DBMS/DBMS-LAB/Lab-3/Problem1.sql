CREATE DATABASE salesDB;

CREATE TABLE salesman (
  `salesman_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `commission` DECIMAL(5,3) NOT NULL,
  PRIMARY KEY (`salesman_id`)
  );

CREATE TABLE customer (
  `customer_id` INT NOT NULL,
  `cust_name` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `grade` INT NOT NULL,
  `salesman_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `salesman_id_idx` (`salesman_id` ASC) VISIBLE,
  CONSTRAINT `salesman_id`
    FOREIGN KEY (`salesman_id`)
    REFERENCES `salesDB`.`salesman` (`salesman_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );

CREATE TABLE orders( 
  `ord_no` INT NOT NULL,
  `purch_amt` DECIMAL(8,3) NOT NULL,
  `ord_date` DATE NOT NULL,
  `customer_id` INT NOT NULL,
  `salesman_id` INT NOT NULL,
    PRIMARY KEY (`ord_no`),
    FOREIGN KEY (`customer_id`)
    REFERENCES `salesDB`.`customer` (`customer_id`),
    FOREIGN KEY (`salesman_id`)
    REFERENCES `salesDB`.`salesman` (`salesman_id`)
    );

INSERT INTO salesman (`salesman_id`, `name`, `city`, `commission`) 
VALUES 
        ('5001', 'James Hoog', 'New York', '0.15'),
        ('5002', 'Nail Knite', 'Paris', '0.13'),
        ('5005', 'Pit Alex', 'London', '0.11'),
        ('5006', 'Mc Lyon', 'Paris', '0.14'),
        ('5007', 'Paul Adam', 'Rome', '0.13'),
        ('5003', 'Lauson Hen', 'San Jose', '0.12');

INSERT INTO customer (`customer_id`, `cust_name`, `city`, `grade`, `salesman_id`) 
VALUES 
        ('3002', 'Nick Rimando', 'New York', '100', '5001'),
        ('3007', 'Brad Davis', 'New York', '200', '5001'),
        ('3005', 'Graham Zusi', 'California', '200', '5002'),
        ('3008', 'Julian Green', 'London', '300', '5002'),
        ('3004', 'Fabian Johnson', 'Paris', '300', '5006'),
        ('3009', 'Geoff Cameroon', 'Berlin', '100', '5003'),
        ('3003', 'Jozy Altidor', 'Moscow', '200', '5007'),
        ('3001', 'Brad Guzan', 'London', '200', '5005');


INSERT INTO orders (`ord_no`, `purch_amt`, `ord_date`, `customer_id`, `salesman_id`) 
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
        
-- Query :-

-- Show Tables :   

SELECT * FROM salesman;
SELECT * FROM customer;
SELECT * FROM orders;

-- a) Write a SQL query to find those salespersons who received a commission from the company more than 12%. 
--    Return Customer Name, customer city, Salesman, commission (Use Inner join) 

SELECT c.cust_name AS "Customer Name",
       c.city,
       s.name AS "Salesman",
       s.commission
  FROM customer c
  INNER JOIN salesman s
    ON c.salesman_id = s.salesman_id
  WHERE s.commission > 0.12;


-- b) Write a SQL statement to make a report with customer name, city, order number, order date, 
--    and order amount in ascending order according to the order date to 
--    find that either any of the existing customers have placed no order or placed one or more orders. (Use left outer join) 

SELECT c.cust_name AS "Customer Name",
       c.city,
       o.ord_no,
       o.ord_date,
       o.purch_amt
  FROM customer c
  LEFT OUTER JOIN orders o
    ON c.customer_id=o.customer_id
  ORDER BY o.ord_date;


-- c) Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to 
--    find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
--    (Using Left outer join) 

SELECT c.cust_name AS "Customer Name",
       c.city,
       o.ord_no,
       o.ord_date,
       o.purch_amt,
       s.name AS "Salesman",
       s.commission
  FROM customer c
  LEFT OUTER JOIN orders o
    ON c.customer_id=o.customer_id
  LEFT OUTER JOIN salesman s
    ON c.salesman_id=s.salesman_id;


-- d) Write a SQL statement to make a list in ascending order for the salesmen 
--    who works either for one or more customer or not yet join under any of the customers. (Use Right outer join) 

SELECT s.name AS "Salesman"
  FROM salesman s
  RIGHT OUTER JOIN customer c
    ON s.salesman_id=c.salesman_id
  ORDER BY c.salesman_id ASC;

-- e) Write a SQL query to combine each row of salesman table with each row of customer table. (Use cross join) 

SELECT * 
FROM salesman a 
CROSS JOIN customer b;

-- f) Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear 
--    for all customer and vice versa for that salesman who belongs to a city. (Use cross join) 

SELECT s.name AS "Salesman",
       c.cust_name AS "Customer Name"
  FROM salesman s
  CROSS JOIN customer c;


-- g) Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. 
--    The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier. 
--    (Use left outer join and right outer join)

SELECT s.name AS "Salesman"
  FROM salesman s
  LEFT OUTER JOIN customer c
    ON s.salesman_id=c.salesman_id
  RIGHT OUTER JOIN orders o
    ON c.customer_id=o.customer_id
  WHERE o.purch_amt >= 2000
    AND grade IS NOT NULL;
        