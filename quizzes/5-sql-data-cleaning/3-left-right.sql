--Quiz: LEFT & RIGHT

--1. In the accounts table, there is a column holding the website for each company. 
The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. 
Pull these extensions and provide how many of each website type exist in the accounts table.
SELECT RIGHT(website,3) AS domain, COUNT(name) AS count_company
FROM accounts a
GROUP BY 1;

--2. There is much debate about how much the name (or even the first letter of a company name) matters. 
Use the accounts table to pull the first letter of each company name to see the distribution of company names 
that begin with each letter (or number).
SELECT LEFT(UPPER(name),1) AS first_letter, COUNT(id) AS count_company
FROM accounts 
GROUP BY 1
ORDER BY 1;

--3. Use the accounts table and a CASE statement to create two groups: one group of company names 
that start with a number and a second group of those company names that start with a letter. 
What proportion of company names start with a letter?
WITH sub AS 
(SELECT SUM(letter) AS sum_letter, SUM(numeric) AS sum_numeric
FROM
	(SELECT 
     CASE WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0
     ELSE 1 END AS letter,
     CASE WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1
     ELSE 0 END AS numeric
     FROM accounts) t1)
SELECT (sum_letter/(sum_letter + sum_numeric)::float)*100 AS percentage
FROM sub;

--Note: Another solution using regex and nested CTE 
WITH t2 AS (WITH t1 AS (SELECT 
    CASE
    	WHEN LEFT(UPPER(name), 1) ~ 'd'  THEN 'number'
        ELSE 'letter'
    END AS start_with
FROM accounts
ORDER BY name)
SELECT 
	t1.start_with AS starts_with,
	COUNT(t1.*) AS number
FROM t1
GROUP BY t1.start_with)
SELECT
	starts_with,
    (number/(select count(*) from accounts)::float)*100
FROM t2
