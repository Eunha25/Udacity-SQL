--Quiz: GROUP BY Part II

--1, For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name AS account_name,
       AVG(o.standard_qty) AS avg_standard,
       AVG(o.gloss_qty) AS avg_gloss,
       AVG(o.poster_qty) AS avg_poster
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY account_name;

--2. For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name AS account_name,
       AVG(o.standard_amt_usd) AS avg_standard_usd,
       AVG(o.gloss_amt_usd) AS avg_gloss_usd,
       AVG(o.poster_amt_usd) AS avg_poster_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY account_name;

--3. Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT s.name AS name_sales_rep,
       w.channel,
       COUNT(w.channel) AS number_of_channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY name_sales_rep, channel
ORDER BY number_of_channel DESC;

--4. Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first

SELECT r.name AS name_region,
       w.channel,
       COUNT(w.channel) AS number_of_channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY name_region, channel
ORDER BY number_of_channel DESC;