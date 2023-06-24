--Quiz: DATE Functions

--1. Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

SELECT DATE_PART ('year', occurred_at) AS year, SUM(total_amt_usd) AS total 
FROM orders 
GROUP BY year
ORDER BY total DESC;

--2. Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

SELECT DATE_PART('month', occurred_at) AS order_month, SUM(total_amt_usd) AS total
FROM orders 
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY order_month
ORDER BY total DESC;

--3. Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

SELECT DATE_PART('year', occurred_at) AS order_year, COUNT(total) AS total_sales
FROM orders o
GROUP BY order_year
ORDER BY total_sales DESC;

--4. Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?

SELECT DATE_PART('month', occurred_at) AS order_month, COUNT(total) AS total_sales
FROM orders o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY order_month
ORDER BY total_sales DESC;

--5. In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT DATE_TRUNC ('month', o.occurred_at) AS month, 
    a.name AS name_account, 
    SUM(o.gloss_amt_usd) AS gloss_amt_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY month, name_account
ORDER BY gloss_amt_usd DESC
LIMIT 1;
 
SELECT DATE_PART ('year', o.occurred_at) AS year, 
    DATE_PART ('month', o.occurred_at) AS month, 
    a.name AS name_account, 
    SUM(o.gloss_amt_usd) AS gloss_amt_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY year, month, name_account
ORDER BY gloss_amt_usd DESC
LIMIT 1;