--Quiz: LIKE

--1. All the companies whose names start with 'C'.
SELECT name 
FROM accounts
WHERE name LIKE 'C%';

--2. All companies whose names contain the string 'one' somewhere in the name.
SELECT name 
FROM accounts
WHERE name LIKE '%one%';

--3. All companies whose names end with 's'.
SELECT name 
FROM accounts
WHERE name LIKE '%s';