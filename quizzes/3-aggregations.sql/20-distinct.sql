--Quiz: DISTINCT

--1. Use DISTINCT to test if there are any accounts associated with more than one region.

SELECT DISTINCT a.name AS account_name, COUNT(r.name) AS number_of_region
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY a.name
ORDER BY number_of_region;

--2. Have any sales reps worked on more than one account?

SELECT s.name AS sale_rep_name, COUNT(a.id) AS number_of_account
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
GROUP BY sale_rep_name
ORDER BY number_of_account DESC;