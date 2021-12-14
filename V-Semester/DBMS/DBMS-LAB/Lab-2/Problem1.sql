CREATE DATABASE purchaseDB;

CREATE TABLE orders(
  ord_no int NOT NULL,
  purch_amt DECIMAL(8,4),
  ord_date DATE,
  customer_id int NOT NULL,
  salesman_id int NOT NULL,
  PRIMARY KEY(ord_no)
  );

 
INSERT INTO orders(ord_no,purch_amt,ord_date, customer_id,salesman_id)
VALUES 
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001);


/* Queries */ 

SELECT * FROM orders;

/* 1. From the given table, Write a SQL statement to get the minimum
purchase amount of all the orders. */


SELECT MIN(purch_amt) 
FROM orders;

/* 2. From the given table, Write a SQL statement to get the maximum
purchase amount of all the orders. */

SELECT MAX(purch_amt) 
FROM orders;

/* 3. From the given table, Write a SQL statement to get the total purchase
amount of all the orders.*/

SELECT SUM(purch_amt) 
FROM orders;

/* 4. From the given table,Write a SQL statement to get the average
purchase amount of all the orders. */

SELECT AVG(purch_amt) 
FROM orders;

/* 5. From the given table, write a SQL query to count the number of
customers. Return number of customers. */

SELECT COUNT(*) 
FROM orders;

/* 6. In the above table, add a new column “warranty” which is six months
from the date of order.*/

ALTER TABLE orders 
ADD warranty DATE default (adddate(ord_date, interval 6 month));

SELECT * FROM orders;

/* 7. From the given table, Find out the most recently purchased order and
least recently purchased order using the ord_date.*/

SELECT MIN(ord_date) AS LEAST_RECENTLY_USED, MAX(ord_date) AS MOST_RECENTLY_USED from orders;

/* 8. From the given table, find and display the next day of order.*/

SELECT ord_no,ADDDATE(ord_date,INTERVAL 1 DAY) AS NEXT_DAY FROM orders;

/* 9. From the given table, print the smallest and largest integer just smaller
and larger than the purchase amount.*/

SELECT ord_no, CEIL(purch_amt) AS JUST_BIGGER FROM orders;
SELECT ord_no, FLOOR(purch_amt) AS JUST_SMALLER FROM orders;

/*10. Explore the round function with various parameter settings on the
column purchase amount.*/

/* The ROUND() function rounds a number to a specified number of decimal places.  */

SELECT ord_no,ROUND(purch_amt, 3) AS ROUNDED_UPTO_2_DECIMAL FROM orders;

/* But If the 2nd Parameter is given Negative, then it rounds off upto Units Place,Tens Place and so on. */

SELECT ord_no,ROUND(purch_amt, -1) AS ROUNDED_UPTO_TENS FROM orders;

