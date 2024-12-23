/* Use of CTEs */

/*
Find the average number of events for each day for each channel.
*/
WITH each_channel AS (
	SELECT 	EXTRACT(DAY FROM occurred_at) AS day,
		channel,
		COUNT(*) AS num_events
	FROM web_events
	GROUP BY channel, day		
)
SELECT AVG(num_events),
	channel
FROM each_channel 
GROUP BY channel
ORDER BY AVG(num_events) DESC


/*
Find only the orders that took place in the same month and year as the first order,
and then pull the average for each type of paper 'qty' in this month.
*/

WITH first_order AS(
		SELECT EXTRACT(YEAR FROM occurred_at) AS first_order_year,
		 		EXTRACT(MONTH FROM occurred_at) AS first_order_month
	FROM orders
	ORDER BY occurred_at
	LIMIT 1
)
SELECT AVG(o.standard_qty) AS avg_standard_qty,
		AVG(o.gloss_qty) AS avg_gloss_qty,
		AVG(o.poster_qty) AS avg_poster_qty
FROM orders o
JOIN first_order f
ON EXTRACT(YEAR FROM o.occurred_at) = f.first_order_year
AND EXTRACT(MONTH FROM o.occurred_at) = f.first_order_month

/*
What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/
WITH total_spent AS (
		SELECT o.account_id,
				SUM(o.total_amt_usd) AS total_spend
		FROM orders o
		GROUP BY o.account_id
		ORDER BY total_spend DESC
		LIMIT 10
)
SELECT AVG(o.total_amt_usd) AS avg_order_amount_for_top_10_accounts
FROM orders o
JOIN total_spent ts ON o.account_id = ts.account_id


/*
What is the lifetime average amount spent in terms of total_amt_usd, including
only the companies that spent more per order, on average, than the average of all orders.
*/
WITH overall_avg_per_order AS (
	SELECT AVG(o.total_amt_usd) AS overall_avg
	FROM orders o
),

company_avg_per_order AS (
	SELECT a.id AS account_id,
			a.name AS account_name,
			AVG(o.total_amt_usd) AS avg_per_order
	FROM accounts a
	JOIN orders o ON a.id = o.account_id
	GROUP BY a.id, a.name
)

SELECT AVG(o.total_amt_usd) AS lifetime_avg_for_selected_compaies
FROM orders o
JOIN company_avg_per_order c ON o.account_id = c.account_id
JOIN overall_avg_per_order oa ON c.avg_per_order > oa.overall_avg 


/*
Provide the name of the sales rep in each region with the largest amount of total_amt_usd sales.
*/
--1 calculate total sales per region
WITH sales_by_rep AS(
	SELECT s.id AS sales_rep_id,
			s.name AS sales_rep_name,
			r.id AS region_id,
			r.name AS region_name,
			SUM(o.total_amt_usd) AS total_sales
	FROM sales_reps s
	JOIN accounts a ON s.id = a.sales_rep_id
	JOIN orders o ON a.id = o.account_id
	JOIN region r ON s.region_id = r.id
	GROUP BY s.id, s.name, r.id, r.name
),
--2 calculate max sales per region  
max_sales_per_region AS(
	 SELECT region_id, 
	 		MAX(total_sales) AS max_sales
    FROM sales_by_rep
    GROUP BY region_id
)
--3 select sales rep with maximum sales for each region
SELECT sr.sales_rep_name,
		sr.region_name,
		sr.total_sales
FROM sales_by_rep sr
JOIN max_sales_per_region msr ON sr.region_id = msr.region_id
AND sr.total_sales = msr.max_sales
ORDER BY sr.total_sales DESC

		
/*
For the region with the largest sales total_amt_usd, how many total orders were placed?
*/
WITH region_sales AS (
			SELECT r.name AS region_name,
					SUM(o.total_amt_usd) AS total_amt
			FROM orders o
			JOIN accounts a ON o.account_id = a.id
			JOIN sales_reps s ON a.sales_rep_id = s.id
			JOIN region r ON s.region_id = r.id
			GROUP BY region_name
),
	max_amt AS (
			SELECT MAX(total_amt) AS max_amt
			FROM region_sales
	)
SELECT r.name AS region,
		COUNT(*) AS order_count
FROM orders o
		JOIN accounts a ON a.id = o.account_id
		JOIN sales_reps s ON s.id = a.sales_rep_id
		JOIN region r ON r.id = s.region_id
		GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM max_amt)


