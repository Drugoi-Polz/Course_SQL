-- Самостоятельная работа №1
select p.category_id, round(sum(p.unit_price * p.units_in_stock )) as Sum_Price_In_Category
from products p 
group by p.category_id
order by p.category_id;

-- Вывод покупателей
select c.customer_id, c.contact_name, c.contact_title, c.country 
from customers c;

-- Количество уникальных стран среди клиентов
select count(distinct c.country )
from customers c; 

-- Количество клиентов из разных стран
select c.country, count(c.customer_id)
from customers c 
group by c.country; 

-- Количество клиентов из разных стран с фильтрацией
select c.country, count(c.customer_id)
from customers c 
where c.country != 'UK'
group by c.country
having count(c.customer_id) > 10;

-- Вывод товаров:
select p.category_id,
	count(p.product_id),
	min(p.unit_price), 
	avg(p.unit_price),
	max(p.unit_price)
from products p
where p.category_id != 4
group by p.category_id
having count(p.product_id) >= 10 and min(p.unit_price) > 5
order by p.category_id;

-- Города и количество клиентов
select c.country, count(c.customer_id)  
from customers c  
group by c.country  
having count(c.customer_id) > 5  
order by count(c.customer_id);

select c.country, count(*)  
from customers c  
group by c.country  
having count(*) > 5  
order by count(*);

-- Клиенты с должностью "Sales Representative" из германии
select c.customer_id, c.contact_name, c.contact_title, c.country 
from customers c
where c.country = 'Germany'
and c.contact_title = 'Sales Representative'
order by c.country;  

-- Города и количество клиентов Sales Representative 
select c.country, count(c.customer_id)
from customers c
where c.contact_title = 'Sales Representative'
group by c.country
order by count(c.customer_id) desc;  

-- Города и количество клиентов по должностям
select c.country, c.contact_title, count(c.customer_id)
from customers c
group by c.country, c.contact_title 
order by c.country, count(c.customer_id);

-- Дни марта 1998 года с 4 заказами 
select o.order_date, count(o.order_id)
from orders o
where o.order_date BETWEEN '1998-03-01' AND '1998-03-31'
group by o.order_date
having count(o.order_id) = 4
order by o.order_date;

-- Города с более чем 3 клиентами
select c.city, count(c.customer_id)
from customers c 
group by c.city
having count(c.customer_id) > 3;




