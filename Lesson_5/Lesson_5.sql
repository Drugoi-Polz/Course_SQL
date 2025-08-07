-- объеденение заказов и клиентов по id
select o.order_id, o.order_date, c.contact_name
from orders o 
join customers c on o.customer_id = c.customer_id;

select * 
from orders o 
join customers c on o.customer_id = c.customer_id; 

-- объеденение товаров и категорий по id
select p.product_id, p.product_name, c.category_name
from products p 
join categories c on p.category_id = c.category_id
order by c.category_id;

-- разновидности синтаксиса
select *
from Products 
join Categories on Products.category_id = Categories.category_id;

-- Вывод количества покупателей из городов Германии
select c.city, count(o.customer_id), count(distinct o.customer_id) 
from orders o 
join customers c on o.customer_id = c.customer_id
where c.country = 'Germany' 
group by c.city;

-- Самостоятельная работа №2
select p.product_name, sum(od.unit_price * od.quantity * (1 - od.discount))
from order_details od 
join products p on od.product_id = p.product_id
group by p.product_name
order by p.product_name; --< по желанию 

-- Самостоятельная работа №3
select e.employee_id, e.first_name, e.last_name, count(o.order_id)
from employees e 
join orders o on e.employee_id = o.employee_id 
where e.first_name = 'Janet' and e.last_name = 'Leverling'
group by e.employee_id;

-- задача 1
select count(c.customer_id )
from customers c
where c.contact_title like '%Sales%'
	and c.region is null
	
-- задача 2
select c.contact_title, count(c.customer_id )
from customers c
group by c.contact_title
order by count(c.customer_id ) desc 
limit 1;

