CREATE DATABASE carDB;

CREATE TABLE Car(
	serial_no int NOT NULL,
	model varchar(255) NOT NULL,
	manufacturer varchar(255) NOT NULL,
	price int NOT NULL,
	UNIQUE (serial_no),
	PRIMARY KEY(serial_no)
);

CREATE TABLE salesperson(
	salesperson_id int NOT NULL,
	spname varchar(255) NOT NULL,
	phone DECIMAL(12) NOT NULL,
	UNIQUE (salesperson_id),
	PRIMARY KEY(salesperson_id)
);

CREATE TABLE car_options(	
	serial_no int,
	option_name varchar(255) NOT NULL,
	price int NOT NULL,
	FOREIGN KEY (serial_no) REFERENCES Car(serial_no)
);

CREATE TABLE sales(
	salesperson_id int,
	serial_no int,
	sale_date DATE,
	sale_price int,
	FOREIGN KEY (serial_no) REFERENCES Car(serial_no),
	FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id)
);
 
INSERT INTO Car(serial_no,model,manufacturer,price)
VALUES 
 (1,'Swift','Suzuki',700000),
 (2,'City','Honda',900000),
 (3,'Nano','Tata',500000),
 (4,'Fortuner','Toyota',1000000);
 
INSERT INTO salesperson(salesperson_id,spname,phone)
VALUES 
 (1,'John',8168915356),
 (2,'Tom',9368570708),
 (3,'Martin',7895247308);
 
INSERT INTO car_options(serial_no,option_name,price)
VALUES 
 (1,'Black',850000),
 (1,'Blue',760000),
 (1,'White',900000),
 (2,'Black',850000),
 (2,'Blue',760000),
 (4,'Blue',760000),
 (4,'White',900000);


INSERT INTO sales(salesperson_id,serial_no,sale_date,sale_price)
VALUES 
 (2,1,'2021-01-15',850000),
 (1,2,'2021-04-07',750000),
 (3,3,'2021-03-23',600000),
 (1,4,'2021-03-12',900000);

/* 1 For the sales person named ‘John’ list the following information for all the cars sold : 
			    serial no, manufacturer, sale_price */
	SELECT * 
	FROM Car 
	WHERE serial_no IN(
		SELECT serial_no 
		FROM sales 
		WHERE salesperson_id=
			(SELECT salesperson_id FROM salesperson WHERE spname='John') 
	);

/* 2.List the serial_no and model of cars that have no options */

	SELECT serial_no,model
	FROM
	(SELECT Car.serial_no,Car.model,car_options.option_name
	FROM Car left join car_options
	ON Car.serial_no = car_options.serial_no
	GROUP BY Car.serial_no) data
	WHERE data.option_name IS NULL;


/* 3.List the serial_no, model, sale_price for the cars that have optional parts.  */

	SELECT serial_no,model,SP
	FROM
	(SELECT Car.serial_no,Car.model,car_options.option_name, (SELECT sale_price FROM sales WHERE serial_no = Car.serial_no) SP 
	FROM Car left join car_options
	ON Car.serial_no = car_options.serial_no
	GROUP BY Car.serial_no) data
	WHERE data.option_name IS NOT NULL;

/* 4.Modify the phone no of a particular sales person */

	UPDATE salesperson
	SET phone = 8941999954
	WHERE spname='Tom';

	SELECT * FROM salesperson;