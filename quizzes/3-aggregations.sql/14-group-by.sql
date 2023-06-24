--Quiz: GROUP BY

--1. Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT a.name AS account_name, o.occurred_at AS day_of_order
FROM accounts a
JOIN orders o
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1; 

--2. Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT a.name AS company_name, SUM(o.total_amt_usd) AS total_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

--3. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

SELECT w.occurred_at AS date, w.channel, a.name AS account_name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

--4. Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

SELECT channel, COUNT (*)
FROM web_events
GROUP BY channel;

--5. Who was the primary contact associated with the earliest web_event?

SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

--6. What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT a.name, MIN(total_amt_usd) AS smallest_total_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_total_usd;

--7. Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT r.name AS region, COUNT(s.id) AS number_of_sale_rep
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY number_of_sale_rep;