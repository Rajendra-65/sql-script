create database assignment1;

use assignment1;

create table if not exists city (
	id int,
    name varchar(17),
    countrycode varchar(3),
    district varchar(20),
    population int
);

select * from city where population > 10000;

select name from city where population > 120000 and countrycode = "USA";

select * from city;

select * from city where id = 1661;

select * from city where countrycode = "JPN";

select name from city where countrycode = "JPN";

select  City,State from stationdata;

select distinct City from stationdata where Id % 2 = 0;

SELECT 
    (SELECT COUNT(1) FROM stationdata) - (SELECT COUNT(DISTINCT City) FROM stationdata) AS Difference;

(select City,length(City) as city_length 
from stationdata
order by length(City),left(City,1) asc limit 1)
union
(select City,length(City) as city_length 
from stationdata
order by length(City) desc limit 1);

select distinct City
from stationdata
where right(City, 1) like 'a%'
   or right(City, 1) like 'e%'
   or right(City, 1) like 'i%'
   or right(City, 1) like 'o%'
   or right(City, 1) like 'u%';

select distinct City
from stationdata
where left(City, 1) like '%a'
   or left(City, 1) like '%e'
   or left(City, 1) like '%i'
   or left(City, 1) like '%o'
   or left(City, 1) like '%u';
   
select distinct City
from stationdata
where lower(LEFT(City, 1)) not like 'a%'
   and lower(LEFT(City, 1)) not like 'e%'
   and lower(LEFT(City, 1)) not like 'i%'
   and lower(LEFT(City, 1)) not like 'o%'
   and lower(LEFT(City, 1)) not like 'u%';
   
select distinct City
from stationdata
where lower(right(City, 1)) not like 'a%'
   and lower(right(City, 1)) not like 'e%'
   and lower(right(City, 1)) not like 'i%'
   and lower(right(City, 1)) not like 'o%'
   and lower(right(City, 1)) not like 'u%';

SELECT DISTINCT City
FROM stationdata   --  question 15 
WHERE LOWER(LEFT(City, 1)) NOT IN ('a', 'e', 'i', 'o', 'u')
   OR LOWER(RIGHT(City, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');

select distinct City  
from stationdata                          -- question 16 
where lower(left(City, 1)) not like '%a%'
   and lower(right(City, 1)) not like '%e%'
   and lower(right(City, 1)) not like '%i%'
   and lower(right(City, 1)) not like '%o%'
   and lower(right(City, 1)) not like '%u%';
   
create table product (
	product_id int primary key,
    product_name varchar(20),
    unit_price int
);

create table sales(
	seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
    quantity int,
    price int
);

insert into product 
	values
    (1,'s8',1000),
    (2,'G4',800),
    (3,'iPhone',1400);

insert into sales
	values
    (1,1,1,"2019-01-21",2,2000),
    (1,2,2,"2019-02-17",1,800),
    (2,2,3,"2019-06-02",1,2000),
    (3,3,4,"2019-05-13",2,2800);

select p.product_id , p.product_name
from product p    -- questioin-17 gpt
join sales s on s.product_id = p.product_id
where s.sale_date >= "2019-01-01" and s.sale_date <= "2019-03-31";

create table views (
   article_id int,
   author_id int,
   viewer_id int,
   view_date date
);

insert into views 
	value
    (1,3,5,'2019-08-01'),
    (1,3,6,'2019-08-02'),
    (2,7,7,'2019-08-01'),
    (2,7,6,'2019-08-02'),
    (4,7,1,'2019-07-22'),
    (3,4,4,'2019-07-21'),
    (3,4,4,'2019-07-21');

select distinct  author_id as id 
from views  -- question 18 clear
where author_id = viewer_id
order by author_id;

create table delivery (
	delivery_id int,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date
);

insert into delivery 
		values
        (1,1,'2019-08-01','2019-08-02'),
        (2,5,'2019-08-02','2019-08-02'),
        (3,1,'2019-08-02','2019-08-02'),
        (4,4,'2019-08-02','2019-08-26'),
        (5,3,'2019-08-02','2019-08-22'),
        (6,2,'2019-08-02','2019-08-13');

select 
	round(((select count(delivery_id) from delivery where order_date = customer_pref_delivery_date) / (select count(distinct delivery_id) from delivery) * 100),2) as immediate_percentage ;         
    
create table ads(
   ad_id int,
   user_id int,
   action varchar(12)
);

insert into ads
	values
    (1,1,'Clicked'),
    (2,2,'Clicked'),
    (3,3,'Viewed'),
    (5,5,'Ignored'),
    (1,7,'Ignored'),
    (2,7,'Viewed'),
    (3,5,'Clicked'),
    (1,4,'Viewed'),
    (2,11,'Viewed'),
    (1,2,'Clicked');

select * from ads;

select 
    ad_id,               
    round(                            -- question 21
        (                                   
            (select count(*) from ads a1 where a1.ad_id = a.ad_id and a1.action = 'Clicked')
            /
            NULLIF((SELECT COUNT(*) from ads a2 where a2.ad_id = a.ad_id and a2.action in ('Clicked', 'Viewed')), 0)
        ) * 100, 2
    ) as ctr
from
    ads a
group by 
    ad_id;

create table countries (
	country_id int,
    country_name varchar(10)
);

insert into countries
	values
    (2,"USA"),
    (3,"Australia"),
    (7,"Peru"),
    (5,"China"),
    (8,"Morocco"),
    (9,"Spain");

select * from countries;

create table weather (
	country_id int,
    weather_state int,
    day date 
);

insert into weather 
		values
        (2,15,'2019-11-01'),
        (2,12,'2019-10-28'),
        (2,12,'2019-10-27'),
        (3,-2,'2019-11-10'),
        (3,0,'2019-11-11'),
        (3,3,'2019-11-12'),
        (5,16,'2019-11-07'),
        (5,18,'2019-11-09'),
        (5,21,'2019-11-23'),
        (7,25,'2019-11-28'),
        (7,22,'2019-12-01'),
        (7,20,'2019-12-02'),
        (8,25,'2019-11-05'),
        (8,27,'2019-11-05'),
        (8,31,'2019-11-25'),
        (9,7,'2019-10-23'),
        (9,3,'2019-12-23');
        
WITH country_weather AS (
    SELECT 
        c.country_name,
        w.country_id,
        SUM(w.weather_state) / COUNT(*) AS average_weather_state    -- question 22
    FROM 
        countries c
    JOIN 
        weather w ON w.country_id = c.country_id
    WHERE 
        w.day >= '2019-11-01' AND w.day <= '2019-11-30'
    GROUP BY 
        c.country_name, w.country_id
)
 
SELECT 
    cw.country_name,
    CASE 
        WHEN cw.average_weather_state >= 25 THEN 'Hot'
        WHEN cw.average_weather_state >= 15 THEN 'Cold'
        ELSE 'Warm'
    END AS weather_category
FROM 
    country_weather cw;

-- question -24

create table Activity (
	player_id int,
    device_id int, 
    event_date date,
    games_played int
);

insert into Activity 
			values
            (1,2,'2016-03-01',5),
            (1,2,'2016-05-02',6),
            (2,3,'2017-06-25',1),
            (3,1,'2016-03-02',0),
            (3,4,'2018-07-03',5);

select * from Activity;

with MinDates as (
    select player_id, min(event_date) as min_event_date
    from Activity
    group by player_id
)

select player_id, min_event_date as event_date
from MinDates
order by player_id;

create table Activity2 (
	player_id int,
    device_id int,
    event_date date
);

insert into Activity2 
			values
            (1,2,'2016-03-01'),
            (1,2,'2016-05-02'),
            (2,3,'2017-06-25'),
            (3,1,'2016-03-02'),
            (3,4,'2018-07-03');

select * from Activity2;

WITH MinDates AS (
    SELECT player_id, MIN(event_date) AS min_event_date
    FROM Activity2
    GROUP BY player_id
)
SELECT DISTINCT a.player_id, a.device_id
FROM Activity2 a
JOIN MinDates md ON a.player_id = md.player_id AND a.event_date = md.min_event_date
ORDER BY a.player_id;

create table products (
	product_id int,
    product_name varchar(25),
    product_category varchar(25)
);

insert into products 
			values
            (1,'Leetcode solutions','Book'),
            (2,'Jewels of Sttringology','Book'),
            (3,'HP','Laptop'),
            (4,'Lenevo','Laptop'),
            (5,'Leetcode Kit','T-shirt');

select * from products;

create table orders (
	product_id int,
    order_date date,
    unit int
);

insert into orders
		values
        (1,'2020-02-05',60),
        (1,'2020-02-10',70),
        (2,'2020-01-18',30),
        (2,'2020-02-11',80),
        (3,'2020-02-17',23),
        (3,'2020-02-24',20),
        (4,'2020-03-01',30),
        (4,'2020-03-04',60),
        (4,'2020-03-04',50),
        (5,'2020-02-25',50),
        (5,'2020-02-27',50);
        
-- Correct SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount
SELECT p.product_name, o.total_units AS unit
FROM products p
JOIN (
    SELECT product_id, SUM(unit) AS total_units  -- doubts here values getting doubled
    FROM orders
    WHERE order_date >= '2020-02-01' AND order_date <= '2020-02-29'
    GROUP BY product_id
) o ON p.product_id = o.product_id
WHERE o.total_units >= 100
ORDER BY p.product_name;

create table tvprogram (
	program_date date,
    content_id int,
    channel varchar(35)
);

create table content (
	content_id int,
    title varchar(25),
    kids_content varchar(1),
    content_type varchar(10)
);

insert into tvprogram 
			values('2020-06-10',1,'LC-Channel'),
				  ('2020-05-11',2,'LC-Channel'),
                  ('2020-05-12',3,'LC-Channel'),
                  ('2020-05-13',4,'Disney ch'),
                  ('2020-06-18',4,'Disney ch'),
                  ('2020-07-15',5,'Disney ch');
            
insert into content
			values
            (1,'Leetcode Movie','N','Movies'),
            (2,'Alg. for Kids','Y','Series'),
            (3,'Database Sols','N','Series'),
            (4,'Aladdin','Y','Movies'),
            (5,'Cinderella','Y','Movies');

select * from content;

select content.title
from content
join tvprogram on tvprogram.content_id = content.content_id
where content.kids_content= 'Y' and tvprogram.program_date >='2020-06-01' and tvprogram.program_date <= '2020-06-30';

create table npv (
	id int,
    year int,
    npv int
);

create table queries (
	id int,
    year int
);

insert into npv 
			values
            (1,2018,100),
            (7,2020,30),
            (13,2019,40),
            (1,2019,113),
            (2,2008,121),
            (3,2009,12),
            (11,2020,99),
            (7,2019,0);

insert into queries
			values
            (1,2019),
            (2,2008),
            (3,2009),
            (7,2018),
            (7,2019),
            (7,2020),
            (13,2019);

select queries.id,queries.year,npv.npv
from queries
join npv on npv.id = queries.id and npv.year = queries.year
order by queries.id;

create table employees (
		id int primary key,
        name varchar(25)
);

create table employeeuni (
		id int,
        unique_id int primary key
);

insert into employees
			values
            (1,'Alice'),
            (7,'Bob'),
            (11,'Meir'),
            (90,'Winston'),
            (3,'Jonathon');
            
insert into employeeuni
			values
            (3,1),
            (11,2),
            (90,3);

select employeeuni.unique_id,employees.name
from employeeuni
right join employees on employees.id = employeeuni.id;

create table users (
	id int primary key,
    name varchar(25)
);

create table rides (
	id int primary key,
    user_id int,
    distance int
);

insert into users 
			values
            (1,'Alice'),
            (2,'Bob'),
            (3,'Alex'),
            (4,'Donald'),
            (7,'Lee'),
            (13,'Jonathan'),
            (19,'Elvis');
            
insert into rides 
			values
            (1,1,120),
            (2,2,317),
            (3,3,222),
            (4,7,100),
            (5,13,312),
            (6,19,50),
            (7,7,120),
            (8,19,400),
            (9,7,230);

select users.name,coalesce(sum(rides.distance),0) as travelled_distance 
from users
left join rides on users.id = rides.user_id
group by users.name
order by sum(rides.distance) desc ,users.name;

create table movies (
	movie_id int,
    title varchar(25)
); 

create table movie_users (
	user_id int primary key,
    name varchar(25)
);

create table movierating (
	movie_id int,
    user_id int,
    rating int,
    created_at date
);

insert into movies
			values
            (1,'Avengers'),
            (2,'Frozen2'),
            (3,'Joker');

insert into movie_users 
			values
            (1,'Daniel'),
            (2,'Monica'),
            (3,'Maria'),
            (4,'James');
            
insert into movierating
			values
            (1,1,3,'2020-01-12'),
            (1,2,4,'2020-02-11'),
            (1,3,2,'2020-02-12'),
            (1,4,1,'2020-01-01'),
            (2,1,5,'2020-02-17'),
            (2,2,2,'2020-02-01'),
            (2,3,2,'2020-03-01'),
            (3,1,3,'2020-02-22'),
            (3,2,4,'2020-02-25');
           
(select movie_users.name as result
from movie_users
join movierating on movie_users.user_id = movierating.user_id
group by movierating.user_id
order by count(movierating.user_id) desc limit 1)
union
(select movies.title 
from movies
join movierating on movies.movie_id = movierating.movie_id
where movierating.created_at >= '2020-02-01' and movierating.created_at <= '2020-02-29'
group by movies.movie_id, movies.title
order by avg(movierating.rating) desc, movies.title Asc
limit 1); -- ......................   question 36 completed day1 completedd   ....................

create table departments (
	id int primary key,
    name varchar(25)
);

create table students (
	id int primary key,
    name varchar(25),
    department_id int
);

insert into departments
			values 
            (1,'Electrical Engineering'),
            (7,'Computer Engineering'),
            (13,'Business Administration');

insert into students 
			values
            (23,'Alice',1),
            (1,'Bob',7),
            (5,'Jennifer',13),
            (2,'John',14),
            (4,'Jasmin',77),
            (3,'Steve',74),
            (6,'Luis',1),
            (8,'Jonathan',7),
            (7,'Daiana',33),
            (11,'Madelynn',1);

SELECT DISTINCT students.id, students.name
FROM students
LEFT JOIN departments ON students.department_id = departments.id
WHERE students.department_id NOT IN (1, 7, 13); -- doubt in question 39 

create table prices (
	product_id int,
    start_date date,
    end_date date,
    price int
);

create table unitssold (
	product_id int,
    purchase_date date,
    units int
);

insert into prices 
			values
            (1,'2019-02-17','2019-02-28',5),
            (1,'2019-03-01','2019-03-22',20),
            (2,'2019-02-01','2019-02-20',15),
            (2,'2019-02-21','2019-03-31',30);
            
insert into unitsSold
			values
            (1,'2019-02-25',100),
            (1,'2019-03-01',15),
            (2,'2019-02-10',200),
            (2,'2019-03-22',30);
            
            
select unitsSold.product_id,round(sum(unitsSold.units * prices.price )/sum(unitsSold.units),2) as average_price
from unitsSold
join prices on prices.product_id = unitsSold.product_id
where unitsSold.purchase_date >= prices.start_date and unitsSold.purchase_date <= prices.end_date
group by unitsSold.product_id;

create table warehouse (
    name varchar(25),
    product_id int ,
    units int
);

create table wareProducts (
	product_id int primary key,
    product_name varchar(25),
    width int,
    length int,
    height int
);

insert into warehouse 
			 values
             ('LCHouse1',1,1),
             ('LCHouse1',2,10),
             ('LCHouse1',3,5),
             ('LCHouse2',1,2),
             ('LCHouse2',2,2),
             ('LCHouse3',4,1);

SELECT w.name AS warehouse_name, SUM(p.width * p.length * p.height * i.quantity) AS volume
FROM wareProducts AS i
JOIN products_dimensions AS p ON i.product_id = p.product_id
JOIN warehouses AS w ON i.warehouse_name = w.name
GROUP BY w.name;                  -- doubt in this query and question also 

 
select * from wareProducts;

create table fruit_sale(
	sale_date date,
    fruit varchar(15),
    sold_num int
);
drop table fruit_sale;
insert into fruit_sale
			values
            ('2020-05-01','apple',10),
            ('2020-05-01','orange',8),
            ('2020-05-02','apple',15),
            ('2020-05-02','orange',15),
            ('2020-05-03','apple',20),
            ('2020-05-03','orange',0),
            ('2020-05-04','apple',15),
			('2020-05-04','orange',16);

SELECT fs_apple.sale_date,
       COALESCE(fs_apple.sold_num, 0) - COALESCE(fs_orange.sold_num, 0) AS diff
FROM (SELECT sale_date, sold_num
      FROM fruit_sale
      WHERE fruit = 'apple') fs_apple
LEFT JOIN (SELECT sale_date, sold_num
           FROM fruit_sale
           WHERE fruit = 'orange') fs_orange
ON fs_apple.sale_date = fs_orange.sale_date
UNION
SELECT fs_orange.sale_date,
       COALESCE(fs_apple.sold_num, 0) - COALESCE(fs_orange.sold_num, 0) AS diff
FROM (SELECT sale_date, sold_num
      FROM fruit_sale
      WHERE fruit = 'apple') fs_apple
RIGHT JOIN (SELECT sale_date, sold_num
            FROM fruit_sale
            WHERE fruit = 'orange') fs_orange
            
ON fs_apple.sale_date = fs_orange.sale_date;

create table empManager (
	id int,
    name varchar(20),
    department varchar(2),
    managerId int
);

insert into empManager 
			values
            (101,'John','A',null),
            (102,'Dan','A',101),
            (103,'James','A',101),
            (104,'Amy','A',101),
            (105,'Anne','A',101),
            (106,'Ron','B',101);

select name
from empManager
where empManager.managerId is null;

create table student (
	student_id int,
    student_name varchar(10),
    gender varchar(2),
    dept_id int
);

create table department (
	dept_id int,
    dept_name varchar(15)
);

insert into student
			values
            (1,'Jack','M',1),
            (2,'Jane','F',1),
            (3,'Mark','M',2);
            
insert into department
			values
            (1,'Engineering'),
            (2,'Science'),
            (3,'Law');
            
select dept_name,coalesce(count(student.dept_id),0) as student_number
from department
left join student on student.dept_id = department.dept_id
group by department.dept_name;

create table customer (
	customer_id int,
    product_key int
);

create table productKey(
	product_key int 
);

insert into customer 
			values
            (1,5),
            (2,6),
            (3,5),
            (3,6),
            (1,6);
            
insert into productKey
			values
            (5),
            (6);
select * from customer;

select customer_id
from customer
join productKey on  customer.customer_id = productKey.product_key;

create table project (
	project_id int,
    emloyee_id int
);

create table projectEmployee (
	employee_id int,
    name varchar(20),
    experience_year int
);

insert into project
			values
            (1,1),
            (1,2),
            (1,3),
            (2,1),
            (2,4);

insert into projectEmployee
			values
            (1,'Khaled',3),
            (2,'Ali',2),
            (3,'John',3),
            (4,'Doe',2);

WITH MaxExperience AS (
    SELECT 
        project_id,
        MAX(experience_year) AS max_experience
    FROM 
        projectEmployee
    GROUP BY 
        project_id
)
-- doubt is here 
SELECT 
    e.project_id,
    e.employee_id,
    e.experience_year
FROM 
    projectEmployee e
JOIN 
    MaxExperience m
ON 
    e.project_id = m.project_id AND e.experience_year = m.max_experience;

create table enrollment(
	student_id int,
    course_id int,
    grade int
);

insert into enrollment 
			values
            (2,2,95),
            (2,3,95),
            (1,1,90),
            (1,2,99),
            (3,1,80),
            (3,2,75),
            (3,3,82);

with MaxGrades as (
    select 
        student_id,
        max(grade) as max_grade
    from 
        enrollment
    group by 
        student_id
)

select
    e.student_id,
    e.course_id,
    e.grade
from
    enrollment e
join
    MaxGrades m
on
    e.student_id = m.student_id and e.grade = m.max_grade
order by
    e.student_id;

