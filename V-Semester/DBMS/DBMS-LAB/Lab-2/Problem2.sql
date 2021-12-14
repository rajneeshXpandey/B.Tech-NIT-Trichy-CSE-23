CREATE DATABASE customerDB;

CREATE TABLE customer(
CustId varchar(255) NOT NULL,
CustName varchar(255),
CustAdd varchar(255),
Phone DECIMAL(12),
Email varchar(255),
PRIMARY KEY(CustId)
);

INSERT INTO customer (CustId,CustName ,CustAdd ,Phone ,Email ) 
 VALUES 
( 'C0001' ,'AmitSaha' , 'L-10, Pitampura' , 4564587852 ,'amitsaha2@gmail.com'),
( 'C0002' ,'Rehnuma', 'J-12, SAKET' ,5527688761 ,'rehnuma@hotmail.com'),
( 'C0003' ,'CharviNayyar', '10/9, FF, Rohini' , 6811635425 ,'charvi123@yahoo.com'),
( 'C0004' ,'Gurpreet' , 'A-10/2, SF, MayurVihar', 3511056125 ,'gur_singh@yahoo.com');

/* Queries */ 

SELECT * FROM customer;

-- 1. Display customer name in lower case and customer email in upper case from table CUSTOMER.

SELECT LOWER(CustName), UPPER(Email) 
FROM customer;

-- 2. Display emails after removing the domain name extension “.com” from emails of the customers.

SELECT TRIM('.com' from Email) 'Email without .com'
FROM customer;

-- 3. Display the length of the customer name.

SELECT CustName, LENGTH(CustName)  'Length of Names' 
FROM customer;

-- 4. Display the custid and CustName joined together and the numeric position of the letter A in the Customer name.

SELECT CONCAT(CustID,CustName) AS ID_AND_NAMES, LOCATE ('a',CustName) 'Position'
FROM customer;

-- 5. Write a SQL statement to display the data for those customers whose names end with ‘a’.

SELECT * FROM customer WHERE CustName LIKE '%a';

-- 6. Extract a substring from email starting at position 2 and 3 characters long.

SELECT SUBSTRING(Email,2,3) 'Substring 3 len'
FROM customer; 

-- 7. Extract 20 character string from Customer Address starting with position 1.
SELECT SUBSTRING(CustAdd,1,20) 'Address 20 chars'
FROM customer; 

