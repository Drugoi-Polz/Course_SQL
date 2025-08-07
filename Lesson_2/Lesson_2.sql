 -- Вывод покупателей:
select *
from customers c
where c.country = 'Germany'
	or c.city = 'Paris';

-- Вывод покупателей:
select *
from customers c
where c.country = 'Germany'
	and c.city like 'B%';

-- Вывод товаров:
select p.product_name, p.unit_price
from products p
where p.unit_price >= 10
	and p.unit_price <= 15;

-- Вывод товаров:
select p.product_name, p.unit_price
from products p 
where unit_price between 10 and 15;

select o.order_id, o.order_date
from orders o 
where o.order_date between '1996-07-09' and '1996-07-12';

-- самостоятельная работа №1
select c.contact_name, c.contact_title
from customers c 
where c.country = 'USA'
	and c.contact_title = 'Marketing Assistant';
	
-- самостоятельная работа №2
select p.product_name, p.unit_price
from products p 
where p.unit_price > 100 
	or p.product_name = 'Chai';

-- Вывод товаров:
select p.product_name, p.unit_price, p.units_in_stock
from products p
order by p.unit_price, p.units_in_stock;

-- Вывод отсортированных товаров:
select p.product_name, p.unit_price, p.units_in_stock
from products p
order by p.unit_price desc, p.units_in_stock asc;

-- Вывод клиентов
select c.contact_name, c.country
from customers c 
where c.country = 'France'
order by c.contact_name
limit 3;

--самостоятельная работа №3
select *
from orders o
where o.order_date ='1998-02-26'
order by o.freight desc
limit 1;

--самостоятельная работа №4
select *
from orders o
where o.order_date ='1998-02-26'
order by o.employee_id, o.freight
limit 1;





