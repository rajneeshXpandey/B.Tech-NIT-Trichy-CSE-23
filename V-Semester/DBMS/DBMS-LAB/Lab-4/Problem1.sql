CREATE DATABASE bankDB;
USE bankDB;

CREATE TABLE branch
(
	branch_name varchar(50) PRIMARY KEY,
	branch_city varchar(50) NOT NULL,
	assets bigint
);

CREATE TABLE account 
(
	account_number varchar(50) PRIMARY KEY,
	branch_name varchar(50) NOT NULL,
	balance INT NOT NULL,
	foreign key(branch_name) references branch(branch_name)
);

CREATE TABLE loan
(
	loan_number varchar(50) PRIMARY KEY,
	branch_name varchar(50) NOT NULL,
	amount INT NOT NULL,
	foreign key(branch_name) references branch(branch_name)
);

CREATE TABLE customer
(
	customer_name varchar(50) PRIMARY KEY,
	customer_sheet varchar(50) NOT NULL,
	customer_city varchar(50) NOT NULL
);

CREATE TABLE depositor
(
	customer_name varchar(50) NOT NULL,
	account_number varchar(50) NOT NULL,
	foreign key(customer_name) references 
	customer(customer_name),
	foreign key(account_number) references account(account_number)
);

CREATE TABLE borrower
(
	customer_name varchar(50) NOT NULL,
	loan_number varchar(50) NOT NULL,
	foreign key(customer_name) references 
	customer(customer_name),
	foreign key(loan_number) references loan(loan_number)
);

insert into branch 
values 
('Brighton','Brooklyn',7100000),
('Downtown','Brooklyn',9000000),
('Mianus','Horseneck',400000),
('North Town','Rye',3700000),
('Perryridge','Horseneck',1700000),
('Pownal','Bennington',300000),
('Redwood','Palo Alto',2100000),
('Round Hill','Horseneck',8000000);

insert into account
values
('A-101','Downtown',500),
('A-102','Perryridge',400),
('A-201','Brighton',900),
('A-215','Mianus',700),
('A-217','Brighton',750),
('A-222','Redwood',700),
('A-305','Round Hill',350);

insert into loan 
values 
('L-11','Round Hill',900),
('L-14','Downtown',1500),
('L-15','Perryridge',1500),
('L-16','Perryridge',1300),
('L-17','Downtown',1000),
('L-23','Redwood',2000),
('L-93','Mianus',500);

insert into customer 
values
('Adams','Spring','Pittsfield'),
('Brooks','Senator','Brooklyn'),
('Curry','North','Rye'),
('Glenn','Sand Hill','Woodside'),
('Green','Walnut','Stamford'),
('Hayes','Main','Harrison'),
('Johnson','Alma','Palo Alto'),
('Jones','Main','Harrison'),
('Lindsay','Park','Pittsfield'),
('Smith','North','Rye'),
('Turner','Putnam','Stamford'),
('Williams','Nassau','Princeton');

insert into depositor
values
('Hayes','A-102'),
('Johnson','A-101'),
('Johnson','A-201'),
('Jones','A-217'),
('Lindsay','A-222'),
('Smith','A-215'),
('Turner','A-305');

insert into borrower
values
('Adams','L-16'),
('Curry','L-93'),
('Hayes','L-15'),
('Johnson','L-14'),
('Jones','L-17'),
('Smith','L-11'),
('Smith','L-23'),
('Williams','L-17');

						/*----------------------------- Querys----------------------------- */
                                    
	SELECT * FROM customer;
	SELECT * FROM depositor;
	SELECT * FROM branch;
	SELECT * FROM account;
	SELECT * FROM loan;            
	SELECT * FROM borrower;


/*1.Create a view consisting of branch names and the names of customers who have either an account or a loan at that branch.
 Assume that view to be called all-customer.*/
 
	create view all_customer as 
	select branch_name , customer_name
	from depositor , account
	where depositor.account_number = account.account_number
	union
	(select branch_name , customer_name
	from borrower , loan 
	where borrower.loan_number = loan.loan_number);
 
 -- For Output
	select * from all_customer;
    
/*2.Create a view gives for each branch the sum of the amounts of all the loans at the branch.*/

	create view sumOfLoans as
	select branch_name , sum(amount)
	from loan
	group by branch_name;
	-- For Output
	select * from sumOfLoans;

/*3.Using the view all-customer, we can find all customers of the Perryridge branch.*/

	select customer_name
	from all_customer
	where branch_name = "Perryridge";

/*4.Write a Query for below Relational algebraic notation :*/

	select depositor.customer_name 
	from depositor
	union
	(select  borrower.customer_name 
	from borrower);
