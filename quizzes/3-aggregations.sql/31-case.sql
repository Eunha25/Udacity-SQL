--Quiz: CASE

--1. Write a query to display for each order, the account ID, total amount of the order, 
-- and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
SELECT account_id, total_amt_usd,
    CASE WHEN total_amt_usd > 3000 THEN 'large'
    ELSE 'small' END AS level_of_order
FROM orders;

--2. Write a query to display the number of orders in each of three categories, 
-- based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' 
-- and 'Less than 1000'.
SELECT COUNT(o.id),
    CASE WHEN o.total >= 2000 THEN 'at_least_2000'
	WHEN o.total BETWEEN 1000 AND 2000 THEN 'between_1000_and_2000'
    ELSE 'less_than_1000' END AS categories
FROM orders o
GROUP BY categories;

--3. We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
-- The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
-- The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. 
-- Provide a table that includes the level associated with each account. 
-- You should provide the account name, the total sales of all orders for the customer, and the level. 
-- Order with the top spending customers listed first.
SELECT a.name AS account_name, SUM(o.total_amt_usd) AS total_sales,
    CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater_than_200,000usd'
    WHEN  SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'between'
    ELSE 'under_100000' END AS level
FROM orders o
JOIN accounts a 
ON a.id = o.account_id 
GROUP BY account_name
ORDER BY total_sales DESC;

--4. We would now like to perform a similar calculation to the first, 
-- but we want to obtain the total amount spent by customers only in 2016 and 2017. 
-- Keep the same levels as in the previous question. Order with the top spending customers listed first.
SELECT a.name AS account_name, SUM(o.total_amt_usd) AS total_sales,
    CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater_than_200,000usd'
    WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'between'
    ELSE 'under_100000' END AS level
FROM orders o
JOIN accounts a 
ON a.id = o.account_id 
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY account_name
ORDER BY total_sales DESC;

--5. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
-- Create a table with the sales rep name, the total number of orders, 
-- and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.
SELECT s.name AS sale_name, COUNT(o.id) AS number_of_order,
	CASE WHEN COUNT(o.id) > 200 THEN 'top'
    ELSE 'low' END AS level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY sale_name
ORDER BY number_of_order DESC;

--6. The previous didn't account for the middle, nor the dollar amount associated with the sales. 
-- Management decides they want to see these characteristics represented as well. 
-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders 
-- or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. 
-- Create a table with the sales rep name, the total number of orders, total sales across all orders, 
-- and a column with top, middle, or low depending on this criteria. 
-- Place the top sales people based on dollar amount of sales first in your final table. 
-- You might see a few upset sales people by this criteria!
SELECT s.name AS sale_name, COUNT(o.id) AS number_of_order,
	SUM(o.total_amt_usd) AS total_orders_sale,
	CASE WHEN o.id > 200 OR o.total_amt_usd > 750000 THEN 'top'
    WHEN o.id > 150 OR o.total_amt_usd > 500000 THEN 'middle'
    ELSE 'low' END AS level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY sale_name, level
ORDER BY total_orders_sale DESC;



