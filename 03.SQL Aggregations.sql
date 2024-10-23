/* USING SQL AGGREGATION FUNCTIONS */


/* USING COUNT FUNCTION 
Count the number of rows in the orders table.
*/


/* USING SUM FUNCTION
Find the total amount of poster_qty paper ordered in the orders table.
*/

/*
Find the total amount of standard_qty paper ordered in the orders table.
*/

/*
Find the total dollar amount of sales using the total_amt_usd in the orders table.
*/


/*
Find the total amount for each individual order that was spent on standard and gloss papers in the orders table. 
This should give a dollar amount for each order in the order table.
*/


Find the standard_amount_usd per unit standard quantity paper. Your solution should use both an aggregation and 
a mathematical operator.
*/



/* USING MIN/MAX FUNCTIONS */

/*
When was the earliest order ever placed? Only return the date.
*/


/*
Try performing same query in the previous one without using an aggregation function.
*/



/*
When did the most recent(latest) web-event occur?
*/



/*
Try to perform the result of the previous query without using an aggregation function.
*/


/* USING AVG FUNCTION*/

/* 
Find the mean (average) amount spent per order on each paper type , as well  as the mean amount of each 
paper type purchased per order. Your final answer should have 6 values - one for each paper type for the
average number of sales, as well as average amount.
*/


/*USING GROUP BY*/

/*
Which accounts (by name) placed the earliest order? Your solution should have the account name and the date of the order.
*/



/*
Assuming it says for every account, find their earliest order.
*/


/*
Find the total sales in USD for each account. You should include two columns 
- the total sales for each company for each company's orders in USD and the company name.
*/


/*
Via what channel did the most recent (latest) web event occur? Which account was associated
with this event? Your query should return only three values - the date, channel and account name.
*/



/*
Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the numbber of times the channel was used.
*/



/*
Who was the primary contact associated with the earliest web event?
*/



-- What was the smallest order placed by each account in terms of the total usd. Provide only two columns -
-- the account name and the total usd. Order from the smallest dollar amount to the largest.


/*
Find the number of sales_rep in each region. Your final table should have two columns - the region and 
the number of sales reps. Order from fewest reps to most reps.
*/


/*USING GROUP BY ON MULTIPLE COLUMNS*/

/*
Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final 
table should have three columns - the name of the sales rep, the channel and the number of occurences. 
Order your table with the highest number of occurences first.
*/


/*
Determine the number of times a particular channel was used in the web_events table for each region.
Your final table should have three columns - the region name, the channel and the number of occurences. 
Order your table with the highest number of occurences first.
*/


/*USING DISTINCT*/

/*
Use DISTINCT to test if there are any accounts associated with more than one region
*/

--OR



/*
Has any sales_rep worked on more than one account?
*/

--- Yes, all the sales_rep has worked on more than one account.



/*USING HAVING CLAUSE*/

/*
How many of the sales_reps have more than five accounts that they manage?
*/


/*
How many accounts have more than 20 orders?
*/

-- 120 accounts have more than 20 orders


/*
Which account has the most orders?
*/

-- Leucadia National has the most orders.


/*
Which accounts spent more than 30,000 usd total across all orders?
*/


/*
Which account has spent the most with us?
*/

-- EOG Resources spent the most with us


/*
Which accounts used Facebook as a channel to contact customers more than 6 times?
*/




/*DATE FUNCTIONS
Let's look at some date functions
*/

/* Get the curent date
*/


/*
Get the date in UTC timezone
*/


/*
Extract the month names from the occurreed-at column in the orders table.
*/


/*
Extract both the month numbers and the month names from the occurred_at column in the orders table.
*/


-- Alternatively you can also use the MONTH function to return same thing as date part

/* Now Answering some questions regarding date functions */

/*
Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.
*/


/*
Do you notice any trend in the yearly sales total?
*/


/*
Which month did Parch and Posey have the greatest sales in terms of total dollars?
Are all months evenly represented by the dataset?
*/


/*
Assuming you want to return the names of the months
*/


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

