--Quiz HAVING

--1. How many of the sales reps have more than 5 accounts that they manage?

SELECT s.id, s.name, COUNT(a.id) AS num_account
FROM accounts a 
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.id, s.name
HAVING COUNT(a.id) > 5
ORDER BY num_account;

--2. How many accounts have more than 20 orders?

SELECT a.id, a.name ,COUNT(o.id) AS num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(o.id) > 20
ORDER BY num_orders;

--3. Which account has the most orders?

SELECT a.id, a.name AS name_account, COUNT(o.id) AS num_orders
FROM accounts a
JOIN orders o 
ON a.id = o.account_id 
GROUP BY a.id, name_account
ORDER BY num_orders DESC
LIMIT 1;

--4. Which accounts spent more than 30,000 usd total across all orders?

SELECT a.id, a.name AS name_account, SUM(o.total_amt_usd) AS total
FROM accounts a 
JOIN orders o 
ON o.account_id = a.id 
GROUP BY a.id, name_account
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total;

--5. Which accounts spent less than 1,000 usd total across all orders?

SELECT a.id, a.name AS name_account, SUM(o.total_amt_usd) AS total
FROM accounts a 
JOIN orders o 
ON o.account_id = a.id 
GROUP BY a.id, name_account
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total;

--6. Which account has spent the most with us?

SELECT a.id, a.name AS name_account, SUM(o.total_amt_usd) AS total
FROM accounts a 
JOIN orders o 
ON o.account_id = a.id
GROUP BY a.id, name_account
ORDER BY total DESC
LIMIT 1;

--7. Which account has spent the least with us?

SELECT a.id, a.name AS name_account, SUM(o.total_amt_usd) AS total
FROM accounts a 
JOIN orders o 
ON o.account_id = a.id
GROUP BY a.id, name_account
ORDER BY total 
LIMIT 1;

--8. Which accounts used facebook as a channel to contact customers more than 6 times?

SELECT a.id, a.name, w.channel, COUNT(w.id) AS use_channel
FROM accounts a
JOIN web_events w 
ON w.account_id = a.id
GROUP BY a.id, a.name, w.channel
HAVING w.channel IN ('facebook') and COUNT(w.id) > 6
ORDER BY use_channel;


--9. Which account used facebook most as a channel?

SELECT a.id, a.name, w.channel, COUNT(w.id) AS use_channel
FROM accounts a
JOIN web_events w 
ON w.account_id = a.id
GROUP BY a.id, a.name, w.channel
HAVING w.channel IN ('facebook')
ORDER BY COUNT(w.id) DESC
LIMIT 1;

--10. Which channel was most frequently used by most accounts?

SELECT a.id, a.name, w.channel, COUNT(w.account_id) AS total_time_using
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.id, a.name, w.channel
ORDER BY total_time_using DESC
LIMIT 10;
