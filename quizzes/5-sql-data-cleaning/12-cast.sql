-- Quiz: CAST

-- 4. Write a query to change the date into the correct SQL date format. 
You will need to use at least SUBSTR and CONCAT to perform this operation.
SELECT date AS original_day, 
	SUBSTR(date,7,4)||'-'||SUBSTR(date,1,2)||'-'||SUBSTR(date,4,2) AS new_date
FROM sf_crime_data;

-- 5. Once you have created a collumn in the correct format, use either CAST or :: to convert this to a date.
SELECT date AS original_day, 
	(SUBSTR(date,7,4)||'-'||SUBSTR(date,1,2)||'-'||SUBSTR(date,4,2)) :: DATE AS new_date
FROM sf_crime_data;