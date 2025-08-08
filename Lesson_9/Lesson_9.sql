-- Функции для работы с числами
select 
	p.product_name, 
	round(p.unit_price::numeric, 1),--округляет число
	sqrt(p.unit_price), --выводит корень из числа
	pow(p.unit_price,2), --возводит число в степень
	div(p.unit_price::numeric,2), --Возвращает целочиселнное деление
	mod(p.unit_price::numeric,2) --Возвращает остаток от деления
from products p
order by 2 desc;

-- Функции для работы с датами
select 
	o.order_id,
	o.order_date,
	extract(year from order_date) as year,
	extract(month from order_date) as month,
	extract(day from order_date) as day,
	extract(quarter from order_date) as quarter,
	extract(week from order_date) as week
from orders o;

-- Пример 2
select 
	o.order_id,
	o.order_date,
	date_part('year', order_date) as year,
	date_part('month', order_date) as month,
	date_part('day', order_date) as day,
	date_part('quarter', order_date) as quarter,
	date_part('week', order_date) as week
from orders o;

-- Пример 3
select 
	order_date,
	date_trunc('year', order_date) as year,
	date_trunc('quarter', order_date) as quarter,
	date_trunc('month', order_date) as month,
	date_trunc('week', order_date) as week,
	date_trunc('day', order_date) as day
from orders o;

--текущий день, текущее время, текущий день и время
select current_date, current_time, current_timestamp, now();

--извлекаем часы/минуты
select 
	date_part('hour', now()) as hour,
	date_part('minute', now()) as minute;

--cчитаем разницу дней между датами
select shipped_date , order_date, shipped_date - order_date
from orders o 
limit 5;

-- Посчитать кол-во покупок по месяцам
select 
	date_trunc('month', o.order_date), 
	count(o.order_id) as count_in_month
from orders o
group by 1
order by 1

-- Самостоятельная работа №2
select count(*)
from orders o
where o.shipped_date - o.order_date <= 10

-- Самостоятельная работа №3
select date_part('quarter', o.order_date), count(o.order_id )
from orders o
where date_part('year', o.order_date) = '1997'
	and date_part('quarter', o.order_date) = '4'
group by 1

-- Самостоятельная работа №4
select count(*)
from orders o
where o.shipped_date is null