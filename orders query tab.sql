/*This query tab contains the queries related to the orders dataset, 
which contains information about the orders placed by customers on Swiggy, 
such as date, time, location, payment method, and items ordered. 
The queries aim to answer questions such as:

How many unique orders are placed on Swiggy?
What is the average number of items per order on Swiggy?
How do orders vary during rainy times on Swiggy?
Which restaurant has the most orders on Swiggy?
How do orders and revenue change by month and year on Swiggy?
What is the average order value on Swiggy?
How does revenue change year over year on Swiggy using lag function and ranking the highest year?
What are the most common product combos ordered on Swiggy using self join?
The queries use various SQL functions and commands to manipulate and clean the data, 
analyze it for trends and patterns, and 
visualize the insights in an easy-to-understand format.*/
create database swiggy;
use swiggy;
#Imported item.csv and orders.csv as tables
select * from orders;

# 1)Orders during rainy times
SELECT distinct rain_mode FROM orders LIMIT 1000

# 2) how many times ontime delivered?
SELECT COUNT(*) FROM orders WHERE on_time = 1 ;

# 3) Unique restaurant names
SELECT count(distinct restaurant_name) FROM orders LIMIT 1000;

# 4) how many times ordered from each restaurant;
SELECT restaurant_name,count(*) FROM orders 
group by restaurant_name 
order by count(*) desc;

# 5)Orders placed per month and year 
SELECT DATE_FORMAT(order_time,'%Y-%m'), COUNT(DISTINCT order_id) 
FROM orders 
GROUP BY DATE_FORMAT(order_time,'%Y-%m') 
ORDER BY COUNT(DISTINCT order_id) DESC;

# 6) The latest order that has been made?
select max(order_time) from orders;

# 7)Revenue made by month
SELECT  DATE_FORMAT(order_time,'%Y-%m'),sum(order_total) as totalrevenue 
FROM orders  
group by  DATE_FORMAT(order_time,'%Y-%m')
order by totalrevenue desc;

# 8) Average Order Value
SELECT sum(order_total)/count(distinct order_id) as aov
FROM orders; 

# 9) year by year spending on swiggy
SELECT date_format(order_time,'%Y'),sum(order_total) as revenue
FROM orders
group by  date_format(order_time,'%Y');

# 10) Year by Year  Change in revenue using lag function and ranking the highest year
WITH final AS (
  SELECT DATE_FORMAT(order_time,'%Y') AS yearorder, SUM(order_total) AS revenue
  FROM orders
  GROUP BY DATE_FORMAT(order_time,'%Y')
)
SELECT yearorder, revenue, LAG(revenue) OVER (ORDER BY yearorder) AS previousrevenue
FROM final
ORDER BY revenue DESC;

# 11) year with highest revenue ranking
 WITH final AS (
  SELECT DATE_FORMAT(order_time,'%Y') AS yearorder, SUM(order_total) AS revenue
  FROM orders
  GROUP BY DATE_FORMAT(order_time,'%Y')
) 
  
  SELECT yearorder, revenue, rank() OVER (ORDER BY revenue desc) AS ranking
FROM final;

 #12) restaurant with highest revenue ranking
 WITH final AS (
  SELECT restaurant_name, SUM(order_total) AS revenue
  FROM orders
  GROUP by restaurant_name
) 

  SELECT restaurant_name, revenue, rank() OVER (ORDER BY revenue desc) AS ranking
FROM final;

#13)what money was made during the various types of rain mode?
select rain_mode,sum(order_total) from orders group by rain_mode


















