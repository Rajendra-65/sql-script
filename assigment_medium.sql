create database assignment_medium;

use assignment_medium;

CREATE TABLE transaction (
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);

INSERT INTO transaction (user_id, spend, transaction_date)
VALUES 
(111, 100.50, '2022-01-08 12:00:00'),
(111, 55.00, '2022-01-10 12:00:00'),
(121, 36.00, '2022-01-18 12:00:00'),
(145, 24.99, '2022-01-26 12:00:00'),
(111, 89.60, '2022-02-05 12:00:00');

with transaction_window as (
	select *,
    rank() over(partition by user_id order by transaction_date) as ranked
    from transaction
)
select 
user_id,
spend,
transaction_date
from 
transaction_window
where ranked = 3;

CREATE TABLE activities (
    activity_id INT,
    user_id INT,
    activity_type VARCHAR(10), -- using VARCHAR with a size sufficient for 'send', 'open', 'chat'
    time_spent FLOAT,
    activity_date DATETIME
);

INSERT INTO activities (activity_id, user_id, activity_type, time_spent, activity_date)
VALUES 
(7274, 123, 'open', 4.50, '2022-06-22 12:00:00'),
(2425, 123, 'send', 3.50, '2022-06-22 12:00:00'),
(1413, 456, 'send', 5.67, '2022-06-23 12:00:00'),
(1414, 789, 'chat', 11.00, '2022-06-25 12:00:00'),
(2536, 456, 'open', 3.00, '2022-06-25 12:00:00');

CREATE TABLE age_breakdown (
    user_id INT,
    age_bucket VARCHAR(5) -- using VARCHAR with a size sufficient for age buckets like '21-25'
);

INSERT INTO age_breakdown (user_id, age_bucket)
VALUES 
(123, '31-35'),
(456, '26-30'),
(789, '21-25');

with snap_activities as (
	SELECT user_id,
    round((SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END)
    /
    (SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END)
    +
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END)) * 100.0),2) AS send_percentage,
    round((SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END)
    /
    (SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END)
    +
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END)) * 100.0),2) AS receive_percentage
	FROM activities
	GROUP BY user_id
)
select 
a.age_bucket,
sa.send_percentage,
sa.receive_percentage
from
age_breakdown a join snap_activities sa on sa.user_id = a.user_id
where sa.send_percentage is not null  and sa.receive_percentage is not null;

CREATE TABLE tweets (
    user_id INT,
    tweet_date DATETIME,
    tweet_count INT
);

INSERT INTO tweets (user_id, tweet_date, tweet_count)
VALUES 
(111, '2022-06-01 00:00:00', 2),
(111, '2022-06-02 00:00:00', 1),
(111, '2022-06-03 00:00:00', 3),
(111, '2022-06-04 00:00:00', 4),
(111, '2022-06-05 00:00:00', 5);

SELECT 
    t1.user_id,
    t1.tweet_date,
    ROUND(AVG(t1.tweet_count) OVER (
        PARTITION BY t1.user_id 
        ORDER BY t1.tweet_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_avg_3d
FROM tweets t1
ORDER BY t1.user_id, t1.tweet_date;

CREATE TABLE product_spend (
    category VARCHAR(50),
    product VARCHAR(50),
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);

INSERT INTO product_spend (category, product, user_id, spend, transaction_date)
VALUES 
('appliance', 'refrigerator', 165, 246.00, '2021-12-26 12:00:00'),
('appliance', 'refrigerator', 123, 299.99, '2022-03-02 12:00:00'),
('appliance', 'washing machine', 123, 219.80, '2022-03-02 12:00:00'),
('electronics', 'vacuum', 178, 152.00, '2022-04-05 12:00:00'),
('electronics', 'wireless headset', 156, 249.90, '2022-07-08 12:00:00'),
('electronics', 'vacuum', 145, 189.00, '2022-07-15 12:00:00');

select 
category,
product,
sum(spend) as total_spend
from product_spend
where transaction_date between '2022-01-01' and '2022-12-31'
group by category,product;

CREATE TABLE emails (
    email_id INT,
    user_id INT,
    signup_date DATETIME
);

INSERT INTO emails (email_id, user_id, signup_date)
VALUES 
(125, 7771, '2022-06-14 00:00:00'),
(236, 6950, '2022-07-01 00:00:00'),
(433, 1052, '2022-07-09 00:00:00');

CREATE TABLE texts (
    text_id INT,
    email_id INT,
    signup_action VARCHAR(50)
);

INSERT INTO texts (text_id, email_id, signup_action)
VALUES 
(6878, 125, 'Confirmed'),
(6920, 236, 'Not Confirmed'),
(6994, 236, 'Confirmed');

SELECT
ROUND(COUNT(texts.email_id)
/COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
ON emails.email_id = texts.email_id
AND texts.signup_action = 'Confirmed';

CREATE TABLE customer_contracts (
    customer_id INT,
    product_id INT,
    amount INT
);

INSERT INTO customer_contracts (customer_id, product_id, amount)
VALUES 
(1, 1, 1000),
(1, 7, 2000),
(1, 5, 1500),
(2, 2, 3000),
(2, 6, 2000);

CREATE TABLE products (
    product_id INT,
    product_category VARCHAR(50),
    product_name VARCHAR(100)
);

INSERT INTO products (product_id, product_category, product_name)
VALUES 
(1, 'Analytics', 'Azure Databricks'),
(2, 'Analytics', 'Azure Stream Analytics'),
(4, 'Containers', 'Azure Kubernetes Service'),
(5, 'Containers', 'Azure Service Fabric'),
(6, 'Compute', 'Virtual Machines'),
(7, 'Compute', 'Azure Functions');

SELECT customer_id
FROM (
SELECT customers.customer_id
FROM customer_contracts AS customers
LEFT JOIN products
ON customers.product_id = products.product_id
GROUP BY customers.customer_id
HAVING COUNT(DISTINCT products.product_category) = 3
) AS supercloud
ORDER BY customer_id;

CREATE TABLE user_transactions (
    product_id INT,
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);

INSERT INTO user_transactions (product_id, user_id, spend, transaction_date) VALUES
(3673, 123, 68.90, '2022-07-08 12:00:00'),
(9623, 123, 274.10, '2022-07-08 12:00:00'),
(1467, 115, 19.90, '2022-07-08 12:00:00'),
(2513, 159, 25.00, '2022-07-08 12:00:00');

select 
transaction_date,
user_id,
count(user_id)
from
user_transactions
group by transaction_date,user_id
order by transaction_date,user_id;

CREATE TABLE items_per_order (
    item_count INT,
    order_occurrences INT
);

INSERT INTO items_per_order (item_count, order_occurrences) VALUES
(1, 500),
(2, 1000),
(3, 800),
(4, 1000);

select
item_count as mode
from
items_per_order
where order_occurrences = (select max(order_occurrences) from items_per_order)
order by item_count;

CREATE TABLE monthly_cards_issued (
    issue_month INT,
    issue_year INT,
    card_name VARCHAR(100),
    issued_amount INT
);

INSERT INTO monthly_cards_issued (issue_month, issue_year, card_name, issued_amount) VALUES
(1, 2021, 'Chase Sapphire Reserve', 170000),
(2, 2021, 'Chase Sapphire Reserve', 175000),
(3, 2021, 'Chase Sapphire Reserve', 180000),
(3, 2021, 'Chase Freedom Flex', 65000),
(4, 2021, 'Chase Freedom Flex', 70000);

with card_rank as (
	select *,
    rank () over (partition by card_name order by issue_month) as ranked
    from monthly_cards_issued
)
select 
card_name,
issued_amount
from card_rank
where ranked = 1
order by issued_amount desc;

CREATE TABLE phone_calls (
    caller_id INT,
    receiver_id INT,
    call_time TIMESTAMP
);

INSERT INTO phone_calls (caller_id, receiver_id, call_time) VALUES
(1, 2, '2022-07-04 10:13:49'),
(1, 5, '2022-08-21 23:54:56'),
(5, 1, '2022-05-13 17:24:06'),
(5, 6, '2022-03-18 12:11:49');

CREATE TABLE phone_info (
    caller_id INT,
    country_id VARCHAR(10),
    network VARCHAR(50),
    phone_number VARCHAR(20)
);

INSERT INTO phone_info (caller_id, country_id, network, phone_number) VALUES
(1, 'US', 'Verizon', '+1-212-897-1964'),
(2, 'US', 'Verizon', '+1-703-346-9529'),
(3, 'US', 'Verizon', '+1-650-828-4774'),
(4, 'US', 'Verizon', '+1-415-224-6663'),
(5, 'IN', 'Vodafone', '+91 7503-907302'),
(6, 'IN', 'Vodafone', '+91 2287-664895');

WITH international_calls AS (
SELECT
caller.caller_id,
caller.country_id,
receiver.caller_id,
receiver.country_id
FROM phone_calls AS calls
LEFT JOIN phone_info AS caller
ON calls.caller_id = caller.caller_id
LEFT JOIN phone_info AS receiver
ON calls.receiver_id = receiver.caller_id
WHERE caller.country_id <> receiver.country_id
)
SELECT
ROUND(
100.0 * COUNT(*)
/ (SELECT COUNT(*) FROM phone_calls),1) AS international_call_pct
FROM international_calls;

