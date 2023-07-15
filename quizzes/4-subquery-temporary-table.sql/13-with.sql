--Quiz: WITH

--1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH sub_1 AS
    (SELECT s.name AS name_sales, r.name AS name_region, SUM(o.total_amt_usd) AS sum_usd
    FROM region r
    JOIN sales_reps s
    ON s.region_id = r.id
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON o.account_id = a.id
    GROUP BY 1,2
    ORDER BY sum_usd DESC),
        sub_2 AS 
        (SELECT MAX(sum_usd) AS largest_total_usd, name_region 
        FROM sub_1
        GROUP BY 2)
SELECT s1.name_sales, s1.name_region, largest_total_usd 
FROM sub_1 AS s1
JOIN Sub_2 s2
ON s1.sum_usd = s2.largest_total_usd

--2. For the region with the largest sales total_amt_usd, how many total orders were placed?
WITH t1 AS 
    (SELECT r.name AS name_region, SUM(o.total_amt_usd) AS sum_total
    FROM orders o
    JOIN accounts a
    ON a.id = o.account_id
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY 1
    ORDER BY 2 DESC),
        t2 AS
        (SELECT MAX(sum_total) AS largest_amt 
        FROM t1)
SELECT r.name AS name_region, SUM(o.total_amt_usd) AS total_amt, COUNT(o.id) AS total_orders
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

--3. How many accounts had more total purchases than the account name 
which has bought the most standard_qty paper throughout their lifetime as a customer?
WITH t1 AS 
(SELECT a.name AS name_account, SUM(o.standard_qty) AS sum_standard
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC),
  t2 AS 
  (SELECT MAX(sum_standard)
   FROM t1)
SELECT a.name AS name_account, SUM(o.total) AS sum_total
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
HAVING SUM(o.total) > (SELECT * FROM t2)
ORDER BY 2 DESC;

--4. For the customer that spent the most (in total over their lifetime as a customer) 
total_amt_usd, how many web_events did they have for each channel?



