--Quiz: Subquery Mania


--1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT table_1.name_sale,
    table_2.name_region,
    table_1.sum_total
FROM (
        SELECT name_region,
            MAX(sum_total) AS largest_sum
        FROM (
                SELECT r.name AS name_region,
                    s.name AS name_sale,
                    SUM(o.total_amt_usd) AS sum_total
                FROM sales_reps s
                    JOIN accounts a ON a.sales_rep_id = s.id
                    JOIN orders o ON a.id = o.account_id
                    JOIN region r ON r.id = s.region_id
                GROUP BY s.name,
                    r.name
                ORDER BY sum_total DESC
            ) as table_1
        GROUP BY name_region
        ORDER BY largest_sum DESC
    ) AS table_2
    JOIN (
        SELECT r.name AS name_region,
            s.name AS name_sale,
            SUM(o.total_amt_usd) AS sum_total
        FROM sales_reps s
            JOIN accounts a ON a.sales_rep_id = s.id
            JOIN orders o ON a.id = o.account_id
            JOIN region r ON r.id = s.region_id
        GROUP BY s.name,
            r.name
        ORDER BY sum_total DESC
    ) as table_1 ON table_1.sum_total = table_2.largest_sum
    AND table_1.name_region = table_2.name_region;


--2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT r.name AS region_name, COUNT(o.id) AS count_order, t2.max_amt_usd
FROM region r, sales_reps s, accounts a, orders o, 
     (SELECT MAX(sum_total) AS max_amt_usd
      FROM 
           (SELECT SUM(o.total_amt_usd) AS sum_total, r.name AS region_name
            FROM region r
            JOIN sales_reps s ON r.id = s.region_id
            JOIN accounts a ON a.sales_rep_id = s.id
            JOIN orders o ON o.account_id = a.id
            GROUP BY r.name
            ORDER BY sum_total DESC) t1) t2
WHERE r.id = s.region_id AND a.sales_rep_id = s.id AND o.account_id = a.id
GROUP BY r.name,t2.max_amt_usd
HAVING SUM(o.total_amt_usd) = t2.max_amt_usd;

--3. How many accounts had more total purchases than the account name 
-- which has bought the most standard_qty paper throughout their lifetime as a customer?
SELECT a.name AS name_account, SUM(o.total) AS sum_total
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(o.total) > (SELECT total_sum
                       FROM
                        (SELECT a.name AS name_account, sum(o.standard_qty) AS sum_standard_qty, SUM(o.total) AS total_sum
                        FROM orders o
                        JOIN accounts a
                        ON a.id = o.account_id
                        GROUP BY a.name
                        ORDER BY sum_standard_qty DESC
                        LIMIT 1) t1);

--4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, 
-- how many web_events did they have for each channel?
SELECT a.name AS name_account, w.channel, COUNT(w.id) AS count_web
FROM web_events w, accounts a
WHERE a.id = w.account_id 
GROUP BY a.name, w.channel
HAVING a.name = (SELECT name_account
FROM (SELECT a.name AS name_account, SUM(o.total_amt_usd) AS total_sum_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name 
ORDER BY total_sum_usd DESC
LIMIT 1) t1);

--5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(t1.total_amt_usd) AS avg_usd_top10
FROM
(SELECT a.name AS name_account, SUM(o.total_amt_usd) AS total_amt_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name 
ORDER BY total_amt_usd DESC
LIMIT 10) t1;

--6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, 
-- on average, than the average of all orders.
SELECT a.name AS name_account, AVG(o.total_amt_usd)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) 
FROM orders o)
ORDER BY AVG(o.total_amt_usd) DESC
