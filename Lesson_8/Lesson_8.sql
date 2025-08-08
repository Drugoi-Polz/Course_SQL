-- Пример 1 
select c.customer_id, c.contact_name,
	case when c.region is null 
	then 'undefined' 
	else c.region 
	end as region_new
from customers c 

-- Пример 2
select case when c.country in ('Argentina', 'Brazil') then 'South America'
	when c.country in ('Canada') then 'North America'
	when c.country in ('Portugal', 'Spain') then 'Europe' end as continent,
	count (c.customer_id)
from customers c
where c.country in ('Argentina', 'Brazil', 'Portugal','Canada', 'Spain')
group by 1
order by 2 desc

-- Пример 3
with profit_table as (
	select od.order_id, sum(od.unit_price * od.quantity * (1 - od.discount)) as Profit,
		case 
			when sum(od.unit_price*od.quantity*(1-od.discount)) between 1 and 999 then '0-999'
	        when sum(od.unit_price*od.quantity*(1-od.discount)) between 1000 and 4999 then '1000-4999'
	        when sum(od.unit_price*od.quantity*(1-od.discount)) >=5000 then '5000 and >' 
	    end as profit_category
	from order_details od
	group by 1
)
select pt.profit_category, count(pt.order_id)
from profit_table as pt
group by 1

-- Самостоятельная работа №1
with region_table as (
	select c.contact_name, c.city,
		case when c.region is null then 'undefined' 
		else c.region end as region_new
	from customers c)
select count(*) as count_undefined
from region_table rt
where rt.region_new = 'undefined'

-- Самостоятельная работа №2
select gender_employees.gender,
	count(*)
from 
	(
	select e.first_name, e.last_name, e.title_of_courtesy,
		case 
			when e.title_of_courtesy in ('Ms.', 'Mrs.') then 'women'
			when e.title_of_courtesy in ('Dr.', 'Mr.') then 'men'
		end as gender
	from employees e
	) as gender_employees
group by 1

-- Война запросов
with t_1 as (
	select p.product_name , p.unit_price,
		case
			when p.unit_price between 1 and 9.99 then '0-9.99'
			when p.unit_price between 10 and 29.99 then '10-29.99'
			when p.unit_price between 30 and 49.99 then '30-49.99'
			else '50+'
		end as price_category
	from products p
)
select t_1.price_category, count(*)
from t_1
where t_1.price_category = '50+'
group by 1




















