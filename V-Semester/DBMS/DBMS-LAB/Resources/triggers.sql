
create database trig;
use trig;

create table students
(
        Rollno int NOT NULL PRIMARY KEY,
        Lastname varchar(255),
        Firstname varchar(255),
        Email varchar(255),
        classyear int,
        major varchar(255),
        phoneno varchar(255)
);

create table studentlog
(
        date date,
        user varchar(255) NOT NULL,
        action varchar(255)
);

create table messages
(
        message varchar(255)
);

create table Students
(
        Rollno int,
        Firstname varchar(255)
);

CREATE VIEW temp_view AS SELECT Rollno, Firstname FROM Students;

set @d = 0;

DELIMITER //

create trigger no_of_students
After Insert ON students
FOR EACH ROW 
begin
set @d = (select count(Rollno) from students);
end//
DELIMITER ;




DELIMITER //

create trigger insert_student
before Insert ON students
for each row
begin
if NEW.classyear > 2015 then
set NEW.Rollno = null;
end if;
if NEW.Firstname = "John" then
set NEW.Rollno = null;
end if;

set NEW.phoneno = concat("+91", NEW.phoneno);
INSERT INTO studentlog VALUES (NOW(), CURRENT_USER(), 'INSERT');
INSERT INTO temp_view VALUES (NEW.Rollno, NEW.Firstname);

insert into messages values(concat('Inserting record with rollno', NEW.rollno));

    IF(LOCATE(' ', NEW.Firstname) <> 0) THEN
    SET NEW.Lastname = SUBSTR(new.Firstname, locate(' ', NEW.Firstname) + 1);
    SET NEW.Firstname = SUBSTR(new.Firstname, 1, locate(' ', NEW.Firstname) - 1);
    END IF;


end//
DELIMITER ;


DELIMITER //
create trigger update_stud
before Update ON students
for each row
begin
if NEW.Rollno != OLD.Rollno then
set NEW.Rollno = null;

INSERT INTO studentlog VALUES (NOW(), CURRENT_USER(), 'UPDATE');
end if;
end//
DELIMITER ;






insert into students
(`Rollno`, `Lastname`, `Firstname`, `Email`, `classyear`, `major`, `phoneno`)
values
(@d, "agra", "Nimish", "nimish@gmail.com", 2011, "CSE", "9823232323");


insert into students
(`Rollno`,`Lastname`, `Firstname`, `Email`, `classyear`, `major`, `phoneno`)
values
(3, "agra", "John", "nimish@gmail.com", 2011, "CSE", "9823232323");

update students set Rollno = 2 where Rollno = 1;
