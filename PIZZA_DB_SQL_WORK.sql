

CREATE DATABASE pizzadb;
USE pizzadb;
-- REMINDER: Import data from pizza_sales.CSV
select * from pizza_sales;

-- 1. TOTAL REVENUE
select * from Total_revenue;

-- 2. AVERAGE ORDER VALUE 
select * from Average_order_value;

-- 3. TOTAL PIZZA'S SOLD 
select * from Total_pizzas_sold;

-- 4. TOTAL ORDER'S 
select * from Total_orders;

-- 5. AVERAGE PIZZA'S PER ORDER
select * from Average_pizza_per_order;

-- 6. DAILY TREND OF ORDERS
select * from daily_trends_of_orders; 

-- 7. MONTHLY TRENDS OF ORDERS
select * from Monthly_trends_of_orders;

-- 8. PERCENTAGE OF SALES BY PIZZA CATEGORY
select * from pct_by_pizza_category;

-- 9. PERCENTAGE OF SALES BY PIZZA SIZE
select * from pct_by_pizza_size;

-- 10. TOP 5 PIZZA'S BY REVENUE
select * from top_5_pizzas_by_revenue;

-- 11. BOTTOM 5 PIZZA'S BY REVENUE
select * from Bottom_5_pizzas_by_revenue;

-- 12. TOP 5 PIZZA'S BY QUANTITY
select * from top_5_pizzas_by_Quantity;

-- 13. BOTTOM 5 PIZZA'S BY QUANTITY
select * from Bottom_5_pizzas_by_Quantity;

-- 14. TOP 5 PIZZA'S BY COUNT OF ORDERS
select * from top_5_pizzas_by_orders;

-- 15. BOTTOM 5 PIZZA'S BY COUNT OF ORDERS
select * from Bottom_5_pizzas_by_orders;



-- 1. TOTAL REVENUE
create view Total_revenue as select sum(total_price) as "TOTAL REVENUE" from pizza_sales;

-- 2. AVERAGE ORDER VALUE 
create view Average_order_value as  select sum(total_price)/ count(distinct(order_id)) as "AVERAGE ORDER VALUE" from pizza_sales;

-- 3. TOTAL PIZZA'S SOLD 
create view Total_pizzas_sold as select sum(quantity) as "TOTAL PIZZA'S SOLD" from pizza_sales;

-- 4. TOTAL ORDER'S 
create view Total_orders as select count(distinct(order_id)) as "TOTAL ORDER'S" from pizza_sales;

-- 5. AVERAGE PIZZA'S PER ORDER
create view Average_pizza_per_order as select cast(sum(quantity)/ count(distinct(order_id)) as decimal(10,2)) as "AVERAGE PIZZA'S PER ORDER" from pizza_sales;

-- 6. DAILY TREND OF ORDERS
create view daily_trends_of_orders as select datename(DW,order_date) as "DAY", count(distinct(order_id)) AS "TOTAL ORDERS" from pizza_sales group by datename(DW,order_date); 

-- 7. MONTHLY TRENDS OF ORDERS
create view Monthly_trends_of_orders as Select datename(MONTH,order_date) as "MONTH NAME", count(distinct(order_id)) AS TOTAL_ORDERS from pizza_sales group by datename(MONTH,order_date);

-- 8. PERCENTAGE OF SALES BY PIZZA CATEGORY
create view pct_by_pizza_category as select pizza_category, cast(sum(total_price) as decimal(10,2)) as "TOTAL SALES" , cast(sum(total_price)  * 100 /(select sum(total_price) from pizza_sales) as decimal(10,2)) as "PERCENTAGE OF SALES" 
from pizza_sales group by pizza_category;

-- 9. PERCENTAGE OF SALES BY PIZZA SIZE
create view pct_by_pizza_size as select pizza_size, cast(sum(total_price) as decimal(10,2))  as "TOTAL SALES"  , cast(sum(total_price)  * 100 /(select sum(total_price) from pizza_sales) as decimal(10,2)) as "PERCENTAGE OF SALES" 
from pizza_sales group by pizza_size;

-- 10. TOP 5 PIZZA'S BY REVENUE
create view top_5_pizzas_by_revenue as  select TOP 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as TOTAL_REVENUE from pizza_sales group by pizza_name order by TOTAL_REVENUE DESC;

-- 11. BOTTOM 5 PIZZA'S BY REVENUE
create view Bottom_5_pizzas_by_revenue as  select TOP 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as TOTAL_REVENUE from pizza_sales group by pizza_name order by TOTAL_REVENUE;

-- 12. TOP 5 PIZZA'S BY QUANTITY
create view top_5_pizzas_by_Quantity as select TOP 5 pizza_name, sum(quantity) As TOTAL_QUANTITY from pizza_sales group by pizza_name order by TOTAL_QUANTITY desc;

-- 13. BOTTOM 5 PIZZA'S BY QUANTITY
create view Bottom_5_pizzas_by_Quantity as select TOP 5 pizza_name, sum(quantity) As TOTAL_QUANTITY from pizza_sales group by pizza_name order by TOTAL_QUANTITY;

-- 14. TOP 5 PIZZA'S BY COUNT OF ORDERS
create view top_5_pizzas_by_orders as select TOP 5 pizza_name,count(distinct(order_id)) As TOTAL_ORDERS from pizza_sales group by pizza_name order by TOTAL_ORDERS desc;

-- 15. BOTTOM 5 PIZZA'S BY COUNT OF ORDERS
create view Bottom_5_pizzas_by_orders as select TOP 5 pizza_name,count(distinct(order_id)) As TOTAL_ORDERS from pizza_sales group by pizza_name order by TOTAL_ORDERS;