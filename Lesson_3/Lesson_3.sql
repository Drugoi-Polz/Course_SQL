-- Вывод покупателей:
select c.customer_id, c.contact_name,
	c.contact_title, c.country
from customers c;

-- Количество записей о покупателей:
select count(c.customer_id)
from customers c;

-- Количество записей о покупателей из лондона:
select count(c.customer_id)
from customers c
where c.city = 'London';

-- Информация о количестве не null записей различных столбцов 
select count(*), count(c.customer_id), count(c.country), count(c.city), count(c.region)  
from customers c;

-- Информация о количестве не null записей различных столбцов
select count(*) as count_lines,
	count(c.customer_id) as count_id,
	count(c.country) as count_countries, 
	count(c.city) as count_cities, 
	count(c.region) as count_regions  
from customers c;

-- Информация о количестве уникальных не null записей различных столбцов
select count(*) as count_lines,
	count(distinct c.customer_id) as count_id,
	count(distinct c.country) as count_countries, 
	count(distinct c.city) as count_cities, 
	count(distinct c.region) as count_regions  
from customers c;

-- Вывод максимальной цены
select p.unit_price 
from products p
order by p.unit_price desc
limit 1;


-- Вывод статистики цен на товары
select count(*) as count_products,
	min(p.unit_price) as min_price,  
	max(p.unit_price) as max_price,  
	avg(p.unit_price) as average_price,  
	sum(p.unit_price) as sum_price
from products p;

select sum(p.units_in_stock),
	round(sum(p.unit_price * p.units_in_stock))
from products p;

-- Самостоятельная работа 1
select
	round(min(p.unit_price)) as min_price,   
	round(avg(p.unit_price)) as average_price,
	round(max(p.unit_price)) as max_price 
from products p
where p.category_id = 3;

-- Самостоятельная работа 2
select count(distinct c.contact_title)
from customers c
where c.country = 'UK';

















