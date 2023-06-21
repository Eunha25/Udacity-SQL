--Quiz: Subquery Mania

--1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

SELECT table_1.name_sale, table_2.name_region, table_1.sum_total
FROM 
    (SELECT name_region, MAX(sum_total) AS largest_sum
    FROM
        (SELECT r.name AS name_region, s.name AS name_sale, SUM(o.total_amt_usd) AS sum_total
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON a.id = o.account_id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY s.name, r.name
        ORDER BY sum_total DESC) as table_1
    GROUP BY name_region
    ORDER BY largest_sum DESC) AS table_2
JOIN (SELECT r.name AS name_region, s.name AS name_sale, SUM(o.total_amt_usd) AS sum_total
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON a.id = o.account_id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY s.name, r.name
        ORDER BY sum_total DESC) as table_1
ON table_1.sum_total = table_2.largest_sum AND table_1.name_region = table_2.name_region;

--2. 