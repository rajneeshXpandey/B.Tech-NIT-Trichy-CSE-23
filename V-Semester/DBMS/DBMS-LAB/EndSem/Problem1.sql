create database collegeDB;
use collegeDB;

create table department(
    dept_name varchar(20) not null,
    building varchar(20),
    budget int,
    primary key(dept_name)
);

create table course(
    course_id varchar(20) not null,
    title varchar(20) not null,
    dept_name varchar(20) not null,
    credits int not null,
    primary key(course_id),
    foreign key(dept_name) references department(dept_name)
);

 create table time_slot(
     time_slot_id int not null,
     day varchar(20) not null,
     start_time int not null,
     end_time int not null,
     primary key(time_slot_id)
 );

create table section(
    section_id int not null,
    course_id varchar(20) not null,
    semester varchar(20) not null,
    year DATE not null,
    building int not null,
    room_number int not null,
    primary key(section_id, course_id),
    foreign key(course_id) references course(course_id)
);



create table instructor(
    instructor_id int not null,
    name varchar(20) not null,
    dept_name varchar(20) not null,
    salary int not null,
    primary key(instructor_id),
    foreign key(dept_name) references department(dept_name)
);

insert into department values 
      ('Finance', 'Building', '100000'), 
      ('Physics', 'Building', '100000'), 
      ('CompSci', 'Building', '100000');

insert into course values 
	('CS-101', 'Title', 'CompSci', 10),
	('CS-315', 'Title', 'CompSci', 10),
	('CS-347', 'Title', 'CompSci', 10),
	('FIN-201', 'Title', 'Finance', 10),
	('MU-199', 'Title', 'Finance', 10),
	('PHY-101', 'Title', 'Physics', 10);

insert into section values 
	(1, 'CS-101', 'Fall', '2009-01-01', 1, 10101),
	(1, 'CS-315', 'Spring', '2010-01-01', 1, 10101),
	(1, 'CS-347', 'Fall', '2009-01-01', 1, 10101),
	(1, 'FIN-201', 'Spring', '2010-01-01', 1, 12121),
	(1, 'MU-199', 'Spring', '2010-01-01', 1, 15151),
	(1, 'PHY-101', 'Fall', '2009-01-01', 1, 22222);



insert into instructor values 
	(12121, 'Wu', 'Finance', 90000),
	(222222, 'Einstein', 'Physics', 95000),
	(33456, 'Gold', 'Physics', 87000),
	(83821, 'Brnadt', 'CompSci', 92000);


-- a)	Find Courses that ran in Fall 2009 or in Spring 2010
 
select * from course, section where course.course_id = section.course_id 
and ((year(section.year) = year('2009-01-01') and section.semester = 'Fall') or 
(year(section.year) = year('2010-01-01') and section.semester = 'Spring'));

-- b)	Find the ID and name whose salary is less than 95000 except the person salary 92000.

select instructor_id, name from instructor where salary < 95000 and salary != 92000;


