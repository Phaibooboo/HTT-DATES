--Trend of orders vs the overall average order value
SELECT id, total, (SELECT avg(total)
					FROM orders)
FROM orders

-----------------------------------------

--identify names of clients that have placed an order

SELECT name
FROM accounts
WHERE id IN  (SELECT account_id
			  FROM orders)
			  
-------------------------------------------

--Generate the order ids and when it occurred where the no. of standard paper ordered is greater than 500

SELECT id, occurred_at
FROM (  SELECT id, occurred_at, standard_qty
		FROM orders
		WHERE standard_qty > 500) AS standard_above500

--------------------------------------------
--CTE (Common table expressions)

WITH standard_above500 AS (  SELECT id, occurred_at, standard_qty
							 FROM orders
							 WHERE standard_qty > 500)
							 
SELECT id, occurred_at
FROM standard_above500


With sub1 as (SELECT id, total_amt_usd,
    				CASE
      		  		WHEN total_amt_usd >= 1000 THEN 'High'
      		  		WHEN total_amt_usd >= 500 THEN 'Medium'
      		  		ELSE 'Low'
   				END AS amount_category
			FROM orders
			)

SELECT amount_category, COUNT(amount_category)
FROM sub1
GROUP BY amount_category
-------------------------------------------------
SELECT DISTINCT channel, COUNT(channel)
FROM web_events
GROUP BY channel

SELECT DISTINCT occurred_at, COUNT(occurred_at)
FROM web_events
GROUP BY occurred_at


SELECT occurred_at, DATE_TRUNC('year', occurred_at) AS years, 
					DATE_TRUNC('month', occurred_at) AS months,
					DATE_TRUNC('day', occurred_at) AS days
FROM web_events
---------------------------------------------------------------------------
--Date Part
SELECT occurred_at, DATE_PART('year', occurred_at) AS year_part,
					DATE_PART('month', occurred_at) AS month_part,
					DATE_PART('day', occurred_at) AS day_part
FROM web_events
							  
-----------------------------------------------------------------------------
SELECT DATE_TRUNC('month', occurred_at), COUNT(occurred_at)
FROM web_events
GROUP BY 1
ORDER BY 1


SELECT DATE_PART('dow', occurred_at), COUNT(occurred_at)
FROM web_events
GROUP BY 1
ORDER BY 1

--What is the total amount of money generated monthly since inception of parch and posey
SELECT DATE_TRUNC('month', occurred_at) AS month, SUM(total_amt_usd) AS monthly_sale
FROM orders
GROUP BY 1
ORDER BY 1


--what month had the highest sales irrespective of the year
SELECT DATE_PART('month', occurred_at), SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 desc






























