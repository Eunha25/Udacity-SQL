-- Quiz: COALESCE

--1. Run the query entered below in the SQL workspace to notice the row with mising data
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE  o.account_id IS NULL;

--2. Use COALESCE to fill in the accounts.id column with the account.id for the NULL value for the table in 1. 
SELECT COALESCE(a.id, 1) AS refill, a.*, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE  o.account_id IS NULL;

--3. Use COALESCE to fill in the orders.account_id column with the account.id for the NULL value for the table in 1.


--4. Use COALESCE to fill in each of the qty and usd columns with 0 for the table in 1.
SELECT COALESCE(a.id,o.id) refill_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id,
    COALESCE(o.standard_qty,0) AS standard_qty ,COALESCE(o.gloss_qty,0) AS gloss_qty, COALESCE(o.poster_qty,0) AS poster_qty,
    COALESCE(o.total,0) AS total, COALESCE(o.standard_amt_usd,0) AS standard_amt_usd,COALESCE(o.gloss_amt_usd,0) AS gloss_amt_usd,
    COALESCE(o.poster_amt_usd,0) AS poster_amt_usd, COALESCE(o.total_amt_usd,0) AS total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.id IS NULL;

--5. Run the query in 1 with the WHERE removed and COUNT the number of ids.
SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

--6. Run the query in 5, but with the COALESCE function used in question 2 through 4.
SELECT COALESCE(o.id,a.id) AS refill_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
    COALESCE(o.account_id, a.id) AS id, o.occurred_at,
    COALESCE(o.standard_qty,0) AS standard_qty ,COALESCE(o.gloss_qty,0) AS gloss_qty, COALESCE(o.poster_qty,0) AS poster_qty,
    COALESCE(o.total,0) AS total, COALESCE(o.standard_amt_usd,0) AS standard_amt_usd,COALESCE(o.gloss_amt_usd,0) AS gloss_amt_usd,
    COALESCE(o.poster_amt_usd,0) AS poster_amt_usd, COALESCE(o.total_amt_usd,0) AS total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;
