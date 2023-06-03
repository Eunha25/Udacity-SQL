--Quiz: Your First JOIN

--1. Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

--2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT o.standard_qty, o.gloss_qty, o.poster_qty, a.website, a.primary_poc
FROM orders o
JOIN accounts a
ON o.account_id = a.id;
