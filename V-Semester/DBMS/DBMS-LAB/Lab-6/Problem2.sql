CREATE DATABASE customerDB; 
USE customerDB;

create table customer 
( 
    ssn int primary key, 
    name varchar(30), 
    phone_no varchar(30), 
    plan varchar(30) 
); 

create table bill 
( 
    ssn int not null, 
    foreign key (ssn) references customer(ssn), 
    month int not null, 
    year int not null, 
    amount int not null 
); 

create table calls 
( 
    from_ssn int, 
    to_ssn int, 
    month int, 
    year int, 
    amount int, 
    foreign key(from_ssn) references customer(ssn), 
    foreign key(to_ssn) references customer(ssn) 
); 

-- -- a. That Adds +91 to all phone numbers as a prefix in the Customer Table.

--  delimiter // 
--  create trigger trig2A 
--     before insert on customer 
--     for each row 
--     begin 
--     set new.phone_no = concat("+91",new.phone_no); 
--     end;// 

-- -- b. Write a trigger that after each phone call updates the customer's bill.
-- delimiter // 
-- create trigger trig2B after insert on calls 
--     for each row 
--     update bill 
--     set bill.amount = bill.amount + new.amount 
--     where bill.year = new.year 
--     and bill.month = new.month 
--     and bill.ssn = new.from_ssn;// 

--  -- c. Write a trigger to not insert bill older than 2020 (year > 2020).

--  delimiter // 
-- create trigger trig2C before insert on bill 
--     for each row 
--     begin 
--     if new.year < 2020 then signal sqlstate '45003' set message_text = "Bill year must be >= 2020 !!!"; 
--     end if; 
--     end;//
