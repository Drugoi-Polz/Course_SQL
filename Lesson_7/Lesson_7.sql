-- Сумма клиентов по странам (где клиентов >= 3)
with table_1 as
	(
		select c.country, 
			count(c.customer_id) as count_customers
		from customers c 
		group by c.country
		having count(c.customer_id) >= 3
	)
select sum(table_1.count_customers)
from table_1;

-- Количество дней, когда было больше 2 заказов
select count(*)
from 
	(
	select 
		order_date, 
		count(order_id) count_orders
	from orders o 
	group by order_date
	having count(order_id) > 2
	order by count(order_id)
	) as t_1;

-- Количество клиентов с более чем 10 заказами (подзапрос)
select count(*)
from 
	(
	select 
		o.customer_id, 
		count(o.order_id) as count_orders
	from orders o
	group by o.customer_id
	having count(o.order_id) > 10
	) as t_1;

-- Количество клиентов с более чем 10 заказами
with t_1 as
	(
	select 
		o.customer_id, 
		count(o.order_id) as count_orders
	from orders o
	group by o.customer_id
	having count(o.order_id) > 10
	)
select count(t_1.count_orders)
from t_1;

-- Клиенты из Парижа, Берлина или Лондона
select c.customer_id
from customers c
where c.city in ('Paris', 'Berlin', 'London')

-- Общая сумма заказов для товаров категории 1 (подзапрос)
select *
from orders o
where o.customer_id in (
	select c.customer_id
	from customers c
	where c.city in ('Paris', 'Berlin', 'London')
	);

-- Общая сумма заказов для товаров категории 1 
select 
	round(sum(od.unit_price * od.quantity * (1 - od.discount))) as result_sum
from order_details od
where od.product_id in (
		select p.product_id 
		from products p 
		where p.category_id = 1
	)

-- Общая сумма заказов для товаров категории 1
with t_1 as 
	(
	select 
		p.product_name, 
		sum(od.unit_price * od.quantity * (1 - od.discount)) as result_sum
	from products p
	inner join order_details od 
		on p.product_id = od.product_id
	where p.category_id = 1
	group by p.product_name
	)
select round(sum(t_1.result_sum)) 
from t_1;

-- Связь заказов с товарами
select o.order_id, od.product_id	
from orders o
join order_details od on o.order_id = od.order_id

-- Количество заказов с товаром 'Chocolade'
select 
	count(distinct od.order_id)
from products p
join order_details od 
on p.product_id = od.product_id
where p.product_name = 'Chocolade';

-- Общая прибыль по категории 'Confections'
select round(sum(od.unit_price * od.quantity * (1 - od.discount)))
	as total_profit
from order_details od 
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id 
where c.category_name = 'Confections'

-- Категория с максимальной прибылью
select c.category_name, round(sum(od.unit_price * od.quantity * (1 - od.discount)))
	as total_profit
from order_details od 
join products p on od.product_id = p.product_id
join categories c on p.category_id = c.category_id 
group by c.category_name
order by total_profit desc 
limit 1

-- Сотрудник, который обрабатывал заказ Simon Crowther 29.04.1998
select e.employee_id, e.first_name, e.last_name
from employees e
where e.employee_id in (
	select o.employee_id
	from orders o
	where o.order_date = '1998-04-29' 
		and	o.customer_id in (
			select c.customer_id 
			from customers c
			where c.contact_name = 'Simon Crowther'
		)
	);

-- Количество городов с более чем 5 заказами в 1997 году
with t_1 as (
	select o.ship_city, count(o.order_id)
	from orders o
	where o.order_date between '1997-01-01' and '1997-12-31'
	group by o.ship_city
	having count(o.order_id) > 5
	)
select count(*)
from t_1


