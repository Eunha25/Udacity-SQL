--Quiz: More On Subqueries

--1. The average amount of standard paper sold on the first month that any order was placed in the orders table (in terms of quantity).

SELECT DATE_TRUNC('month',(occurred_at)) AS month,
	   AVG (standard_qty) AS avg_standard_qty
FROM orders
GROUP BY 1
ORDER BY month;

--2. The average amount of gloss paper sold on the first month that any order was placed in the orders table (in terms of quantity).

SELECT DATE_TRUNC('month',(occurred_at)) AS month,
	   AVG (gloss_qty) AS avg_gloss_qty
FROM orders
GROUP BY 1
ORDER BY month;

--3. The average amount of poster paper sold on the first month that any order was placed in the orders table (in terms of quantity).

SELECT DATE_TRUNC('month', occurred_at) AS month,
	AVG (poster_qty) AS avg_poster_qty
FROM orders
GROUP BY 1
ORDER BY month;

--4. The total amount spent on all orders on the first month that any order was placed in the orders table (in terms of usd).

SELECT DATE_TRUNC('month', occurred_at) AS month,
	SUM(total_amt_usd) AS total_usd 
FROM orders
GROUP BY 1
ORDER BY 1;



SELECT DATE_TRUNC('month', MIN(occurred_at)) 
FROM orders;

SELECT AVG(standard_qty) AS avg_standard,
       AVG(gloss_qty) AS avg_gloss,
       AVG(poster_qty) AS avg_poster
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) 
		FROM orders);