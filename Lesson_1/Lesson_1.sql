-- Вывод всех товаров
select *
from products p;

-- Вывод названия и стоимости товаров
select p.product_name, p.unit_price
from products p;

-- Вывод всей информации из т.Категрии
select * 
from categories c ;

-- Вывод id и name в т. Категории
select c.category_id, c.category_name 
from categories c ;

-- Фильтрация по названию
select *
from products p 
where p.product_name = 'Chai';

-- Фильтрация по списку
select *
from products p
where product_name in ('Tofu', 'Chang', 'Konbu');

-- Фильтрация по null-строкам
select *
from customers c 
where c.region is null;

-- Фильтрация по null-строкам
select *
from customers c 
where c.region is not null;

-- Фильтрация по исключающему списку
select *
from products p
where product_name not in ('Tofu', 'Chang', 'Konbu');

-- Фильтрация по строчному значению
select *
from products p
where product_name < 'Ikura';

-- Фильтрация по дате
select *  
from orders  
where order_date < '1996-07-09'

--Фильтрация по шаблону
select  c.contact_name, c.contact_title
from customers c 
where c.contact_title like 'Sales%';

select c.contact_name, c.contact_title
from customers c 
where c.contact_title like 'A%';

select c.contact_name, c.contact_title 
from customers c 
where c.contact_title like '%Manager'

select c.contact_name, c.contact_title 
from customers c 
where c.contact_title like '%Sales%'

--Клиенты из Испании
select c.contact_name, c.country 
from customers c 
where c.country = 'Spain'

--Клиенты чьи имена начинаются на «M» 
select c.customer_id, c.contact_name 
from customers c 
where c.contact_name like 'M%'

--Клиенты чьи номера заканчиваются на 88 
select c.contact_name, c.phone
from customers c 
where c.phone like '%88'
