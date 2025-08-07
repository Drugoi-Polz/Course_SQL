# Седьмой урок

### Конспект по уроку "Подзапросы в SQL"

---

#### **1. Что такое подзапросы?**
- Запросы, вложенные внутрь других запросов.
- Используются для:
  - Создания временных таблиц для дальнейшей обработки.
  - Фильтрации данных.
  - Упрощения сложных вычислений.

---

#### **2. Типы подзапросов**
**a) Подзапросы в `FROM`**  
Создают временную таблицу для основного запроса:
```sql
SELECT table_1.count_customers
FROM (
    SELECT country, COUNT(customer_id) AS count_customers
    FROM customers
    GROUP BY country
    HAVING COUNT(customer_id) >= 3
) AS table_1;
```

**b) Подзапросы в `WHERE`**  
Фильтруют данные по результату внутреннего запроса:
```sql
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE city IN ('Paris', 'Berlin', 'London')
);
```

**c) CTE (Common Table Expressions)**  
Улучшают читаемость через оператор `WITH`:
```sql
WITH table_1 AS (
    SELECT country, COUNT(customer_id) AS count_customers
    FROM customers
    GROUP BY country
    HAVING COUNT(customer_id) >= 3
)
SELECT SUM(count_customers) FROM table_1;
```

---

#### **3. Практические примеры**
**Задача 1**: Клиенты с >10 заказов + их количество  
```sql
-- Способ 1 (подзапрос в FROM)
SELECT COUNT(*) 
FROM (
    SELECT customer_id, COUNT(order_id) AS count_orders
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 10
) AS t_1;

-- Способ 2 (CTE)
WITH t_1 AS (
    SELECT customer_id, COUNT(order_id) AS count_orders
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 10
)
SELECT COUNT(*) FROM t_1;
```

**Задача 2**: Выручка по товарам категории 1 (округлить)  
```sql
SELECT ROUND(SUM(unit_price * quantity * (1 - discount))) AS result_sum
FROM order_details
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE category_id = 1
);
```
---

#### **4. Решение задач с подзапросами**
**Задача**: Общая выручка категории *Confections*  
```sql
SELECT ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))) 
FROM order_details od
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE category_id = (
        SELECT category_id FROM categories WHERE category_name = 'Confections'
    )
);
```
---

#### **5. Важные приёмы**
1. **Агрегация после группировки**:
   ```sql
   SELECT COUNT(*)
   FROM (
        SELECT ship_city, COUNT(order_id)
        FROM orders
        WHERE EXTRACT(YEAR FROM order_date) = 1997
        GROUP BY ship_city
        HAVING COUNT(order_id) > 5
   ) AS filtered_cities;
   ```

2. **Поиск данных через связанные таблицы**:
   ```sql
   SELECT employee_id, first_name, last_name
   FROM employees
   WHERE employee_id = (
        SELECT employee_id
        FROM orders
        WHERE order_date = '1998-04-29'
        AND customer_id = (
            SELECT customer_id FROM customers 
            WHERE contact_name = 'Simon Crowther'
        )
   );
   ```
---

#### **6. Итоги урока**
- **Подзапросы в `FROM`**: Для создания временных таблиц.
- **Подзапросы в `WHERE`**: Для фильтрации по условию.
- **CTE**: Улучшение читаемости сложных запросов.
- **Применение**: 
  - Анализ данных с агрегацией (`SUM`, `COUNT`).
  - Решение многошаговых задач (например, поиск через цепочку связей). 
