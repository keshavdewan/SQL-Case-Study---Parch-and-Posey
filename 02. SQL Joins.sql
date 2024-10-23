/* USING SQL JOINS */

/*
Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
*/




/*
Provide a table for all web_events associated with the account name of Walmart. There should be three columns. 
Be sure to include primary_oc, time_of_events, and the channel for each event. Additionally you might choose to add a fourth column
to assure only Walmart events were chosen.
*/




/*
Provide a table that provides the region for each sales_rep along with their associated account. Your final table should include
three column: the region-name, the sales_rep name, and account_name. Sort the accounts alphabetically.
*/





/*
Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total)
for the order. Your final table should have three columns: region name, account name, and unit price. A few accounts have 0 for
total, so we will divide by (total + 0.01) to assure not dividing by zero.
*/





/*
Provide a table that provides the region for each sales_rep along with tneir associated accounts. This time only for the
Midwest region. Your final table should include three columns: the region name, the sales_rep name, and the account name. 
Sort the accounts alphabetically (A - Z) according to account name.
*/





/*
Provide a table that provides the region for each sales_rep, along with their associated accounts. This time only focus on 
for the accounts where the sales_rep has a first name starting with S and in the Midwest region. 
Your final table should include 3 columns: the region name, the sales_rep name, and the account name.
Sort the accounts alphabetically (A - Z) according to account name.
*/



--OR





/*
Provide a table that provides the region for each sales_rep, along with their associated accounts. This time only focus on 
for the accounts where the sales_rep has a last name starting with K and in the Midwest region. 
Your final table should include 3 columns: the region name, the sales_rep name, and the account name. 
Sort the accounts alphabetically (A - Z) according to account name.
*/




/*
Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100.
Your final table should have 3 columns: region name, account name, and unit price.
*/





/* 
Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity 
exceeds 100 and the poster order quantity exceeds 50.
Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
*/




/*
What are the different channels used by the account id 1001? Your final table should have only 2 columns: account name and
the different channels. You can try SELECT DISTINCT to narrow down the results to only unique values.
*/


-- Find all the orders that occured in 2015. Your final table should have 4 columns: occurred_at, account_name, order total 
-- and order total_amt_usd
