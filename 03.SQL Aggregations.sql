/* USING SQL AGGREGATION FUNCTIONS */


/* USING COUNT FUNCTION 
Count the number of rows in the orders table.
*/
SELECT COUNT(*) 
FROM orders

/* USING SUM FUNCTION
Find the total amount of poster_qty paper ordered in the orders table.
*/
  
SELECT SUM(poster_qty)
FROM orders
  
/*
Find the total amount of standard_qty paper ordered in the orders table.
*/
SELECT SUM(standard_qty) AS sum_standard_qty
FROM orders
  
/*
Find the total dollar amount of sales using the total_amt_usd in the orders table.
*/
SELECT SUM(total_amt_usd) AS total_dollar_amount
FROM orders

/*
Find the total amount for each individual order that was spent on standard and gloss papers in the orders table. 
This should give a dollar amount for each order in the order table.
*/
SELECT id,
		SUM(standard_amt_usd) AS standard_amt,
		SUM(gloss_amt_usd) AS gloss_amt
FROM orders
GROUP BY id


*/
Find the standard_amount_usd per unit standard quantity paper. Your solution should use both an aggregation and 
a mathematical operator.
*/

SELECT 	SUM(standard_amt_usd)/SUM(standard_qty) AS standard_amt
FROM orders

/* USING MIN/MAX FUNCTIONS */

/*
When was the earliest order ever placed? Only return the date.
*/

SELECT MIN(occurred_at) AS earliest_order
FROM orders

/*
Try performing same query in the previous one without using an aggregation function.
*/
SELECT occurred_at AS earliest_order
FROM orders
ORDER BY occurred_at ASC
LIMIT 1

/*
When did the most recent(latest) web-event occur?
*/
SELECT MAX(occurred_at) AS recent_order
FROM web_events

/*
Try to perform the result of the previous query without using an aggregation function.
*/
SELECT occurred_at AS recent_order
FROM web_events
ORDER BY occurred_at
LIMIT 1

/* USING AVG FUNCTION*/

/* 
Find the mean (average) amount spent per order on each paper type , as well  as the mean amount of each 
paper type purchased per order. Your final answer should have 6 values - one for each paper type for the
average number of sales, as well as average amount.
*/
SELECT AVG(standard_qty) AS avg_standasr_qty,
	   AVG(gloss_qty) AS avg_gloss_qty,
	   AVG(poster_qty) AS avg_poster_qty,
	   AVG(standard_amt_usd) AS avg_standard_amt,
	   AVG(gloss_amt_usd) AS avg_gloss_amt,
	   AVG(poster_amt_usd) AS avg_poster_amt
FROM orders

/*USING GROUP BY*/

/*
Which accounts (by name) placed the earliest order? Your solution should have the account name and the date of the order.
*/
SELECT a.name AS name,
		o.occurred_at AS earliest_order
FROM accounts a
JOIN orders o ON a.id = o.account_id
ORDER BY earliest_order
LIMIT 1


/*
Assuming it says for every account, find their earliest order.
*/
SELECT a.name AS name,
		MIN(o.occurred_at) AS earliest_order
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY name
ORDER BY earliest_order

/*
Find the total sales in USD for each account. You should include two columns 
- the total sales for each company for each company's orders in USD and the company name.
*/

SELECT a.name AS company_name,
		SUM(o.total_amt_usd) AS total_sales
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY company_name

/*
Via what channel did the most recent (latest) web event occur? Which account was associated
with this event? Your query should return only three values - the date, channel and account name.
*/
SELECT a.name AS account_name,
		w.channel,
		MAX(w.occurred_at) AS recent_event
FROM accounts a
JOIN web_events w ON a.id = w.account_id
GROUP BY account_name, w.channel
ORDER BY recent_event DESC
LIMIT 1


/*
Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the numbber of times the channel was used.
*/

SELECT 	w.channel,
		COUNT(w.channel)
FROM web_events w
GROUP BY w.channel

/*
Who was the primary contact associated with the earliest web event?
*/
SELECT 	a.primary_poc,
		w.occurred_at AS earliest_web_event
FROM accounts a
JOIN web_events w ON a.id = w.account_id
ORDER BY earliest_web_event
LIMIT 1

-- What was the smallest order placed by each account in terms of the total usd. Provide only two columns -
-- the account name and the total usd. Order from the smallest dollar amount to the largest.
SELECT 	a.name AS account_name,
		o.total_amt_usd AS total_usd
FROM accounts a
JOIN orders o ON a.id = o.account_id
ORDER BY total_usd

/*
Find the number of sales_rep in each region. Your final table should have two columns - the region and 
the number of sales reps. Order from fewest reps to most reps.
*/
SELECT 	r.name AS region_name,
		COUNT(s.name) AS num_sales_rep
FROM region r
JOIN sales_reps s ON r.id = s.region_id
GROUP BY region_name
ORDER BY num_sales_rep ASC

/*USING GROUP BY ON MULTIPLE COLUMNS*/

/*
Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final 
table should have three columns - the name of the sales rep, the channel and the number of occurences. 
Order your table with the highest number of occurences first.
*/
SELECT s.name AS sales_rep,
		w.channel,
		COUNT(w.channel) AS occurences
FROM web_events w
JOIN accounts a ON w.account_id = a.id 
JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY sales_rep, w.channel
ORDER BY occurences DESC

/*
Determine the number of times a particular channel was used in the web_events table for each region.
Your final table should have three columns - the region name, the channel and the number of occurences. 
Order your table with the highest number of occurences first.
*/

SELECT r.name AS region_name,
		w.channel,
		COUNT(w.channel) AS occurences
FROM web_events w
JOIN accounts a ON w.account_id = a.id 
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
GROUP BY region_name, w.channel
ORDER BY occurences DESC


/*USING DISTINCT*/

/*
Use DISTINCT to test if there are any accounts associated with more than one region
*/

SELECT DISTINCT a.name,
		r.name,
		COUNT(*) AS occurences
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
GROUP BY a.name,
	r.name

/*
Has any sales_rep worked on more than one account?
*/
SELECT DISTINCT s.name AS sales_rep,
		COUNT(*) AS accounts
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name
ORDER BY accounts DESC

--- Yes, all the sales_rep has worked on more than one account.

/*USING HAVING CLAUSE*/

/*
How many of the sales_reps have more than five accounts that they manage?
*/
SELECT DISTINCT s.name AS sales_rep,
		COUNT(*) AS accounts
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING COUNT(*) > 5
ORDER BY accounts DESC

/*
How many accounts have more than 20 orders?
*/
SELECT a.name,
	COUNT(*) AS accounts
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(*) > 20
ORDER BY accounts DESC
-- 120 accounts have more than 20 orders


/*
Which account has the most orders?
*/
SELECT a.name,
	COUNT(*) AS accounts
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY accounts DESC
LIMIT 1
-- Leucadia National has the most orders.


/*
Which accounts spent more than 30,000 usd total across all orders?
*/
SELECT a.name AS Account_name, 
		SUM(o.total_amt_usd) AS Amount_spent
FROM orders o
INNER JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY SUM(o.total_amt_usd) DESC

/*
Which account has spent the most with us?
*/
SELECT a.name AS Account_name, 
	SUM(o.total_amt_usd) AS Amount_spent
FROM orders o
INNER JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY SUM(o.total_amt_usd) DESC
LIMIT 1
-- EOG Resources spent the most with us


/*
Which accounts used Facebook as a channel to contact customers more than 6 times?
*/
SELECT a.name, 
	w.channel, 
	COUNT(*) AS total_usage
FROM web_events w
JOIN accounts a ON w.account_id = a.id
WHERE w.channel LIKE 'facebook'
GROUP BY a.id, w.channel
HAVING COUNT(*) > 6
ORDER BY total_usage DESC

/*DATE FUNCTIONS
Let's look at some date functions
*/

/* Get the curent date
*/
SELECT CURRENT_DATE

/*
Get the date in UTC timezone
*/
SELECT NOW() AT TIME ZONE 'UTC'

/*
Extract the month names from the occurreed-at column in the orders table.
*/
SELECT TO_CHAR(occurred_at, 'Month') AS month_name
FROM orders

/*
Extract both the month numbers and the month names from the occurred_at column in the orders table.
*/
SELECT EXTRACT(MONTH FROM occurred_at) AS month_number,
       TO_CHAR(occurred_at, 'Month') AS month_name
FROM orders

/* Now Answering some questions regarding date functions */

/*
Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.
*/
SELECT EXTRACT(YEAR FROM o.occurred_at) AS year,
       SUM(o.total_amt_usd) AS total_dollars
FROM orders o
GROUP BY year
ORDER BY total_dollars DESC

/*
Do you notice any trend in the yearly sales total?
*/
--Sales rose initially but dropped suddenly in 2017

/*
Which month did Parch and Posey have the greatest sales in terms of total dollars?
Are all months evenly represented by the dataset?
*/
SELECT EXTRACT(MONTH FROM o.occurred_at) AS month,
       SUM(o.total_amt_usd) AS total_dollars
FROM orders o
GROUP BY month
ORDER BY total_dollars DESC

/*
Assuming you want to return the names of the months
*/
SELECT TO_CHAR(o.occurred_at, 'Month') AS month,
       SUM(o.total_amt_usd) AS total_dollars
FROM orders o
GROUP BY month
ORDER BY total_dollars DESC

/*
Which year did Parch and Posey have the greatest sales in terms of total number of orders? 
Are all year evenly represented by the dataset?
*/


-- the result shows that we have incomplete data as 2013 and 2017 has less amount of orders


-- to confirm this

  
  -- we see that 2013 has only one month recorded in it


/* Which month did Parch and Posey have the greatest sales in terms of total number of orders? 
Are all month evenly represented by the dataset?
*/


-- Parch and Posey has the greatest sales in December and October


/*
In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/



/*CASE STATEMENTS*/

/*
Write a query to display for each other, the account ID, total amount of the order, and the level of the order -
'Large' or 'Small' - depending on if the order is $3000 or more, or less than $3000.
*/




/*
Write a query to display the number of orders in each of three categories, based on the total number of items in each order
The three categories are: 'At Least 2000', 'Between 1000 and 2000', and 'Less than 1000'.
*/




/* 
We would like to understand 3 different branches of customers based on the amount associated with their purchases. 
The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
The second branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd.
Provide a table that includes the level associated with  each account. You should provide the account name,
the total sales of all orders for the customer, and the level.
Order with the top spending customers listed first.
*/



/*
We would like to identify top performing sales reps, which are sales reps asscoiated with more than 200 orders.
Create a table with the sales rep name, the total number of orders, and a column with top or not depending on
if they have more than 200 orders. Place the top sales people first in your final table.
*/

