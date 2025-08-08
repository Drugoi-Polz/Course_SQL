-- Основные функции
select c.customer_id, 
	lower(c.company_name), --нижний регистр
	upper(c.company_name), --верхний регистр
	left(c.company_name, 5), --вывод символов слева
	right(c.company_name, 5), --вывод символов справа
	length(c.company_name) --кол-во символов в строке
from customers c

-- Конкатенация
select concat(e.first_name, ' ', e.last_name )
from employees e;

-- Замена текста
select 
	concat(regexp_replace(e.title_of_courtesy, 'Mr.', 'Mister'), ' ',
	e.first_name, ' ', e.last_name ) as full_name
from employees e 
where e.title_of_courtesy = 'Mr.'

-- Извлечение текста
select contact_title, substring(contact_title, 12,7) 
from customers c 
where c.contact_title = 'Accounting Manager';

-- Самостоятельная работа №1
select count(distinct c.country)
from customers c
where length(c.country ) > 10

-- Сложная задача
select 
	date_part('year', o.order_date) as year,
	date_part('month', o.order_date) as month,
	count(o.order_id) as all_orders,
	count(case when o.ship_country = 'USA' then o.order_id end) as USA_orders,
	round(count(case when ship_country = 'USA' then order_id end) / 
		count(order_id)::numeric, 2) as part_USA
from orders o
group by 1, 2
order by 5 desc limit 1;

