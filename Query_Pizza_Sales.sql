--menampilkan seluruh tabel dari database pizza_sales
select * from pizza_sales

--KPI's REQUIREMENT--
--total revenue
select sum(total_price) as Total_Revenue from pizza_sales

--average order revenue (total revenue/total number of order)
select (sum (total_price) / count(distinct order_date)) as Avg_order from pizza_sales

--total pizza sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales

--total order
select count(distinct order_id) as Total_Order from pizza_sales

--average pizzas per order
select cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2))
as Avg_Pizza_per_Order from pizza_sales



--CHARTS REQUIREMENT--
--Daily trend for total_order
select DATENAME (DW, order_date) as order_day, COUNT(DISTINCT order_id) as Total_Order_daily
from pizza_sales
group by DATENAME (DW, order_date)

--Monthly trend for total orders
select DATENAME(MONTH, order_date) as Order_Month, count(distinct order_id) as Total_Order_Monthly
from pizza_sales
group by DATENAME (MONTH, order_date)
order by Total_Order_Monthly desc --this query optional, to display from max total order

--Percentage of pizza sales by category
select pizza_category, cast(sum (total_price) as decimal(10,2)) as Total_Revenue,
cast(sum (total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal (10,2)) as PCT_SalesbyCategory
from pizza_sales
where month (order_date) = 1 --this optional, 1 means January, display total_revenue in January
group by pizza_category

--Percentage of pizza sales by Pizza size
select pizza_size, cast(sum(total_price) as decimal (10,2)) as Total_Revenue,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal (10,2)) as PCT_SalesbySize
from pizza_sales
group by pizza_size
order by pizza_size

--Total pizza sold by pizza category
select pizza_category, sum(quantity) as Total_QuantitySold
from pizza_sales
group by pizza_category
order by Total_QuantitySold desc

--Top 5 pizza by revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc

--Bottom 5 pizza by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc

--Top 5 pizza by quantity
select top 5 pizza_name, sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc

--Bottom 5 pizza by Quantity
select top 5 pizza_name, sum (quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity asc

--Top 5 pizza by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_Order
from pizza_sales
group by pizza_name
order by Total_Order desc

--Bottom 5 pizza by total Oders
select top 5 pizza_name, count(distinct order_id) as Total_Order
from pizza_sales
group by pizza_name
order by Total_Order asc

--example another query
select top 5 pizza_name, count(distinct order_id) as total_order
from pizza_sales
where pizza_category = 'Classic'
group by pizza_name
order by total_order desc