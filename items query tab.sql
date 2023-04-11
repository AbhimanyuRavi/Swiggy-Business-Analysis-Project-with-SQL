/* This query tab contains the queries related to the item dataset, 
which contains information about the food items available on Swiggy, 
such as name, category, price, and restaurant. 
The queries aim to answer questions such as:

What are the distinct food items ordered on Swiggy?
How many vegetarian and meat items are there on Swiggy?
What are the most popular items containing chicken or paratha in their name?
What is the item ordered the most number of times on Swiggy?
What are the unique restaurant names on Swiggy?
Which restaurant has the highest revenue ranking on Swiggy?
The queries use various SQL functions and commands to manipulate and clean the data, 
analyze it for trends and patterns, and 
visualize the insights in an easy-to-understand format.*/


use swiggy;
select * from items;

# 1) How many Distinct Food Items Ordered?
SELECT count(distinct name) FROM items LIMIT 1000

 # 2)Group vegetarian and Non-veg items together    
SELECT is_veg,count(name) as items FROM items 
group by is_veg;

# 3)checking which name comes under is_veg = 2?
SELECT * FROM items where is_veg=2;

# 4)Count the number of unique orders
SELECT count(distinct order_id) FROM items LIMIT 1000;

# 5)Show items containing chicken in their name
SELECT * FROM items
where name like '%Chicken%';

# 6)Show items containing paratha in their name
SELECT * FROM items
where name like '%paratha%';

# 7)Average Items per Order
SELECT count(name)/count(distinct order_id) as avgitemsperorder FROM items

# 8)Item ordered the most number of times
select name,count(*) from items group by name order by count(*) desc;

# 9)Join order and item tables 
SELECT a.name,a.is_veg,b.restaurant_name,b.order_id,b.order_time FROM items a
join orders  b
on a.order_id=b.order_id

# 10) find product combos using self join
SELECT a.order_id,a.name,b.name as name2,CONCAT(a.name,"-",b.name) FROM items a
JOIN items b
ON a.order_id=b.order_id
WHERE a.name!=b.name
AND a.name<b.name;


