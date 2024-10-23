/* USING SQL JOINS */

/*
Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
*/

SELECT o.standard_qty,
		o.gloss_qty,
		o.poster_qty,
		a.primary_poc,
		a.website
FROM orders o
JOIN accounts a ON o.account_id = a.id


/*
Provide a table for all web_events associated with the account name of Walmart. There should be three columns. 
Be sure to include primary_poc, time_of_events, and the channel for each event. Additionally you might choose to add a fourth column
to assure only Walmart events were chosen.
*/

SELECT 	a.primary_poc,
		w.occurred_at,
		w.channel,
		a.name
FROM accounts a
JOIN web_events w ON  a.id = w.account_id
WHERE a.name = 'Walmart'


/*
Provide a table that provides the region for each sales_rep along with their associated account. Your final table should include
three column: the region-name, the sales_rep name, and account_name. Sort the accounts alphabetically.
*/

SELECT 	r.name AS region_name,
		s.name AS sales_rep_name,
		a.name AS account_name
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
ORDER BY a.name ASC


/*
Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total)
for the order. Your final table should have three columns: region name, account name, and unit price. A few accounts have 0 for
total, so we will divide by (total + 0.01) to assure not dividing by zero.
*/

SELECT 	r.name AS region_name,
		a.name AS account_name,
		(o.total_amt_usd/(o.total + 0.01)) AS unit_price
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id

/*
Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the
Midwest region. Your final table should include three columns: the region name, the sales_rep name, and the account name. 
Sort the accounts alphabetically (A - Z) according to account name.
*/

SELECT 	r.name AS region_name,
		s.name AS sales_rep,
		a.name AS account_name
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name ASC

/*
Provide a table that provides the region for each sales_rep, along with their associated accounts. This time only focus on 
for the accounts where the sales_rep has a first name starting with S and in the Midwest region. 
Your final table should include 3 columns: the region name, the sales_rep name, and the account name.
Sort the accounts alphabetically (A - Z) according to account name.
*/

SELECT 	r.name AS region_name,
		s.name AS sales_rep,
		a.name AS account_name
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE s.name LIKE 'S%' AND
		r.name = 'Midwest'
ORDER BY a.name ASC

/*
Provide a table that provides the region for each sales_rep, along with their associated accounts. This time only focus on 
for the accounts where the sales_rep has a last name starting with K and in the Midwest region. 
Your final table should include 3 columns: the region name, the sales_rep name, and the account name. 
Sort the accounts alphabetically (A - Z) according to account name.
*/

SELECT 	r.name AS region_name,
		s.name AS sales_rep,
		a.name AS account_name
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE s.name LIKE '% K%' AND
		r.name = 'Midwest'
ORDER BY a.name ASC

/*
Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100.
Your final table should have 3 columns: region name, account name, and unit price.
*/

SELECT 	r.name AS region_name,
		a.name AS account_name,
		(o.total_amt_usd/(o.total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
WHERE o.standard_qty > 100

/* 
Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity 
exceeds 100 and the poster order quantity exceeds 50.
Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
*/
  
SELECT 	r.name AS region_name,
		a.name AS account_name,
		(o.total_amt_usd/(o.total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
WHERE(o.standard_qty > 100 AND
		o.poster_qty > 50)
ORDER BY unit_price ASC

/*
What are the different channels used by the account id 1001? Your final table should have only 2 columns: account name and
the different channels. You can try SELECT DISTINCT to narrow down the results to only unique values.
*/

SELECT 	DISTINCT a.name AS account_name,
		w.channel AS channel,
		a.id
FROM accounts a
JOIN web_events w ON a.id = w.account_id
WHERE a.id = 1001

-- Find all the orders that occured in 2015. Your final table should have 4 columns: occurred_at, account_name, order total 
-- and order total_amt_usd

SELECT o.id, 
		o.occurred_at,
		a.name AS Account_Name,
		o.total, o.total_amt_usd
FROM orders o
JOIN accounts a ON o.account_id = a.id
	AND o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at
