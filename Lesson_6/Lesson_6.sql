-- Количество товаров в каждой категории
select c.category_name, count(p.product_id)
from products p
join categories c on p.category_id = c.category_id
group by c.category_name
order by count(distinct p.product_id);

-- Клиенты, обслуживаемые сотрудником Andrew Fuller
select distinct c.contact_name , e.first_name, e.last_name 
from orders o
join employees e on o.employee_id = e.employee_id
join customers c on o.customer_id = c.customer_id
where e.first_name = 'Andrew' and e.last_name = 'Fuller'
order by c.contact_name;

-- Количество заказов для каждого клиента
select c.contact_name, count(o.order_id)
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id
order by count(o.order_id);

-- Клиенты, которые не делали заказов (по городам)
select c.city, count(o.order_id)
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) = 0;

-- Объединение всех должностей клиентов и сотрудников
select distinct c.contact_title
from customers c
union
select distinct e.title
from employees e;

-- Должности клиентов, которых нет у сотрудников
select distinct c.contact_title
from customers c
except
select distinct e.title
from employees e;

-- Общие должности у клиентов и сотрудников
select distinct c.contact_title
from customers c
intersect
select distinct e.title
from employees e;

-- Все города, где есть клиенты или сотрудники
select distinct c.city 
from customers c
union
select distinct e.city 
from employees e;



