--Quiz: Write Your First Subquery

--1. Use the test enviroment below to find the number of events that occur for each day for each channel.
SELECT DATE_TRUNC('day', occurred_at) AS day,
	channel,
    COUNT(id) AS event_count
FROM web_events
GROUP BY day, channel
ORDER BY event_count DESC;

--2. Now create a subquery taht simply provides all of the data from your fisrt query.
SELECT *
FROM 
(SELECT DATE_TRUNC('day', occurred_at) AS day,
	channel,
    COUNT(id) AS event_count
FROM web_events
GROUP BY day, channel
ORDER BY event_count DESC) AS subquery;


--3. Now find the average number of events for each channel. Since you broke out by day earlier, 
-- this is giving you an average per day.
SELECT channel, AVG(event_count) AS avg_event
FROM 
(SELECT DATE_TRUNC('day', occurred_at) AS day,
	channel,
    COUNT(id) AS event_count
FROM web_events
GROUP BY day, channel
ORDER BY event_count DESC) AS subquery
GROUP BY 1
ORDER BY 2 DESC;

-- Note: No subquery
SELECT AVG (standard_qty),
    DATE_TRUNC('month', occurred_at) AS month
FROM orders
GROUP BY month
ORDER BY month 