 CREATE DATABASE vacationDB;

CREATE TABLE salesperson(
  ssn int NOT NULL,
  personName varchar(255),
  start_year varchar(255),
  dept_no int,
  UNIQUE (ssn),
  PRIMARY KEY (ssn)
  );
  
CREATE TABLE trip(
  trip_id int NOT NULL, 
  ssn int,
  from_city varchar(255),
  to_city varchar(255),
  departure_date varchar(255),
  return_date varchar(255),
  UNIQUE (trip_id),
  PRIMARY KEY (trip_id),
  FOREIGN KEY (ssn) REFERENCES salesperson(ssn)
  );
  
CREATE TABLE salerep_expense(
  trip_id int, 
  expense_type  varchar(255), /* The expense types are ‘TRAVEL’, ‘STAY’ and ‘FOOD’ */
  amount int,
  FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
  );

INSERT INTO salesperson(ssn,personName,start_year,dept_no)
VALUES 
 (1000,'Harry','12/28/1984',100),
 (2000,'Wilson','5/18/1983',200),
 (3000,'Mildred','6/21/1969',300),
 (4000,'Anderson','10/21/1995',400),
 (5000,'Bob','10/13/1960',500);

INSERT INTO trip(trip_id,from_city,to_city,departure_date,return_date,ssn)
VALUES 
 (1,'Mandu','Sanchi','2021-09-13','2021-10-01',2000),
 (2,'Khajuraho','Chennai','2021-08-24','2021-09-27',1000),
 (3,'Ujjain','Bhopal','2021-11-01','2021-12-20',5000),
 (4,'Orchha','Indore','2021-12-27','2022-01-15',3000),
 (5,'Pachmarhi','Chennai','2021-11-23','2021-12-20',4000),
 (6,'Jammu','Chennai','2021-11-20','2021-12-20',4000);
 
INSERT INTO salerep_expense(trip_id,expense_type,amount)
VALUES 
 (1,'TRAVEL',2000),
 (2,'TRAVEL',1500),
 (3,'TRAVEL',2100),
 (4,'TRAVEL',1300),
 (5,'TRAVEL',1800),
 (6,'TRAVEL',1000),
 (1,'STAY',500),
 (2,'STAY',600),
 (4,'STAY',620),
 (6,'STAY',600),
 (1,'FOOD',800),
 (2,'FOOD',100),
 (3,'FOOD',700),
 (4,'FOOD',600);
 
/* 1.Give the details (all attributes of trip relation) for trips that exceed Rs2000.  */

	SELECT trip_id,from_city,to_city,departure_date,return_date
	FROM
	(SELECT trip.trip_id,trip.from_city,trip.to_city,trip.departure_date,trip.return_date,sum(salerep_expense.amount) total
	FROM trip left join salerep_expense
	ON trip.trip_id = salerep_expense.trip_id
	GROUP BY trip.trip_id) data
	WHERE data.total>2000;
    
/* 2.Print the ssn of salesperson who took trips to chennai more than once */

	SELECT ssn 
	FROM salesperson sp
	WHERE 1 < 
		(SELECT COUNT(*) 
		 FROM trip 
		 WHERE ssn = sp.ssn AND to_city='Chennai');
         
/* 3.Print the total trip expenses incurred by the salesperson with ssn = 1000 */
    
	SELECT sum(salerep_expense.amount) total
	FROM trip left join salerep_expense
	ON trip.trip_id = salerep_expense.trip_id
	GROUP BY trip.ssn = 1000;

/* 4.Display the salesperson details in the sorted order based on name */ 
	
	SELECT *
	FROM salesperson sp
	ORDER BY sp.personName ASC;
 
 
  