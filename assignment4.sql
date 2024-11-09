create database assignment4;

use assignment4;

CREATE TABLE UserActivity (
    username VARCHAR(50),
    activity VARCHAR(50),
    startDate DATE,
    endDate DATE
);

use kafka_assignment;
CREATE TABLE product ( id  INT Primary Key, name  VARCHAR(250), category  VARCHAR(250), price float, last_updated timestamp)
select * from product;
INSERT INTO UserActivity (username, activity, startDate, endDate) VALUES
('Alice', 'Travel', '2020-02-12', '2020-02-20'),
('Alice', 'Dancing', '2020-02-21', '2020-02-23'),
('Alice', 'Travel', '2020-02-24', '2020-02-28'),
('Bob', 'Travel', '2020-02-11', '2020-02-18');

WITH ranked_activity AS (
    SELECT *,
           RANK() OVER (PARTITION BY username ORDER BY startDate DESC) AS rnk
    FROM UserActivity
),
ranked_filtered AS (
    SELECT username,
           activity,
           startDate,
           endDate,
           rnk
    FROM ranked_activity
    WHERE rnk = 1 OR rnk = 2
)
SELECT username,
       activity,
       startDate,
       endDate
FROM ranked_filtered
WHERE rnk = 2
   OR (rnk = 1 AND NOT EXISTS (SELECT 1
                               FROM ranked_filtered rf2
                               WHERE rf2.username = ranked_filtered.username
                                 AND rf2.rnk = 2));

create table 
			students(
				id int,
                name varchar(50),
                marks int);

insert into students values
		(1,'Ashley',81),
        (2,'Samantha',75),
        (4,'Julia',76),
        (3,'Belvet',84);

with filtered_students as(
select * 
from 
students
where marks > 75)
select 
name
from filtered_students
order by right(name,3);  

create table employee(
		employee_id int,
        name varchar(20),
        months int,
        salary int
);

insert into employee 
			values
            (12228,'Rose', 15,1968),
            (33645,'Angela',1,3443),
            (45692,'Frank',17,1608),
            (56118,'Patrick',7,1345),
            (59725,'Lisa',11,2330),
			(74197,'Kimberly',16,4372),
            (78454,'Bonnie',8,1771),
            (83565,'Michel',6,2017),
            (98607,'Todd',5,3396),
            (99989,'Joe',9,3573);
            
select * from employee;

with sorted_month as (
select 
* from
employee
where months < 10)
select 
name from
sorted_month
where salary > 2000;

create table triangles
				( A int,
				  B int,
                  C int
                );

insert into triangles
			values
            (20,20,23),
            (20,20,20),
            (20,21,22),
            (13,14,30);
            
select 
case 
	when A = B and B=C and C=A then 'Equilateral'
    when A = B then 'Isoscales'
    when A != B and B!= C and C!=A and A+B > C then 'Scalene'
    when A+B < C then 'Not a triangle'
    end as type_of_triangle
from triangles;

create table correct
			 (
				id int,
                name varchar(15),
                salary int
             );
			
insert into correct
				values
                (1,'Kristen',1420),
                (2,'Ashley',2006),
                (3,'Julia',2210),
                (4,'Maria',3000);
                
create table incorrect
			 (
				id int,
                name varchar(15),
                salary int
             );

insert into incorrect
			values
            (1,'Kristen',142),
            (2,'Ashley',26),
            (3,'Julia',221),
            (4,'Maria',3);

select ((select avg(salary) from correct) - (select avg(salary) from incorrect)) as diff;

create table employee1 (
		employee_id int,
        name varchar(30),
        month int,
        salary int
);

insert into employee1 
			values
            (12228,'Rose',15,1968),
            (33645,'Angela',1,3443),
            (45692,'Frank',17,1608),
            (56118,'Patrick',7,1345),
            (59725,'Lisa',11,2330),
            (74197,'Kimberly',16,4372),
            (78454,'Bonnie',8,1771),
            (83565,'Michal',6,2017),
            (98607,'Todd',5,3396),
            (99989,'Joe',9,3573);
            
with salary_highest as (
	select *,
    month * salary as total_earnings
    from employee1
)
select 
max(total_earnings),count(*) as count
from salary_highest
where total_earnings >= (select max(total_earnings) from salary_highest);

create table occupation1(
	name varchar(20),
    occupation varchar(20)
);

insert into occupation1
			values
            ('Samantha','Doctor'),
            ('Julia','Actor'),
            ('Maria','Actor'),
            ('Meera','Singer'),
            ('Ashley','Professor'),
            ('Ketty','Professor'),
            ('Christeen','Professor'),
            ('Jane','Actor'),
            ('Jenny','Doctor'),
            ('Priya','Singer');

(select
concat(name , '(' , left(occupation,1) , ')') as name_of_profession
from 
occupation1
order by name,left(occupation,1)
)
union all
(
	select
    concat('There are total of ' , count(*) , 'doctors')
    from occupation1
    group by left(occupation,1)
);

create table binary_table(
	n int,
    p int
);

insert into binary_table
			values
            (1,2),
            (3,2),
            (6,8),
            (9,8),
            (2,5),
            (8,5),
            (5,null);
            
select
case 
	when p is null then concat(n,'  ','root')
    when n in (select p from binary_table) then concat(n,'  ','inner')
    else concat(n,'  ','Leaf')
	end as type_of_node
from binary_table;

create table company
				(
					company_code varchar(15) primary key,
                    founder varchar(15)
                );

insert into company
			values
            ('C1','Monika'),
            ('C2','Samantha');

create table lead_manager
			(
				lead_manager_code varchar(15) primary key,
                company_code varchar(15)
            );

insert into lead_manager
			values
            ('LM1','C1'),
            ('LM2','C2');

create table senior_manager
			 (
				senior_manager_code varchar(15) primary key,
                lead_manager_code varchar(15),
                company_code varchar(15),
                foreign key(lead_manager_code) references lead_manager(lead_manager_code),
                foreign key(company_code) references company(company_code)
             );

insert into senior_manager
			values
            ('SM1','LM1','C1'),
            ('SM2','LM1','C1'),
            ('SM3','LM2','C2');
             
create table manager
			(
				manager_code varchar(15) primary key,
                senior_manager_code varchar(15),
                lead_manager_code varchar(15),
                company_code varchar(15),
                foreign key(senior_manager_code) references senior_manager(senior_manager_code),
                foreign key(lead_manager_code) references lead_manager(lead_manager_code),
                foreign key(company_code) references company(company_code)
            );
            
insert into manager
			values
            ('M1','SM1','LM1','C1'),
            ('M2','SM3','LM2','C2'),
            ('M3','SM3','LM2','C2');
            
create table employee2
			(
				employee_code varchar(15) primary key,
                manager_code varchar(15),
                senior_manager_code varchar(15),
                lead_manager_code varchar(15),
                company_code varchar(15),
                foreign key(manager_code) references manager(manager_code),
                foreign key(senior_manager_code) references senior_manager(senior_manager_code),
                foreign key(lead_manager_code) references lead_manager(lead_manager_code),
                foreign key(company_code) references company(company_code)
            );
            
insert into employee2
			values
            ('E1','M1','SM1','LM1','C1'),
            ('E2','M1','SM1','LM1','C1'),
            ('E3','M2','SM3','LM2','C2'),
            ('E4','M3','SM3','LM2','C2');
            
SELECT 
    c.company_code, 
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS lead_manager_count,
    COUNT(DISTINCT sm.senior_manager_code) AS senior_manager_count,
    COUNT(DISTINCT mn.manager_code) AS manager_count,
    COUNT(DISTINCT emp.employee_code) AS employee_count
FROM 
    company c
JOIN 
    lead_manager lm ON c.company_code = lm.company_code
JOIN 
    senior_manager sm ON sm.lead_manager_code = lm.lead_manager_code
JOIN 
    manager mn ON mn.senior_manager_code = sm.senior_manager_code
JOIN 
    employee2 emp ON emp.manager_code = mn.manager_code
GROUP BY 
    c.company_code, c.founder
ORDER BY 
    c.company_code;

WITH CTE AS (
    SELECT 1 AS id
    UNION ALL
    SELECT id + 1 
    FROM CTE 
    WHERE id < 5
)
SELECT REPLICATE('*  ', id) 
FROM CTE;

show database;
use assignment4;

create table product (
		id int primary key,
        name varchar(250),
        category varchar(250),
        price float,
        last_updated timestamp
);

INSERT INTO product (id, name, category, price, last_updated) VALUES 
(1, 'AJCOBM0W0Y', 'Sports', 883.99, '2024-07-12 16:12:11'),
(2, '7C94AV0EKA', 'Toys', 372.32, '2024-07-12 16:12:12'),
(3, 'AJYZY9I88E', 'Electronics', 917.59, '2024-07-12 16:12:13'),
(4, 'OJHSM7KHFB', 'Sports', 70.11, '2024-07-12 16:12:14'),
(5, 'PUWV575JWW', 'Toys', 760.17, '2024-07-12 16:12:15'),
(6, 'XB9690DBOQ', 'Clothing', 490.6, '2024-07-12 16:12:16'),
(7, '4MII32YB6K', 'Toys', 425.56, '2024-07-12 16:12:17'),
(8, '192CY1TNO8', 'Electronics', 307.43, '2024-07-12 16:12:18'),
(9, '8GAO2HENQY', 'Clothing', 771.16, '2024-07-12 16:12:19'),
(10, 'I89S5WR7Y9', 'Toys', 506.91, '2024-07-12 16:12:20'),
(11, 'V9CUO94O5C', 'Beauty', 913.86, '2024-07-12 16:12:21'),
(12, 'BU3H0HUN6Y', 'Beauty', 411.19, '2024-07-12 16:12:22'),
(13, 'Y9RIHPMNIT', 'Sports', 56.16, '2024-07-12 16:12:23'),
(14, 'GNG6CMDGEY', 'Beauty', 260.67, '2024-07-12 16:12:24'),
(15, '1D5CS42HV4', 'Electronics', 966.47, '2024-07-12 16:12:25'),
(16, 'AV6O47LITD', 'Home', 80.53, '2024-07-12 16:12:26'),
(17, 'ERF2WZU8RA', 'Beauty', 516.85, '2024-07-12 16:12:27'),
(18, '5T82YSXZJU', 'Electronics', 774.04, '2024-07-12 16:12:28'),
(19, '3Z5JQO6AQK', 'Electronics', 530.02, '2024-07-12 16:12:29'),
(20, 'S8NDROLE4T', 'Electronics', 937.34, '2024-07-12 16:12:30'),
(21, '99EYZRJFE8', 'Beauty', 930.99, '2024-07-12 16:12:31'),
(22, '0GBHWBO6Q3', 'Sports', 471.17, '2024-07-12 16:12:32'),
(23, '95PP11H49B', 'Toys', 915.65, '2024-07-12 16:12:33'),
(24, 'OEQT9PCFSU', 'Home', 951.29, '2024-07-12 16:12:34'),
(25, 'AYCFON04NY', 'Sports', 312.35, '2024-07-12 16:12:35'),
(26, 'E15DBQBY0M', 'Toys', 154.58, '2024-07-12 16:12:36'),
(27, '8IVEEWWFZ7', 'Home', 424.34, '2024-07-12 16:12:37'),
(28, 'C6AWCVDGRL', 'Clothing', 548.96, '2024-07-12 16:12:38'),
(29, '00UKORKI6V', 'Beauty', 661.15, '2024-07-12 16:12:39'),
(30, 'KIUQVWU6G5', 'Toys', 18.93, '2024-07-12 16:12:40'),
(31, '7H3NV4KUBJ', 'Beauty', 308.75, '2024-07-12 16:12:41'),
(32, 'UG0YBZ54BK', 'Beauty', 78.06, '2024-07-12 16:12:42'),
(33, 'OLCMVU42DD', 'Sports', 20.21, '2024-07-12 16:12:43'),
(34, 'GARO3BGPZ6', 'Clothing', 714.58, '2024-07-12 16:12:44'),
(35, 'YLE7S4DVUT', 'Electronics', 171.01, '2024-07-12 16:12:45'),
(36, '4P4JU26GMF', 'Beauty', 886.81, '2024-07-12 16:12:46'),
(37, '2I6TK5D386', 'Electronics', 392.53, '2024-07-12 16:12:47'),
(38, '1MO9R62Z6R', 'Beauty', 256.26, '2024-07-12 16:12:48'),
(39, '5U3LZE1O3W', 'Toys', 502.14, '2024-07-12 16:12:49'),
(40, 'WFQSJW5H2G', 'Beauty', 774.48, '2024-07-12 16:12:50'),
(41, 'I7TB4YJ1FW', 'Beauty', 612.11, '2024-07-12 16:12:51'),
(42, 'S6AVIXVZR3', 'Clothing', 630.6, '2024-07-12 16:12:52'),
(43, '45VBD541Q3', 'Clothing', 824.91, '2024-07-12 16:12:53'),
(44, 'YLDGNG0VCO', 'Clothing', 521.17, '2024-07-12 16:12:54'),
(45, 'D9EKT5GOI1', 'Sports', 855.63, '2024-07-12 16:12:55'),
(46, 'RS5D134ORJ', 'Electronics', 857.94, '2024-07-12 16:12:56'),
(47, '544M7EJLJT', 'Toys', 385.77, '2024-07-12 16:12:57'),
(48, '9BE3ODO0SB', 'Toys', 181.33, '2024-07-12 16:12:58'),
(49, '7HXRO89N32', 'Sports', 568.44, '2024-07-12 16:12:59'),
(50, 'LBTG5RGHLF', 'Electronics', 66.59, '2024-07-12 16:13:00'),
(51, '5U4JEFPP2G', 'Toys', 7.02, '2024-07-12 16:13:01'),
(52, '2S4UHMDN3Y', 'Beauty', 610.15, '2024-07-12 16:13:02'),
(53, '8BY2XTVLDG', 'Electronics', 436.99, '2024-07-12 16:13:03'),
(54, 'YV8JUCB3G6', 'Toys', 867.59, '2024-07-12 16:13:04'),
(55, 'RG4G9AGMK4', 'Toys', 644.85, '2024-07-12 16:13:05'),
(56, '3RY0QC7AAT', 'Toys', 861.83, '2024-07-12 16:13:06'),
(57, 'OHOLVQLHT4', 'Beauty', 629.23, '2024-07-12 16:13:07'),
(58, '0WWWSF53SL', 'Clothing', 281.07, '2024-07-12 16:13:08'),
(59, 'TURUJJ6QQ1', 'Clothing', 158.26, '2024-07-12 16:13:09'),
(60, 'KHE5Z6IN0E', 'Sports', 341.93, '2024-07-12 16:13:10'),
(61, 'VFNB2XHA5E', 'Clothing', 903.9, '2024-07-12 16:13:11'),
(62, 'RST5PYTESY', 'Home', 171.35, '2024-07-12 16:13:12'),
(63, 'R0WFPARBU5', 'Sports', 96.05, '2024-07-12 16:13:13'),
(64, 'ZJJGO1X6JR', 'Beauty', 536.65, '2024-07-12 16:13:14'),
(65, 'BFKU5LI3PZ', 'Home', 928.32, '2024-07-12 16:13:15'),
(66, 'QM06N77C29', 'Toys', 712.63, '2024-07-12 16:13:16'),
(67, '1ZB2OK4ZGQ', 'Sports', 437.72, '2024-07-12 16:13:17'),
(68, 'HDEH17NSH6', 'Clothing', 727.38, '2024-07-12 16:13:18'),
(69, '0UESIL6CBL', 'Clothing', 219.54, '2024-07-12 16:13:19'),
(70, 'SOXE07QNJ1', 'Home', 15.45, '2024-07-12 16:13:20'),
(71, 'WC9N80GSPX', 'Sports', 675.7, '2024-07-12 16:13:21'),
(72, 'FZ5498HLQW', 'Clothing', 460.41, '2024-07-12 16:13:22'),
(73, 'FW4BIN83EU', 'Beauty', 742.6, '2024-07-12 16:13:23'),
(74, 'XMJBPOUVMK', 'Beauty', 515.13, '2024-07-12 16:13:24'),
(75, 'KUPLT6T4RH', 'Clothing', 717.3, '2024-07-12 16:13:25'),
(76, 'Q3SW43YUYD', 'Electronics', 893.32, '2024-07-12 16:13:26'),
(77, 'MJLO0SA7QR', 'Toys', 235.56, '2024-07-12 16:13:27'),
(78, 'CGLXQGWDXM', 'Home', 904.76, '2024-07-12 16:13:28'),
(79, 'SFBZB0GVXF', 'Toys', 123.27, '2024-07-12 16:13:29'),
(80, 'I8V38B383L', 'Home', 591.18, '2024-07-12 16:13:30'),
(81, 'B1VHSE03BT', 'Electronics', 642.62, '2024-07-12 16:13:31'),
(82, 'A043U34KRM', 'Beauty', 90.5, '2024-07-12 16:13:32'),
(83, '6XTAAA93YR', 'Beauty', 983.7, '2024-07-12 16:13:33'),
(84, '6JV6JUMSBM', 'Sports', 52.29, '2024-07-12 16:13:34'),
(85, '1BAQU29C9X', 'Electronics', 499.66, '2024-07-12 16:13:35'),
(86, '9UHR5J2D8X', 'Electronics', 312.0, '2024-07-12 16:13:36'),
(87, 'C4SVXVFESA', 'Clothing', 192.05, '2024-07-12 16:13:37'),
(88, 'K4NI2LC9H4', 'Clothing', 954.85, '2024-07-12 16:13:38'),
(89, 'YZN3EBMNT1', 'Toys', 905.6, '2024-07-12 16:13:39'),
(90, 'F6ZBX4ZJI7', 'Clothing', 351.02, '2024-07-12 16:13:40'),
(91, '92DZ11VRLB', 'Sports', 435.46, '2024-07-12 16:13:41'),
(92, 'L3YMW3VMCS', 'Home', 268.49, '2024-07-12 16:13:42'),
(93, 'S29ZOOYOU1', 'Beauty', 287.61, '2024-07-12 16:13:43'),
(94, 'GR9CXXCKGV', 'Electronics', 619.5, '2024-07-12 16:13:44'),
(95, 'M9TPSDMW62', 'Sports', 979.67, '2024-07-12 16:13:45'),
(96, 'SVADDBEUGX', 'Sports', 806.22, '2024-07-12 16:13:46'),
(97, 'V6ZDI1MYUA', 'Toys', 387.17, '2024-07-12 16:13:47'),
(98, 'TOTJAN0SU7', 'Beauty', 686.05, '2024-07-12 16:13:48'),
(99, 'N2LQBR1IA3', 'Clothing', 78.34, '2024-07-12 16:13:49'),
(100, 'A4QJHT8OGW', 'Home', 534.15, '2024-07-12 16:13:50'),
(101, 'XMUS0HP1EI', 'Beauty', 475.99, '2024-07-12 16:13:51'),
(102, 'XTB5LFK3AT', 'Electronics', 27.24, '2024-07-12 16:13:52'),
(103, 'OG8YTKXECO', 'Clothing', 705.12, '2024-07-12 16:13:53'),
(104, 'Y3Y6GAQEA7', 'Home', 677.86, '2024-07-12 16:13:54'),
(105, '6KKC9TU32S', 'Sports', 301.77, '2024-07-12 16:13:55'),
(106, 'FBO1IVJN1T', 'Home', 42.41, '2024-07-12 16:13:56'),
(107, 'U3U8MH75EB', 'Toys', 100.91, '2024-07-12 16:13:57'),
(108, '0QY6KHH3WV', 'Sports', 113.91, '2024-07-12 16:13:58'),
(109, '774D7Q1UK2', 'Sports', 624.53, '2024-07-12 16:13:59'),
(110, 'QVHKOIBBLL', 'Clothing', 787.5, '2024-07-12 16:14:00'),
(111, 'G5FPCU5A9W', 'Toys', 886.27, '2024-07-12 16:14:01'),
(112, 'N4WL7APLKP', 'Sports', 789.58, '2024-07-12 16:14:02'),
(113, 'W218LIQ3H8', 'Electronics', 988.05, '2024-07-12 16:14:03'),
(114, '6MES5H93ZZ', 'Toys', 149.66, '2024-07-12 16:14:04'),
(115, 'DXDF7VXVN8', 'Home', 859.81, '2024-07-12 16:14:05'),
(116, '7SB4CHN92Q', 'Toys', 883.68, '2024-07-12 16:14:06'),
(117, 'LU8VQC7E4J', 'Sports', 659.05, '2024-07-12 16:14:07'),
(118, '3CW0704GSV', 'Electronics', 854.05, '2024-07-12 16:14:08'),
(119, '4SR6FU77UG', 'Home', 896.08, '2024-07-12 16:14:09'),
(120, '9T2GI2M7M3', 'Clothing', 956.04, '2024-07-12 16:14:10'),
(121, 'HOPAZJJ2A1', 'Electronics', 43.67, '2024-07-12 16:14:11'),
(122, '93MQOH6FR0', 'Home', 11.79, '2024-07-12 16:14:12'),
(123, 'LF7S6D9F2L', 'Sports', 107.98, '2024-07-12 16:14:13'),
(124, '7ZJC7BOCSD', 'Home', 393.55, '2024-07-12 16:14:14'),
(125, 'GVZ82IX4M4', 'Clothing', 573.0, '2024-07-12 16:14:15'),
(126, 'V78RQO1EIS', 'Beauty', 61.26, '2024-07-12 16:14:16'),
(127, 'JA22HIDTX3', 'Beauty', 266.67, '2024-07-12 16:14:17'),
(128, '0J8ON9JDJS', 'Home', 119.55, '2024-07-12 16:14:18'),
(129, 'JJN7QIH1G6', 'Sports', 68.27, '2024-07-12 16:14:19'),
(130, '423PBC7AG7', 'Clothing', 381.21, '2024-07-12 16:14:20'),
(131, 'CJEKBU55CW', 'Sports', 198.12, '2024-07-12 16:14:21'),
(132, 'RLG7S4AIIV', 'Beauty', 787.98, '2024-07-12 16:14:22'),
(133, '03F9QSK40D', 'Sports', 779.76, '2024-07-12 16:14:23'),
(134, 'KMYAKLDG7U', 'Beauty', 609.25, '2024-07-12 16:14:24'),
(135, 'E0UM7QJM8U', 'Electronics', 122.24, '2024-07-12 16:14:25'),
(136, 'CFAU30ZJNT', 'Clothing', 710.33, '2024-07-12 16:14:26'),
(137, 'OJM8LCVJ9Y', 'Home', 315.4, '2024-07-12 16:14:27'),
(138, 'LSOQ097I44', 'Home', 770.66, '2024-07-12 16:14:28'),
(139, '0AJ6R0Y77C', 'Electronics', 361.85, '2024-07-12 16:14:29'),
(140, 'M4A5IOEK4I', 'Toys', 429.42, '2024-07-12 16:14:30'),
(141, 'PRIO1WPCCS', 'Clothing', 490.95, '2024-07-12 16:14:31'),
(142, 'TKEWPMV0MZ', 'Beauty', 202.53, '2024-07-12 16:14:32'),
(143, 'EBPGXKHMQD', 'Beauty', 832.87, '2024-07-12 16:14:33'),
(144, 'J5USSD5NWF', 'Toys', 753.84, '2024-07-12 16:14:34'),
(145, 'MLE2N9PGGK', 'Sports', 516.36, '2024-07-12 16:14:35'),
(146, '3HLE4FP930', 'Toys', 563.45, '2024-07-12 16:14:36'),
(147, 'A8B61KQFGO', 'Home', 656.99, '2024-07-12 16:14:37'),
(148, '3DSX5FRQOI', 'Electronics', 189.49, '2024-07-12 16:14:38'),
(149, 'QEM4XU2XK0', 'Electronics', 862.48, '2024-07-12 16:14:39'),
(150, '97ZOMGUPG4', 'Home', 228.43, '2024-07-12 16:14:40'),
(151, '0AHKK8J86Z', 'Home', 593.56, '2024-07-12 16:14:41'),
(152, 'OW8LVCDKTX', 'Beauty', 213.29, '2024-07-12 16:14:42'),
(153, 'I0MOOO4MZP', 'Sports', 861.33, '2024-07-12 16:14:43'),
(154, 'RE863E4VQ8', 'Electronics', 865.7, '2024-07-12 16:14:44'),
(155, 'FF6XVZ2CVS', 'Sports', 970.56, '2024-07-12 16:14:45'),
(156, 'POIPD3T8RK', 'Home', 830.76, '2024-07-12 16:14:46'),
(157, 'SGGKHR2W88', 'Toys', 793.63, '2024-07-12 16:14:47'),
(158, 'X0SM75KTQG', 'Home', 745.9, '2024-07-12 16:14:48'),
(159, 'LN08RE7NA0', 'Electronics', 631.68, '2024-07-12 16:14:49'),
(160, 'JUQS5X63E4', 'Toys', 684.71, '2024-07-12 16:14:50'),
(161, 'VPSNTSB9KU', 'Toys', 286.43, '2024-07-12 16:14:51'),
(162, 'XAIF73DAYD', 'Sports', 847.06, '2024-07-12 16:14:52'),
(163, 'UZY1PV6JEW', 'Home', 128.04, '2024-07-12 16:14:53'),
(164, '38A2QM9A44', 'Clothing', 897.87, '2024-07-12 16:14:54'),
(165, '80RSVFQD4M', 'Home', 191.28, '2024-07-12 16:14:55'),
(166, 'Z0JHM5TA1O', 'Electronics', 622.81, '2024-07-12 16:14:56'),
(167, '0HLBOSSQRJ', 'Electronics', 525.11, '2024-07-12 16:14:57'),
(168, 'A2EJS4WBA0', 'Home', 434.63, '2024-07-12 16:14:58'),
(169, 'NR8CF9AXUK', 'Sports', 853.2, '2024-07-12 16:14:59'),
(170, 'YOLWAGZAJ1', 'Sports', 773.12, '2024-07-12 16:15:00'),
(171, 'FVMODYQNVF', 'Sports', 652.54, '2024-07-12 16:15:01'),
(172, '4JD0QZ28ZV', 'Beauty', 780.46, '2024-07-12 16:15:02'),
(173, 'CIN3H4C9PA', 'Home', 606.93, '2024-07-12 16:15:03'),
(174, '8S5FELMLGA', 'Toys', 126.44, '2024-07-12 16:15:04'),
(175, 'W0L1LKXFA1', 'Home', 941.68, '2024-07-12 16:15:05'),
(176, '1DUMFXKOBR', 'Toys', 345.48, '2024-07-12 16:15:06'),
(177, 'LPMXP8726T', 'Sports', 946.08, '2024-07-12 16:15:07'),
(178, 'IS5O6NAJ7A', 'Sports', 311.86, '2024-07-12 16:15:08'),
(179, 'SI6WGPUOF2', 'Electronics', 963.8, '2024-07-12 16:15:09'),
(180, 'NVFGSPVVVY', 'Sports', 630.78, '2024-07-12 16:15:10'),
(181, '2OTBMVS56S', 'Clothing', 542.72, '2024-07-12 16:15:11'),
(182, 'IKRXZ74I0R', 'Home', 756.32, '2024-07-12 16:15:12'),
(183, '8H8BLJRNPP', 'Clothing', 141.63, '2024-07-12 16:15:13'),
(184, 'OV3S6Z4X28', 'Electronics', 959.04, '2024-07-12 16:15:14'),
(185, 'GRH17ZTCDU', 'Home', 128.97, '2024-07-12 16:15:15'),
(186, '57MM88RHZT', 'Electronics', 214.57, '2024-07-12 16:15:16'),
(187, 'U45YTQUQPI', 'Toys', 219.45, '2024-07-12 16:15:17'),
(188, '4O5G7UG7LC', 'Toys', 575.95, '2024-07-12 16:15:18'),
(189, 'GQK5UGHVNP', 'Electronics', 865.71, '2024-07-12 16:15:19'),
(190, 'ZEHV137XB8', 'Home', 804.31, '2024-07-12 16:15:20'),
(191, '6F62HETN0P', 'Clothing', 216.18, '2024-07-12 16:15:21'),
(192, 'KQIUGOZZQZ', 'Electronics', 956.57, '2024-07-12 16:15:22'),
(193, 'PD3IPOA3VH', 'Clothing', 81.29, '2024-07-12 16:15:23'),
(194, 'M7FOIO63S8', 'Home', 372.05, '2024-07-12 16:15:24'),
(195, 'M15884U39I', 'Beauty', 670.17, '2024-07-12 16:15:25'),
(196, 'RHWY582DLK', 'Toys', 992.39, '2024-07-12 16:15:26'),
(197, 'PGR0IEH1BD', 'Clothing', 577.62, '2024-07-12 16:15:27'),
(198, '2X8OK5L63Y', 'Electronics', 127.05, '2024-07-12 16:15:28'),
(199, '9S5DSH62AD', 'Sports', 278.21, '2024-07-12 16:15:29'),
(200, '55I490WTZY', 'Beauty', 561.18, '2024-07-12 16:15:30'),
(201, 'YSG8C52KM7', 'Home', 998.75, '2024-07-12 16:15:31'),
(202, 'P8EL1R9MIE', 'Home', 413.12, '2024-07-12 16:15:32'),
(203, 'ACJYIE2NHC', 'Clothing', 699.64, '2024-07-12 16:15:33'),
(204, 'FAP6GWSBMJ', 'Home', 690.18, '2024-07-12 16:15:34'),
(205, 'S64IQ2L5ES', 'Clothing', 994.11, '2024-07-12 16:15:35'),
(206, 'IU9MMVUJ4C', 'Sports', 242.12, '2024-07-12 16:15:36'),
(207, 'HUS4UT4W44', 'Beauty', 397.1, '2024-07-12 16:15:37'),
(208, 'VX8M0EXL1Y', 'Sports', 946.46, '2024-07-12 16:15:38'),
(209, 'WSAZC6PNOG', 'Beauty', 483.67, '2024-07-12 16:15:39'),
(210, 'ZLZTDQ5AQO', 'Electronics', 262.7, '2024-07-12 16:15:40'),
(211, 'XT82GWQQ7O', 'Clothing', 246.38, '2024-07-12 16:15:41'),
(212, 'VX6R6MJGNF', 'Sports', 736.15, '2024-07-12 16:15:42'),
(213, 'YEB0QE02QO', 'Clothing', 14.85, '2024-07-12 16:15:43'),
(214, 'A73UF8B2OE', 'Clothing', 648.74, '2024-07-12 16:15:44'),
(215, '8E3POR0F9R', 'Home', 150.95, '2024-07-12 16:15:45'),
(216, 'ORTEDZQRW9', 'Electronics', 442.89, '2024-07-12 16:15:46'),
(217, 'O857OWMIAH', 'Sports', 763.9, '2024-07-12 16:15:47'),
(218, '1CCXDBFRSI', 'Sports', 574.39, '2024-07-12 16:15:48'),
(219, 'SSTVLPFWQO', 'Toys', 153.74, '2024-07-12 16:15:49'),
(220, '7IX4QDC8TG', 'Home', 333.64, '2024-07-12 16:15:50'),
(221, '4L3CVB1KA7', 'Clothing', 116.43, '2024-07-12 16:15:51'),
(222, 'ZVP2CYA69Y', 'Sports', 467.6, '2024-07-12 16:15:52'),
(223, 'HQMWM3Y2KT', 'Sports', 242.39, '2024-07-12 16:15:53'),
(224, '7VIDBK7M1E', 'Clothing', 865.6, '2024-07-12 16:15:54'),
(225, '28J71QFNC8', 'Home', 634.03, '2024-07-12 16:15:55'),
(226, 'P9KXCC20PF', 'Clothing', 143.24, '2024-07-12 16:15:56'),
(227, 'HMV1AE6V8X', 'Home', 12.15, '2024-07-12 16:15:57'),
(228, 'LZK7FMFZB7', 'Sports', 312.25, '2024-07-12 16:15:58'),
(229, '27C69HMBFM', 'Home', 965.36, '2024-07-12 16:15:59'),
(230, 'RFCWK7BQPX', 'Clothing', 163.77, '2024-07-12 16:16:00'),
(231, 'QO8RZUBJSL', 'Electronics', 837.03, '2024-07-12 16:16:01'),
(232, 'FLG1CRKH6S', 'Sports', 347.79, '2024-07-12 16:16:02'),
(233, 'QRN7TZN440', 'Electronics', 769.32, '2024-07-12 16:16:03'),
(234, 'SES7JX4OXP', 'Sports', 838.37, '2024-07-12 16:16:04'),
(235, 'D8MROGBVIQ', 'Home', 325.64, '2024-07-12 16:16:05'),
(236, 'SCHA7MR3TS', 'Beauty', 623.5, '2024-07-12 16:16:06'),
(237, 'XRH1QFFPDY', 'Electronics', 539.28, '2024-07-12 16:16:07'),
(238, 'TOOM5LOERU', 'Sports', 724.03, '2024-07-12 16:16:08'),
(239, 'BOKEDA6TQU', 'Electronics', 112.52, '2024-07-12 16:16:09'),
(240, '905LZUWGGK', 'Home', 247.22, '2024-07-12 16:16:10'),
(241, '5B3Q4DFOW5', 'Toys', 271.37, '2024-07-12 16:16:11'),
(242, '0ILRLRZ2FZ', 'Electronics', 960.63, '2024-07-12 16:16:12'),
(243, '4X5KURKNOD', 'Sports', 444.03, '2024-07-12 16:16:13'),
(244, 'N6DM1XYOOB', 'Beauty', 978.84, '2024-07-12 16:16:14'),
(245, '89E779EHBP', 'Sports', 14.96, '2024-07-12 16:16:15'),
(246, 'GXR2Q9NOGI', 'Beauty', 615.09, '2024-07-12 16:16:16'),
(247, 'SNCF417PKG', 'Home', 274.95, '2024-07-12 16:16:17'),
(248, 'XVUWVDZDEG', 'Sports', 165.15, '2024-07-12 16:16:18'),
(249, '5DPJX9LEOR', 'Home', 825.32, '2024-07-12 16:16:19'),
(250, 'TNEO5NZO6J', 'Toys', 775.43, '2024-07-12 16:16:20');

select count(id) from product;

use assignment4;

select * from product;

commit;

select * from product;
truncate table product;

create database sql_query_150;

select 
id,
age,
case when age>=18 and age<=30 then '18-30'
    when age>=31 and age<=45 then '31-45'
    when age>=46 and age<=60 then '46-60'
    when age>61 then '61+'
    end as age_grp
from ci_call_2;