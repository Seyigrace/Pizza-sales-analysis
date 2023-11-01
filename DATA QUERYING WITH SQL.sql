--CASE STUDY : Pizza sales

--KPI'S REQUIREMENTS:

Questions
 --1. Total revenue: The sum of all total price of all pizza orders. 

SELECT SUM(total_price) AS Total_Revenue  
FROM pizza_sales  

--2. Average Order Value: Calculated by dividing the total revenue by the total number of orders.   

SELECT AVG(total_price) AS average_order_value
FROM  pizza_sales
    SELECT order_id, SUM(unit_price) AS total_order_value
    FROM pizza_sales
    GROUP BY order_id
ORDER BY order_id	

--3. Total Pizzas Sold: This is the sum of the quantities of all pizzas sold.
SELECT  SUM(quantity) AS Total_pizza_sold
FROM pizza_sales

-- 4. Total Orders: This is the total number of orders placed.

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales

--5. Average Pizza sold:

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales

--Charts Requirement

--1. Daily trend of total order. 

SELECT DATEPART(HOUR, order_time) as order_hours, SUM(quantity) as total_pizzas_sold
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

--2. Monthly trend of total orders. 

SELECT DATEPART(ISO_WEEK, order_date) AS WeekNumber, YEAR(order_date) AS Year, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY  DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY Year, WeekNumber;

--3.	Percentage of sales by pizza category. 

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--4.	Percentage of sales by pizza size. 

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--5.	Total pizza sold by pizzas category. 

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--6.	Top 5 best sellers by Revenue, Total Quantity and Total Orders. 

SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--7.	Bottom 5 best sellers by Revenue, Total Quantity and Total Orders.  

SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--8.	Top 5 Pizzas by Quantity

SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--9.	Bottom 5 Pizzas by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--10. Top 5 Pizzas by Total Orders

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--11. Bottom 5 Pizzas by Total Orders.

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC


