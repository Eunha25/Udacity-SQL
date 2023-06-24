--Quiz: JOIN Questions Part I

--1. Provide a table for all web_events associated with account name of Walmart. There should be three columns. 
-- Be sure to include the primary_poc, time of the event, and the channel for each event. 
-- Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w 
JOIN accounts a 
ON a.id = w.account_id
AND a.name = ('Walmart');

--2. Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.
SELECT a.name AS account_name, r.name AS region_name, s.name AS sales_rep_name
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
JOIN accounts a  
ON s.id = a.sales_rep_id 
ORDER BY account_name;

-- Note: implicit JOINs
SELECT a.name AS account_name, r.name AS region_name, s.name AS sales_rep_name
FROM sales_reps s, accounts a, region r 
WHERE s.id = a.sales_rep_id AND r.id = s.region_id
ORDER BY account_name;

--3. Provide the name for each region for every order, 
-- as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
-- Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, 
-- so I divided by (total + 0.01) to assure not dividing by zero.
SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd / (o.total + 0.01) AS unit_price 
FROM accounts a
JOIN orders o 
ON a.id = o.account_id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id;

