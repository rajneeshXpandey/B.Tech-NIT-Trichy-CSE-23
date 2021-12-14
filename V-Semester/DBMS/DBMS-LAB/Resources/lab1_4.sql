
create table car
  (
    serial_no int,
    model varchar(255),
    manufacturer varchar(255),
    price int,
    Primary Key(serial_no)
  );

  create table options
    (
      serial_no int,
      option_name varchar(255),
      price int,
      Foreign Key(serial_no) REFERENCES car(serial_no)
    );

    create table salesperson(
      salesperson_id int,
      name varchar(255),
      phone int,
      Primary Key(salesperson_id)
    );

  create table sales(
    salesperson_id int,
    serial_no int,
    date_of_sale date,
    sale_price int,
    Foreign Key(serial_no) REFERENCES car(serial_no),
    Foreign Key(salesperson_id) REFERENCES salesperson(salesperson_id)
  );

insert into car
values (3,'car1','Audi',1000000);

insert into car
values (2,'car2','Maruti',100000);

insert into car
values (14,'car3','Hyundai',500000);

insert into options
values (2,'Diesel Engine',1000);

insert into options
values (2,'Petrol Engine',1000);

insert into options
values (14,'Diesel Engine',2000);

insert into options
values (14,'GPS Naviagation System',500);

insert into salesperson
values( 23,'John',1 );

insert into salesperson
values( 2,'Carl',2 );

insert into sales
values(23,2,'2016-12-02',101000);

insert into sales
values(2,2,'2016-11-02',100000);

insert into sales
values(23,14,'2018-10-22',502000);

insert into sales
values(2,3,'2019-03-02',1000000);
/*

1)mysql> select car.serial_no,car.manufacturer,sales.sale_price from car,sales,salesperson where sales.salesperson_id=salesperson.salesperson_id and car.serial_no=sales.serial_no and salesperson.name='John'; +-----------+--------------+------------+
| serial_no | manufacturer | sale_price |
+-----------+--------------+------------+
|         2 | Maruti       |     101000 |
|        14 | Hyundai      |     502000 |
+-----------+--------------+------------+
2 rows in set (0.00 sec)
2)
mysql> select c.serial_no,c.model from car c left join options o on c.serial_no=o.serial_no group by c.serial_no having count(o.serial_no)=0;
+-----------+-------+
| serial_no | model |
+-----------+-------+
|         3 | car1  |
+-----------+-------+
1 row in set (0.00 sec)
3)
mysql> select c.serial_no,c.model,s.sale_price  from car c ,sales s where s.serial_no=c.serial_no and s.serial_no in (select c.serial_no from car c left join options o on c.serial_no=o.serial_no group by c.serial_no having count(o.serial_no)>0);
+-----------+-------+------------+
| serial_no | model | sale_price |
+-----------+-------+------------+
|         2 | car2  |     101000 |
|         2 | car2  |     100000 |
|        14 | car3  |     502000 |
+-----------+-------+------------+
3 rows in set (0.00 sec)

4)
mysql> update salesperson set salesperson.phone=456789 where salesperson.name='John';
Query OK, 1 row affected (2.14 sec)
Rows matched: 1  Changed: 1  Warnings: 0
mysql> select  * from salesperson;
+----------------+------+--------+
| salesperson_id | name | phone  |
+----------------+------+--------+
|              2 | Carl |      2 |
|             23 | John | 456789 |
+----------------+------+--------+
2 rows in set (0.00 sec)

*/
