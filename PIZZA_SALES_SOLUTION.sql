--Retrieve the total number of orders placed.

SELECT COUNT(ORDER_ID)AS TOTAL_ORDER_PLACED FROM orders;

--Calculate the total revenue generated from pizza sales.

SELECT SUM(OD.quantity*P.PRICE) AS TOTAL_REVENUE_GENERATED 
FROM order_details OD
JOIN PIZZA P ON OD.pizza_id=P.PIZZA_ID;

--Identify the highest-priced pizza.

SELECT pt.name, p.price
FROM pizza_types pt
join pizza p on pt.pizza_type_id=p.pizza_type_id;



--Identify the most common pizza size ordered.

select p.size, count(od.order_detail_id) as total_order
FROM pizza p 
join order_details od 
on od.pizza_id = p.pizza_id
group by p.size
order by total_order DESC
limit 1;



--List the top 5 most ordered pizza types along with their quantities.

select pt.name, sum(od.quantity) as total
from pizza_types pt
join pizza p on 
p.pizza_type_id=pt.pizza_type_id
join order_details od 
on od.pizza_id = p.pizza_id
group by pt.name
order by total DESC
limit 5;


--Intermediate:
--Join the necessary tables to find the total quantity of each pizza category ordered.

select pt.category, sum(od.quantity) as tq
from pizza_types pt
join pizza p on p.pizza_type_id=pt.pizza_type_id
join order_details od on od.pizza_id=p.pizza_id
group by pt.category
order by tq;


--Determine the distribution of orders by hour of the day.

select extract(hour from time), count(order_id)
from orders
group by extract(hour from time)
order by count(order_id) desc;

select *from orders



--Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name)
from pizza_types
group by category;

select * from pizza_types

select pt.category, count(od.order_id) as orders_tt
from pizza_types pt
join pizza p 
on p.pizza_type_id = pt.pizza_type_id
join order_details od 
on od.pizza_id = p.pizza_id
group by pt.category
order by orders_tt;


--Group the orders by date and calculate the average number of pizzas ordered per day.

WITH group_orders_by_date as(
select o.date, sum(od.quantity) as order_pr_day
from orders o
join order_details od on od.order_id = o.order_id
group by o.date
order by order_pr_day
)
select avg(order_pr_day) from group_orders_by_date;

--Determine the top 3 most ordered pizza types based on revenue.

select pt.name, sum(od.quantity*p.price)
from pizza_types pt
join pizza p on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id
group by name
order by sum(od.quantity*p.price) DESC
limit 3;


--Calculate the percentage contribution of each pizza type to total revenue.

--with CTE

with total_revnue as(
	select  sum(od.quantity*p.price)as rev
	from pizza_types pt
	join pizza p on p.pizza_type_id = pt.pizza_type_id
	join order_details od on od.pizza_id = p.pizza_id
)
select pt.category, sum(od.quantity*p.price) , ((sum(od.quantity*p.price)/(select rev from total_revnue) *100)) as percent
from pizza_types pt
join pizza p on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id
group by pt.category
order by sum(od.quantity*p.price) DESC;



--with subquery

select pt.category, sum(od.quantity*p.price) , ((sum(od.quantity*p.price)/(
	select  sum(od.quantity*p.price)as rev
	from pizza_types pt
	join pizza p on p.pizza_type_id = pt.pizza_type_id
	join order_details od on od.pizza_id = p.pizza_id
))*100)as percent_contr
from pizza_types pt
join pizza p on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id
group by pt.category
order by sum(od.quantity*p.price) DESC






--Analyze the cumulative revenue generated over time.

WITH DAILY_SALES AS(
select o.date, sum(od.quantity*P.PRICE) as order_pr_day
from orders o
join order_details od on od.order_id = o.order_id
JOIN PIZZA P ON P.PIZZA_ID=OD.PIZZA_ID
group by o.date
order by O.DATE
)
SELECT DS.DATE, SUM(DS.order_pr_day) OVER(ORDER BY DS.date ) AS CUM_REVNUE
FROM DAILY_SALES DS;




--Determine the top 3 most ordered pizza types based on revenue for each pizza category.


WITH MOST_ORDERED_PIZZA AS(
SELECT PT.CATEGORY, PT.PIZZA_TYPE_ID, SUM(OD.QUANTITY*P.PRICE) AS TOTAL,
ROW_NUMBER() OVER(PARTITION BY PT.CATEGORY ORDER BY SUM(OD.QUANTITY*P.PRICE) ) AS ROW_NUM
from pizza_types pt
join pizza p on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id
group by pt.category, PT.PIZZA_TYPE_ID
)
SELECT*FROM MOST_ORDERED_PIZZA
WHERE ROW_NUM<=3;

