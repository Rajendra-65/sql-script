use assignment2;

CREATE TABLE World (
    name VARCHAR(50),
    continent VARCHAR(50),
    area INT,
    population INT,
    gdp BIGINT
);

INSERT INTO World (name, continent, area, population, gdp) VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000);

select * from World;

-- .....question 51(only show values when only population being checked...)....

select name,population,area
from World
where population >= 25000000 ;

-- Create the Customer table
CREATE TABLE Customer (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    referee_id INT
);

-- Insert values into the Customer table
INSERT INTO Customer (id, name, referee_id) VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2);

-- question 52

select name as name
from Customer
where referee_id !=2 or referee_id is null;

-- qeustion 53

-- Create the Customer table
CREATE TABLE Customer1 (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert values into the Customer table
INSERT INTO Customer1 (id, name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');

-- Create the Orders table
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customerId INT,
    FOREIGN KEY (customerId) REFERENCES Customer1(id)
);

-- Insert values into the Orders table
INSERT INTO Orders (id, customerId) VALUES
(1, 3),
(2, 1);

-- question 53 

select Customer1.name as Customers
from Customer1
where customer1.id not in (select customerId from Orders);

-- Create the Employee table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    team_id INT
);

-- Insert values into the Employee table
INSERT INTO Employee (employee_id, team_id) VALUES
(1, 8),
(2, 8),
(3, 8),
(4, 7),
(5, 9),
(6, 9);

-- question 54

SELECT e.employee_id,team_counts.team_size
FROM Employee e
JOIN (
    SELECT team_id, COUNT(*) AS team_size
    FROM Employee
    GROUP BY team_id
) AS team_counts
ON e.team_id = team_counts.team_id;

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

-- Create the Activity table
CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

-- Insert values into the Activity table
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

-- Create the Activity table
CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

-- Insert values into the Activity table
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-01', 0),
(3, 4, '2018-07-03', 5);
 

 
-- question 56

SELECT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN (
    SELECT player_id, MIN(event_date)
    FROM Activity
    GROUP BY player_id
);

-- Create the Orders table
CREATE TABLE Orders1 (
    order_number INT PRIMARY KEY,
    customer_number INT
);

-- Insert values into the Orders table
INSERT INTO Orders1 (order_number, customer_number) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 3);

-- question 57

select customer_number
from Orders1
where customer_number = (select customer_number
from orders1
group by customer_number
order by count(customer_number) desc
limit 1);

-- question 58

-- Create the Cinema table
CREATE TABLE Cinema (
    seat_id INT PRIMARY KEY,
    free BOOLEAN
);

-- Insert values into the Cinema table
INSERT INTO Cinema (seat_id, free) VALUES
(1, 1),
(2, 0),
(3, 1),
(4, 1),
(5, 1);

-- Create the SalesPerson table
CREATE TABLE SalesPerson (
    sales_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    commission_rate INT,
    hire_date DATE
);

-- Insert values into the SalesPerson table
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES
(1, 'John', 100000, 6, '2006-04-01'),
(2, 'Amy', 12000, 5, '2010-05-01'),
(3, 'Mark', 65000, 12, '2008-12-25'),
(4, 'Pam', 25000, 25, '2005-01-01'),
(5, 'Alex', 5000, 10, '2007-02-03');

-- Create the Company table
CREATE TABLE Company (
    com_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Insert values into the Company table
INSERT INTO Company (com_id, name, city) VALUES
(1, 'RED', 'Boston'),
(2, 'ORANGE', 'New York'),
(3, 'YELLOW', 'Boston'),
(4, 'GREEN', 'Austin');

-- Create the Orders table
CREATE TABLE Orders2 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    com_id INT,
    sales_id INT,
    amount INT
);

-- Insert values into the Orders table
INSERT INTO Orders2 (order_id, order_date, com_id, sales_id, amount) VALUES
(1, '2014-01-01', 3, 4, 10000),
(2, '2014-02-01', 4, 5, 5000),
(3, '2014-03-01', 1, 1, 50000),
(4, '2014-04-01', 1, 4, 25000);

-- question 59

select salesperson.name 
from salesperson
where sales_id not in (select sales_id 
from orders2 
where com_Id = (select com_id from company where name = "RED" ));

-- Create the Triangle table
CREATE TABLE Triangle (
    x INT,
    y INT,
    z INT
);
-- Insert values into the Triangle table
INSERT INTO Triangle (x, y, z) VALUES
(13, 15, 30),
(10, 20, 15);
-- question 60 
select x,y,z,
case
	when
		(x+y>z and x+z>y and y+z>x)
        then 'Yes'
        else 'No'
	end as can_form_triangle
from triangle;

-- question 63

-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    year INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Insert values into the Sales table
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 900);

-- Create the Mobile table
CREATE TABLE Mobile (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

-- Insert values into the Mobile table
INSERT INTO Mobile (product_id, product_name) VALUES
(100, 'Nokia'),
(200, 'Apple'),
(300, 'Samsung');

-- question 63

select mobile.product_name as productname,sales.year as year,sales.price
from mobile
join sales on sales.product_id = mobile.product_id;

-- question 64

-- Create the Project table
CREATE TABLE Project (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id)
);

-- Insert values into the Project table
INSERT INTO Project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);

-- Create the Employee table
CREATE TABLE projectEmployee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    experience_years INT
);

-- Insert values into the Employee table
INSERT INTO projectEmployee (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 1),
(4, 'Doe', 2);

-- question 64
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_experience
FROM 
    Project p
JOIN 
    projectEmployee e ON p.employee_id = e.employee_id
GROUP BY 
    p.project_id;

-- question 65

-- Create the Sales table
CREATE TABLE Saller (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Insert values into the Sales table
INSERT INTO Saller (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);
use assignment2;
-- question 66
select seller_id
from saller
where sum(price) = (select max(price) from saller);

-- Create the mobileProduct table
CREATE TABLE mobileProduct (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    unit_price INT
);

-- Insert values into the mobileProduct table
INSERT INTO mobileProduct (product_id, product_name, unit_price) VALUES
(1, 'S8', 1000),
(2, 'G4', 800),
(3, 'iPhone', 1400);

-- Create the mobileSales table with a foreign key reference to mobileProduct
CREATE TABLE mobileSales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES mobileProduct(product_id)
);

-- Insert values into the mobileSales table
INSERT INTO mobileSales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 1, 3, '2019-06-02', 1, 800),
(3, 3, 3, '2019-05-13', 2, 2800);

select distinct buyer_id
FROM mobileSales ms
JOIN mobileProduct mp ON ms.product_id = mp.product_id
WHERE mp.product_name = 'S8'
AND buyer_id NOT IN (
    SELECT buyer_id
    FROM mobileSales ms
    JOIN mobileProduct mp ON ms.product_id = mp.product_id
    WHERE mp.product_name = 'iPhone'
);

-- Create the Customer table
CREATE TABLE resturantCustomer (
    customer_id INT,
    name VARCHAR(50),
    visited_on DATE,
    amount DECIMAL(10, 2)
);
-- ques 67
-- Insert values into the Customer table
INSERT INTO resturantCustomer (customer_id, name, visited_on, amount) VALUES
(1, 'Jhon', '2019-01-01', 100),
(2, 'Daniel', '2019-01-02', 110),
(3, 'Jade', '2019-01-03', 120),
(4, 'Khaled', '2019-01-04', 130),
(5, 'Winston', '2019-01-05', 110),
(6, 'Elvis', '2019-01-06', 140),
(7, 'Anna', '2019-01-07', 150),
(8, 'Maria', '2019-01-08', 80),
(9, 'Jaze', '2019-01-09', 110),
(1, 'Jhon', '2019-01-10', 130),
(3, 'Jade', '2019-01-10', 150);

select * from resturantCustomer;

select
    visited_on,
    sum(amount) over (
        order by visited_on 
        rows between 6 preceding and current row 
    ) as amounts,
    round(avg(amount) over (
        order by visited_on 
        rows between 6 preceding and current row
    ), 2) as average_amount
from 
    resturantCustomer
order by 
    visited_on;

-- Create the Scores table
CREATE TABLE Scores (
    player_name VARCHAR(50),
    gender VARCHAR(1),
    day DATE,
    score_points INT
);

-- Insert values into the Scores table
INSERT INTO Scores (player_name, gender, day, score_points) VALUES
('Aron', 'F', '2020-01-01', 17),
('Alice', 'F', '2020-01-07', 23),
('Bajrang', 'M', '2020-01-07', 7),
('Khali', 'M', '2019-12-25', 11),
('Slaman', 'M', '2019-12-30', 13),
('Joe', 'M', '2019-12-31', 3),
('Jose', 'M', '2019-12-18', 2),
('Priya', 'F', '2019-12-31', 23),
('Priyanka', 'F', '2019-12-30', 17);

-- question 68

select gender,day,
sum(score_points) over(partition by gender order by day) as total from scores;

-- Create the Logs table
CREATE TABLE Logs (
    log_id INT PRIMARY KEY
);

-- Insert values into the Logs table
INSERT INTO Logs (log_id) VALUES
(1),
(2),
(3),
(7),
(8),
(10);

-- question 69
WITH LogWithRowNumber AS (
    SELECT 
        log_id, 
        log_id - ROW_NUMBER() OVER (ORDER BY log_id) AS grp
    FROM 
        Logs
),
GroupedLogs AS (
    SELECT 
        MIN(log_id) AS start_id, 
        MAX(log_id) AS end_id
    FROM 
        LogWithRowNumber
    GROUP BY 
        grp
)
SELECT 
    start_id, 
    end_id
FROM 
    GroupedLogs
ORDER BY 
    start_id;

-- Create the Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- Insert values into the Students table
INSERT INTO Students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex');
select * from students;
-- Create the Subjects table
CREATE TABLE Subjects (
    subject_name VARCHAR(50) PRIMARY KEY
);

-- Insert values into the Subjects table
INSERT INTO Subjects (subject_name) VALUES
('Math'),
('Physics'),
('Programming');

-- Create the Examinations table
CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_name) REFERENCES Subjects(subject_name)
);

-- Insert values into the Examinations table
INSERT INTO Examinations (student_id, subject_name) VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(13, 'Math'),
(13, 'Programming'),
(13, 'Physics'),
(2, 'Math'),
(1, 'Math');

-- First, create a Cartesian product of Students and Subjects
WITH StudentSubjects AS (
    SELECT 
        s.student_id, 
        s.student_name, 
        sub.subject_name
    FROM 
        Students s
    CROSS JOIN 
        Subjects sub
)

-- Then, left join this with Examinations and calculate the count
SELECT 
    ss.student_id,
    ss.student_name,
    ss.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM 
    StudentSubjects ss
LEFT JOIN 
    Examinations e 
    ON ss.student_id = e.student_id 
    AND ss.subject_name = e.subject_name
GROUP BY 
    ss.student_id, ss.student_name, ss.subject_name
ORDER BY 
    ss.student_id, ss.subject_name;

select * from Examinations;

-- Create the EmployeeBoss table
CREATE TABLE EmployeeBoss (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);

-- Insert values into the EmployeeBoss table
INSERT INTO EmployeeBoss (employee_id, employee_name, manager_id) VALUES
(1, 'Boss', 1),
(3, 'Alice', 3),
(2, 'Bob', 1),
(4, 'Daniel', 2),
(7, 'Luis', 4),
(8, 'Jhon', 3),
(9, 'Angela', 8),
(77, 'Robert', 1);

select 
employee_id as ids
from employeeBoss
where employee_id not in 
					(select manager_id from employeeBoss where employee_name ='Boss' 
							or (select employee_id from employeeBoss where employee_id = (select manager_id from employeeBoss where employee_name ='Boss')));
 
 -- Create the Transactions table
CREATE TABLE Transactions (
    id INT PRIMARY KEY,
    country VARCHAR(50),
    state VARCHAR(50),
    amount DECIMAL(10, 2),
    trans_date DATE
);

-- Insert values into the Transactions table
INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES
(121, 'US', 'approved', 1000, '2018-12-18'),
(122, 'US', 'declined', 2000, '2018-12-19'),
(123, 'US', 'approved', 2000, '2019-01-01'),
(124, 'DE', 'approved', 2000, '2019-01-07');

SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    month, country
ORDER BY 
    month, country;

select * from activity;

WITH FirstLogin AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
),
NextDayLogin AS (
    SELECT 
        DISTINCT fl.player_id
    FROM 
        FirstLogin fl
    JOIN 
        Activity a ON fl.player_id = a.player_id 
                   AND DATE_ADD(fl.first_login_date, INTERVAL 1 DAY) = a.event_date
)
SELECT 
    ROUND(COUNT(DISTINCT ndl.player_id) / COUNT(DISTINCT fl.player_id), 2) AS fraction
FROM 
    FirstLogin fl
LEFT JOIN 
    NextDayLogin ndl ON fl.player_id = ndl.player_id;

-- Create the Salaries table
CREATE TABLE Salaries (
    company_id INT,
    employee_id INT,
    employee_name VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert values into the Salaries table
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES
(1, 1, 'Tony', 2000),
(1, 2, 'Pronub', 21300),
(1, 3, 'Tyrrox', 10800),
(2, 1, 'Pam', 300),
(2, 7, 'Bassem', 450),
(2, 9, 'Hermione', 700),
(3, 7, 'Bocaben', 100),
(3, 2, 'Ognjen', 2200),
(3, 13, 'Nyan Cat', 3300),
(3, 15, 'Morning Cat', 7777);

select s.*,
max(salary) over(partition by company_id) as max_salary,
(case 
	when max_salary > 10000 then max_salary - salary *(49/100)
    when max_salary > 1000 and max_salary < 10000 then max_salary - salary *(24/100)
    else 
        salary
	end as salary) over (partition by company_id) as final_salary
from salaries s;

SELECT 
    e.left_operand,
    e.operator,
    e.right_operand,
    CASE 
        WHEN e.operator = '>' AND lv.value > rv.value THEN 'True'
        WHEN e.operator = '<' AND lv.value < rv.value THEN 'True'
        WHEN e.operator = '=' AND lv.value = rv.value THEN 'True'
        ELSE 'False'
    END AS result
FROM 
    Expressions e
JOIN 
    Variables lv ON e.left_operand = lv.name
JOIN 
    Variables rv ON e.right_operand = rv.name;

create table employeename(
	employee_id int,
    name varchar(25),
    month int,
    salary int
);

insert into employeename 
			values
            (12228,'Rose',15,1968),
            (33645,'Angela',1,3443),
            (45692,'Frank',17,1608),
            (56118,'Patrick',7,1345),
            (59725,'Lisa',11,2330),
            (74197,'Kimberly',16,4372),
            (78454,'Bonnie',8,1771),
            (83565,'Michel',6,2017),
            (98607,'Todd',5,3396),
            (99989,'Joe',9,3573);

select name
from employeename
order by name;

CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_type VARCHAR(50),
    item_category VARCHAR(50),
    square_footage DECIMAL(10, 2)
);

INSERT INTO inventory (item_id, item_type, item_category, square_footage) VALUES
(1374, 'prime_eligible', 'mini refrigerator', 68.00),
(4245, 'not_prime', 'standing lamp', 26.40),
(2452, 'prime_eligible', 'television', 85.00),
(3255, 'not_prime', 'side table', 22.60),
(1672, 'prime_eligible', 'laptop', 8.50);

WITH summary AS (
    SELECT 
        item_type,
        SUM(square_footage) AS total_square_footage,
        COUNT(*) AS item_count
    FROM 
        inventory
    GROUP BY 
        item_type
)
SELECT 
    item_type,
    FLOOR(500000 / total_square_footage) AS num_items_to_stock
FROM 
    summary;

CREATE TABLE merchant_transaction (
    transaction_id INT PRIMARY KEY,
    merchant_id INT,
    credit_card_id INT,
    amount DECIMAL(10, 2),
    transaction_timestamp TIMESTAMP
);

INSERT INTO merchant_transaction (transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp) VALUES
(1, 101, 1, 100.00, '2022-09-25 12:00:00'),
(2, 101, 1, 100.00, '2022-09-25 12:08:00'),
(3, 101, 1, 100.00, '2022-09-25 12:28:00'),
(4, 102, 2, 300.00, '2022-09-25 12:00:00'),
(6, 102, 2, 400.00, '2022-09-25 14:00:00');


with transaction_windows as (
	select
    transaction_id,
    merchant_id,
    credit_card_id,
    amount,
    transaction_timestamp,
    lag(transaction_timestamp)
				over(partition by merchant_id,credit_card_id,amount) as previous_transaction_timestamp
	from
		merchant_transaction
),
repeated_transactions as (
	select
    transaction_id,
    merchant_id,
    credit_card_id,
    amount,
    transaction_timestamp,
    previous_transaction_timestamp
	from
		transaction_windows
	where 
		previous_transaction_timestamp is not null
        and 
        transaction_timestamp <= previous_transaction_timestamp +  interval '10' minute
)

select count(*)
as repeted_payments
from repeated_transactions;

-- Create customers table
CREATE TABLE order_customers (
    customer_id INTEGER PRIMARY KEY,
    signup_timestamp TIMESTAMP
);

-- Insert sample data into customers table
INSERT INTO order_customers (customer_id, signup_timestamp) VALUES
(8472, '2022-05-30 00:00:00'),
(2341, '2022-06-01 00:00:00'),
(1314, '2022-06-03 00:00:00'),
(1435, '2022-06-05 00:00:00'),
(5421, '2022-06-07 00:00:00');

-- Create orders table
CREATE TABLE bad_orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    trip_id INTEGER,
    status VARCHAR(50),
    order_timestamp TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES order_customers(customer_id)
);

-- Insert sample data into orders table
INSERT INTO bad_orders (order_id, customer_id, trip_id, status, order_timestamp) VALUES
(727424, 8472, 100463, 'completed successfully', '2022-06-05 09:12:00'),
(242513, 2341, 100482, 'completed incorrectly', '2022-06-05 14:40:00'),
(141367, 1314, 100362, 'completed incorrectly', '2022-06-07 15:03:00'),
(582193, 5421, 100657, 'never_received', '2022-07-07 15:22:00'),
(253613, 1314, 100213, 'completed successfully', '2022-06-12 13:43:00');

-- Create trips table
CREATE TABLE trips (
    dasher_id INTEGER,
    trip_id INTEGER PRIMARY KEY,
    estimated_delivery_timestamp TIMESTAMP,
    actual_delivery_timestamp TIMESTAMP
);

-- Insert sample data into trips table
INSERT INTO trips (dasher_id, trip_id, estimated_delivery_timestamp, actual_delivery_timestamp) VALUES
(101, 100463, '2022-06-05 09:42:00', '2022-06-05 09:38:00'),
(102, 100482, '2022-06-05 15:10:00', '2022-06-05 15:46:00'),
(101, 100362, '2022-06-07 15:33:00', '2022-06-07 16:45:00'),
(102, 100657, '2022-07-07 15:52:00', NULL),
(103, 100213, '2022-06-12 14:13:00', '2022-06-12 14:10:00');

WITH new_users AS (
    SELECT customer_id, signup_timestamp
    FROM order_customers
    WHERE signup_timestamp BETWEEN '2022-06-01 00:00:00' AND '2022-06-30 23:59:59'
),
user_orders AS (
    SELECT o.order_id, o.customer_id, o.trip_id, o.status, o.order_timestamp
    FROM bad_orders o
    JOIN new_users nu ON o.customer_id = nu.customer_id
    WHERE o.order_timestamp <= nu.signup_timestamp + INTERVAL '14' DAY
),
late_orders AS (
    SELECT t.trip_id
    FROM trips t
    WHERE t.actual_delivery_timestamp > t.estimated_delivery_timestamp + INTERVAL '30' MINUTE
),
bad_experience_orders AS (
    SELECT 
        uo.order_id
    FROM 
        bad_orders uo
    LEFT JOIN late_orders lo ON uo.trip_id = lo.trip_id
    WHERE 
        uo.status IN ('completed incorrectly', 'never_received')
        OR lo.trip_id IS NOT NULL
)
SELECT 
    ROUND(COUNT(beo.order_id) * 100.0 / COUNT(uo.order_id), 2) AS bad_experience_rate
FROM 
    bad_orders uo
LEFT JOIN 
    bad_experience_orders beo ON uo.order_id = beo.order_id;

-- Create the Salary table
CREATE TABLE Salary (
    id INT PRIMARY KEY,
    employee_id INT,
    amount INT,
    pay_date DATE
);

-- Insert sample data into the Salary table
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES
(1, 1, 9000, '2017-03-31'),
(2, 2, 6000, '2017-03-31'),
(3, 3, 10000, '2017-03-31'),
(4, 1, 7000, '2017-02-28'),
(5, 2, 6000, '2017-02-28'),
(6, 3, 8000, '2017-02-28');

-- Create the Employee table
CREATE TABLE Employee2 (
    employee_id INT PRIMARY KEY,
    department_id INT
);

-- Insert sample data into the Employee table
INSERT INTO Employee2 (employee_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 2);


WITH MonthlySalaries AS (
    SELECT 
        Employee2.employee_id,
        department_id,
        DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
        amount
    FROM 
        Salary
    JOIN 
        Employee2 ON Salary.employee_id = Employee2.employee_id
),
CompanyAverage AS (
    SELECT 
        pay_month,
        AVG(amount) AS company_avg_salary
    FROM 
        MonthlySalaries
    GROUP BY 
        pay_month
),
DepartmentAverage AS (
    SELECT 
        pay_month,
        department_id,
        AVG(amount) AS dept_avg_salary
    FROM 
        MonthlySalaries
    GROUP BY 
        pay_month, department_id
)
SELECT 
    da.pay_month,
    da.department_id,
    CASE 
        WHEN da.dept_avg_salary > ca.company_avg_salary THEN 'higher'
        WHEN da.dept_avg_salary < ca.company_avg_salary THEN 'lower'
        ELSE 'same'
    END AS comparison
FROM 
    DepartmentAverage da
JOIN 
    CompanyAverage ca ON da.pay_month = ca.pay_month
ORDER BY 
    da.pay_month, da.department_id;

WITH InstallDates AS (
    SELECT 
        player_id,
        MIN(event_date) AS install_dt
    FROM 
        Activity
    GROUP BY 
        player_id
),
DayOneRetention AS (
    SELECT 
        i.install_dt,
        COUNT(*) AS installs,
        COUNT(DISTINCT a.player_id) AS day1_retention_count
    FROM 
        InstallDates i
    LEFT JOIN 
        Activity a
    ON 
        i.player_id = a.player_id 
        AND a.event_date = DATE_ADD(i.install_dt, INTERVAL 1 DAY)
    GROUP BY 
        i.install_dt
)
SELECT 
    install_dt,
    installs,
    ROUND(day1_retention_count * 1.0 / installs, 2) AS Day1_retention
FROM 
    DayOneRetention;

-- Create Players table
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    group_id INT
);

-- Insert sample data into Players table
INSERT INTO Players (player_id, group_id) VALUES
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);

-- Create Matches table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT,
    FOREIGN KEY (first_player) REFERENCES Players(player_id),
    FOREIGN KEY (second_player) REFERENCES Players(player_id)
);

-- Insert sample data into Matches table
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);

WITH Points AS (
    SELECT
        p.player_id,
        p.group_id,
        COALESCE(SUM(m1.first_score), 0) + COALESCE(SUM(m2.second_score), 0) AS total_points
    FROM
        Players p
    LEFT JOIN
        Matches m1 ON p.player_id = m1.first_player
    LEFT JOIN
        Matches m2 ON p.player_id = m2.second_player
    GROUP BY
        p.player_id, p.group_id
),
RankedPoints AS (
    SELECT
        group_id,
        player_id,
        total_points,
        RANK() OVER (PARTITION BY group_id ORDER BY total_points DESC, player_id ASC) AS ranked
    FROM
        Points
)
SELECT
    group_id,
    player_id
FROM
    RankedPoints
WHERE
    ranked = 1;
