-- Quiz: POSITION, STRPOS, & SUBSTR - AME DATA AS QUIZ 1

--1. Use the accounts table to create first and last name columns 
that hold the first and last names for the primary_poc.
SELECT LEFT(primary_poc,STRPOS(primary_poc,' ')-1) AS fisrt_name,
        RIGHT(primary_poc,LENGTH(primary_poc) - STRPOS(primary_poc,' ')) AS last_name
FROM accounts;

--2. Now see if you can do the same thing for every rep name in the sales_reps table. 
Again provide first and last name columns.
SELECT LEFT(name, STRPOS(name,' ')-1) AS first_name,
     RIGHT(name,LENGTH(name) - STRPOS(name,' ')) AS last_name
FROM sales_reps;

