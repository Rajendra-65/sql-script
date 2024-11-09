create database assignment_easy;

use assignment_easy;

-- Create pages table
CREATE TABLE pages (
    page_id INTEGER PRIMARY KEY,
    page_name VARCHAR(255)
);

-- Create page_likes table
CREATE TABLE page_likes (
    user_id INTEGER,
    page_id INTEGER,
    liked_date DATETIME,
    FOREIGN KEY (page_id) REFERENCES pages(page_id)
);

-- Insert example data into pages table
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

-- Insert example data into page_likes table
INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
(111, 20001, '2022-04-08 00:00:00'),
(121, 20045, '2022-03-12 00:00:00'),
(156, 20001, '2022-07-25 00:00:00');

-- question 1

select page_id,page_name 
from pages
where page_id not in (select page_id from page_likes);

-- Create parts_assembly table
CREATE TABLE parts_assembly (
    part VARCHAR(255),
    finish_date DATETIME,
    assembly_step INTEGER
);

-- Insert example data into parts_assembly table
INSERT INTO parts_assembly (part, finish_date, assembly_step) VALUES
('battery', '2022-01-22 00:00:00', 1),
('battery', '2022-02-22 00:00:00', 2),
('battery', '2022-03-22 00:00:00', 3),
('bumper', '2022-01-22 00:00:00', 1),
('bumper', '2022-02-22 00:00:00', 2),
('bumper', NULL, 3),
('bumper', NULL, 4);

-- question 2

select part,assembly_step 
from parts_assembly
where finish_date is null;

-- Create tweets table
CREATE TABLE tweets (
    tweet_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    msg TEXT,
    tweet_date DATETIME
);

-- Insert example data into tweets table
INSERT INTO tweets (tweet_id, user_id, msg, tweet_date) VALUES
(214252, 111, 'Am considering taking Tesla private at $420. Funding secured.', '2021-12-30 00:00:00'),
(739252, 111, 'Despite the constant negative press covfefe', '2022-01-01 00:00:00'),
(846402, 111, 'Following @NickSinghTech on Twitter changed my life!', '2022-02-14 00:00:00'),
(241425, 254, 'If the salary is so competitive why won’t you tell me what it is?', '2022-03-01 00:00:00'),
(231574, 148, 'I no longer have a manager. I can''t be managed', '2022-03-23 00:00:00');

-- question 3 

select tweet_count_per_user as tweet_bucket,
count(user_id) as user_num
from(
select
user_id , count(tweet_id) as tweet_count_per_user
from tweets
where tweet_date between '2022-01-01' and '2022-12-31'
group by user_id
order by user_id)
as total_tweets
group by tweet_count_per_user
;

-- Create viewership table
CREATE TABLE viewership (
    user_id INTEGER,
    device_type VARCHAR(10) CHECK (device_type IN ('laptop', 'tablet', 'phone')),
    view_time TIMESTAMP
);

-- Insert example data into viewership table
INSERT INTO viewership (user_id, device_type, view_time) VALUES
(123, 'tablet', '2022-01-02 00:00:00'),
(125, 'laptop', '2022-01-07 00:00:00'),
(128, 'laptop', '2022-02-09 00:00:00'),
(129, 'phone', '2022-02-09 00:00:00'),
(145, 'tablet', '2022-02-24 00:00:00');

-- question 4

select
	  sum(case when device_type = 'laptop' then 1 else 0 end) as
      laptop_views,
      sum(case when device_type in ('laptop','phone') then 1 else 0 end) as mobile_views
      from viewership;

-- Create candidates table
CREATE TABLE candidates (
    candidate_id INTEGER,
    skill VARCHAR(255)
);

-- Insert example data into candidates table
INSERT INTO candidates (candidate_id, skill) VALUES
(123, 'Python'),
(123, 'Tableau'),
(123, 'PostgreSQL'),
(234, 'R'),
(234, 'PowerBI'),
(234, 'SQL Server'),
(345, 'Python'),
(345, 'Tableau');

-- question 5

select 
candidate_id,
count(skill) as skill_count
from candidates 
where skill in ('Python','Tableau','PostgreSQL')
group by candidate_id
having count(skill) = 3
order by candidate_id;

-- Create posts table
CREATE TABLE posts (
    user_id INTEGER,
    post_id INTEGER PRIMARY KEY,
    post_date DATETIME,
    post_content TEXT
);

-- Insert example data into posts table
INSERT INTO posts (user_id, post_id, post_date, post_content) VALUES
(151652, 599415, '2021-07-10 12:00:00', 'Need a hug'),
(661093, 624356, '2021-07-29 13:00:00', 'Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that''s gonna fly by. I miss my girlfriend'),
(004239, 784254, '2021-07-04 11:00:00', 'Happy 4th of July!'),
(661093, 442560, '2021-07-08 14:00:00', 'Just going to cry myself to sleep after watching Marley and Me.'),
(151652, 111766, '2021-07-12 19:00:00', 'I''m so done with covid - need travelling ASAP!');

-- question 6

SELECT
    user_id,
    DATE_PART('day', MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE DATE_PART('year', post_date) = 2021
GROUP BY user_id
HAVING COUNT(post_id) > 1;

-- Create messages table
CREATE TABLE messages (
    message_id INTEGER PRIMARY KEY,
    sender_id INTEGER,
    receiver_id INTEGER,
    content TEXT,
    sent_date DATETIME
);

-- Insert example data into messages table
INSERT INTO messages (message_id, sender_id, receiver_id, content, sent_date) VALUES
(901, 3601, 4500, 'You up?', '2022-08-03 00:00:00'),
(902, 4500, 3601, 'Only if you''re buying', '2022-08-03 00:00:00'),
(743, 3601, 8752, 'Let''s take this offline', '2022-06-14 00:00:00'),
(922, 3601, 4500, 'Get on the call', '2022-08-10 00:00:00');

-- question 7

select 
sender_id,
count(sender_id) as message_count
from messages
where sent_date >= '2022-08-01' and sent_date <='2022-08-31'
group by sender_id
order by sender_id;

-- Create job_listings table
CREATE TABLE job_listings (
    job_id INTEGER PRIMARY KEY,
    company_id INTEGER,
    title VARCHAR(255),
    description TEXT
);

-- Insert example data into job_listings table
INSERT INTO job_listings (job_id, company_id, title, description) VALUES
(248, 827, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
(149, 845, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
(945, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
(164, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
(172, 244, 'Data Engineer', 'Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.');

WITH jobs_grouped AS (
SELECT
company_id,
title,
description,
COUNT(job_id) AS job_count
FROM job_listings
GROUP BY
company_id,
title,
description)
SELECT COUNT(DISTINCT company_id) AS co_w_duplicate_jobs
FROM jobs_grouped
WHERE job_count > 1;

-- Create users table
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    city VARCHAR(100),
    email VARCHAR(255),
    signup_date DATETIME
);

-- Insert example data into users table
INSERT INTO users (user_id, city, email, signup_date) VALUES
(111, 'San Francisco', 'rrok10@gmail.com', '2021-08-03 12:00:00'),
(148, 'Boston', 'sailor9820@gmail.com', '2021-08-20 12:00:00'),
(178, 'San Francisco', 'harrypotterfan182@gmail.com', '2022-01-05 12:00:00'),
(265, 'Denver', 'shadower_@hotmail.com', '2022-02-26 12:00:00'),
(300, 'San Francisco', 'houstoncowboy1122@hotmail.com', '2022-06-30 12:00:00');

-- Create trades table
CREATE TABLE trades (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    price DECIMAL(10, 2),
    quantity INTEGER,
    status VARCHAR(50),
    timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert example data into trades table
INSERT INTO trades (order_id, user_id, price, quantity, status, timestamp) VALUES
(100101, 111, 9.80, 10, 'Cancelled', '2022-08-17 12:00:00'),
(100102, 111, 10.00, 10, 'Completed', '2022-08-17 12:00:00'),
(100259, 148, 5.10, 35, 'Completed', '2022-08-25 12:00:00'),
(100264, 148, 4.80, 40, 'Completed', '2022-08-26 12:00:00'),
(100305, 300, 10.00, 15, 'Completed', '2022-09-05 12:00:00'),
(100400, 178, 9.90, 15, 'Completed', '2022-09-09 12:00:00'),
(100565, 265, 25.60, 5, 'Completed', '2022-12-19 12:00:00');

select 
t.user_id,
u.city,
count(t.order_id) as total_orders
from trades t join users u on t.user_id  = u.user_id
where status = 'Completed'
group by user_id
order by total_orders desc
limit 3;

-- Create reviews table
CREATE TABLE reviews (
    review_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    submit_date DATETIME,
    product_id INTEGER,
    stars INTEGER CHECK (stars BETWEEN 1 AND 5)
);

-- Insert example data into reviews table
INSERT INTO reviews (review_id, user_id, submit_date, product_id, stars) VALUES
(6171, 123, '2022-06-08 00:00:00', 50001, 4),
(7802, 265, '2022-06-10 00:00:00', 69852, 4),
(5293, 362, '2022-06-18 00:00:00', 50001, 3),
(6352, 192, '2022-07-26 00:00:00', 69852, 3),
(4517, 981, '2022-07-05 00:00:00', 69852, 2);

-- question 10

select
extract(month from submit_date) as mth,
product_id,
round(avg(stars),2) as avg_stars
from reviews
group by extract(month from submit_date),product_id
order by mth;

-- question 11

-- Create events table
CREATE TABLE events (
    app_id INTEGER,
    event_type VARCHAR(50),
    timestamp DATETIME
);

-- Insert example data into events table
INSERT INTO events (app_id, event_type, timestamp) VALUES
(123, 'impression', '2022-07-18 11:36:12'),
(123, 'impression', '2022-07-18 11:37:12'),
(123, 'click', '2022-07-18 11:37:42'),
(234, 'impression', '2022-07-18 14:15:12'),
(234, 'click', '2022-07-18 14:16:12');

select
app_id,
round(100 * 
			sum(case when event_type = 'click' then 1 else 0 end) 
            /
            sum(case when event_type = 'impression' then 1 else 0 end)
	,2) as ctr
from events
where timestamp >= '2022-01-01' and timestamp <='2023-01-01'
group by app_id;

-- Create texts table
CREATE TABLE texts (
    text_id INTEGER PRIMARY KEY,
    email_id INTEGER,
    signup_action VARCHAR(50),
    action_date DATETIME
);

-- Insert example data into texts table
INSERT INTO texts (text_id, email_id, signup_action, action_date) VALUES
(6878, 125, 'Confirmed', '2022-06-14 00:00:00'),
(6997, 433, 'Not Confirmed', '2022-07-09 00:00:00'),
(7000, 433, 'Confirmed', '2022-07-10 00:00:00');

-- Create emails table
CREATE TABLE emails (
    email_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    signup_date DATETIME
);

-- Insert example data into emails table
INSERT INTO emails (email_id, user_id, signup_date) VALUES
(125, 7771, '2022-06-14 00:00:00'),
(433, 1052, '2022-07-09 00:00:00');
-- question 12
SELECT DISTINCT emails.user_id
FROM emails
INNER JOIN texts
ON emails.email_id = texts.email_id
WHERE texts.action_date = DATE_ADD(emails.signup_date, INTERVAL 1 DAY)
AND texts.signup_action = 'Confirmed';

-- question 13

-- Create monthly_cards_issued table
CREATE TABLE monthly_cards_issued (
    card_name VARCHAR(255),
    issued_amount INTEGER,
    issue_month INTEGER,
    issue_year INTEGER
);

-- Insert example data into monthly_cards_issued table
INSERT INTO monthly_cards_issued (card_name, issued_amount, issue_month, issue_year) VALUES
('Chase Freedom Flex', 55000, 1, 2021),
('Chase Freedom Flex', 60000, 2, 2021),
('Chase Freedom Flex', 65000, 3, 2021),
('Chase Freedom Flex', 70000, 4, 2021),
('Chase Sapphire Reserve', 170000, 1, 2021),
('Chase Sapphire Reserve', 175000, 2, 2021),
('Chase Sapphire Reserve', 180000, 3, 2021);

select 
card_name,
(max(issued_amount)-min(issued_amount)) as difference
from monthly_cards_issued
group by card_name;

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    units_sold INTEGER,
    total_sales DECIMAL(10, 2),
    cogs DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    drug VARCHAR(255)
);

INSERT INTO products (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
(9, 37410, 293452.54, 208876.01, 'Eli Lilly', 'Zyprexa'),
(34, 94698, 600997.19, 521182.16, 'AstraZeneca', 'Surmontil'),
(61, 77023, 500101.61, 419174.97, 'Biogen', 'Varicose Relief'),
(136, 144814, 1084258.00, 1006447.73, 'Biogen', 'Burkhar');

select 
drug,
(total_sales-cogs) AS total_profit
from products;

-- Create pharmacy_sales table
CREATE TABLE pharmacy_sales (
    product_id INTEGER PRIMARY KEY,
    units_sold INTEGER,
    total_sales DECIMAL(15, 2),
    cogs DECIMAL(15, 2),
    manufacturer VARCHAR(255),
    drug VARCHAR(255)
);

-- Insert example data into pharmacy_sales table
INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
(156, 89514, 3130097.00, 3427421.73, 'Biogen', 'Acyclovir'),
(25, 222331, 2753546.00, 2974975.36, 'AbbVie', 'Lamivudine and Zidovudine'),
(50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb TA Complete Kit'),
(98, 110746, 813188.82, 140422.87, 'Biogen', 'Medi-Chord');

select 
manufacturer,
count(product_id) as drug_count,
sum(cogs-total_sales) as total_loss
from pharmacy_sales
where cogs > total_sales
group by manufacturer
order by total_loss desc;

-- Create pharmacy_sales1 table
CREATE TABLE pharmacy_sales1 (
    product_id INTEGER PRIMARY KEY,
    units_sold INTEGER,
    total_sales DECIMAL(15, 2),
    cogs DECIMAL(15, 2),
    manufacturer VARCHAR(255),
    drug VARCHAR(255)
);

-- Insert example data into pharmacy_sales1 table
INSERT INTO pharmacy_sales1 (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
(94, 132362, 2041758.41, 1373721.70, 'Biogen', 'UP and UP'),
(9, 37410, 293452.54, 208876.01, 'Eli Lilly', 'Zyprexa'),
(50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb'),
(61, 77023, 500101.61, 419174.97, 'Biogen', 'Varicose Relief'),
(136, 144814, 1084258.00, 1006447.73, 'Biogen', 'Burkhart');

select
manufacturer,
concat('$',round(sum(total_sales)/1000000,'million')) as total_sale
from pharmacy_sales
group by manufacturer;

-- Create callers table
CREATE TABLE callers (
    policy_holder_id VARCHAR(255),
    case_id VARCHAR(255),
    call_category VARCHAR(255),
    call_received DATETIME,
    call_duration_secs INTEGER,
    original_order INTEGER
);

-- Insert example data into callers table
INSERT INTO callers (policy_holder_id, case_id, call_category, call_received, call_duration_secs, original_order) VALUES
('50837000', 'dc63-acae-4f39-bb04', 'claims', '2022-03-09 02:51:00', 205, 130),
('50837000', '41be-bebe-4bd0-a1ba', 'IT_support', '2022-03-12 05:37:00', 254, 129),
('50936674', '12c8-b35c-48a3-b38d', 'claims', '2022-05-31 07:27:00', 240, 31),
('50886837', 'd0b4-8ea7-4b8c-aa8b', 'IT_support', '2022-03-11 03:38:00', 276, 16),
('50886837', 'a741-c279-41c0-90ba', NULL, '2022-03-19 10:52:00', 131, 325),
('50837000', 'bab1-3ec5-4867-90ae', 'benefits', '2022-05-13 18:19:00', 228, 339);

select count(policy_holder_id) as member_count
from(
SELECT
policy_holder_id,
COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
having call_count >=3
)as call_records;

-- Create callers table
CREATE TABLE callers1 (
    policy_holder_id VARCHAR(255),
    case_id VARCHAR(255),
    call_category VARCHAR(255),
    call_received DATETIME,
    call_duration_secs INTEGER,
    original_order INTEGER
);

-- Insert example data into callers table
INSERT INTO callers1 (policy_holder_id, case_id, call_category, call_received, call_duration_secs, original_order) VALUES
('52481621', 'a94c-2213-4ba5-812d', NULL, '2022-01-17 19:37:00', 286, 161),
('51435044', 'f0b5-0eb0-4c49-b21e', NULL, '2022-01-18 02:46:00', 208, 225),
('52082925', '289b-d7e8-4527-bdf5', 'benefits', '2022-01-18 03:01:00', 291, 352),
('54624612', '62c2-d9a3-44d2-9065', 'IT_support', '2022-01-19 00:27:00', 273, 358),
('54624612', '9f57-164b-4a36-934e', 'claims', '2022-01-19 06:33:00', 157, 362);

SELECT
ROUND(100.0 *
COUNT(case_id)/
(SELECT COUNT(*) FROM callers),1) AS uncategorised_call_pct
FROM callers1
WHERE call_category IS NULL
OR call_category = 'n/a';