# Пятый урок

#### **1. Ключи в БД**
- **Первичный ключ (Primary Key)**  
  - Уникальный идентификатор записи в таблице  
  - Пример: `order_id` в таблице `orders`  
- **Внешний ключ (Foreign Key)**  
  - Ссылка на первичный ключ другой таблицы  
  - Пример: `customer_id` в таблице `orders` → ссылается на `customer_id` в `customers`  

---

#### **2. Типы связей между таблицами**
| Тип связи             | Описание                                                                 | Пример                          |
|-----------------------|--------------------------------------------------------------------------|---------------------------------|
| **Один-к-одному**     | Одна запись в таблице А → одна запись в таблице Б                         | Гражданин ↔ Паспорт             |
| **Один-ко-многим**    | Одна запись в таблице А → несколько записей в таблице Б                  | Клиент ↔ Заказы                 |
| **Многие-ко-многим**  | Реализуется через промежуточную таблицу (bridge table)                  | Заказы ↔ Товары (через `order_details`) |

---

#### **3. Оператор `JOIN`**
- **Назначение**: Объединение данных из разных таблиц по условию  
- **Основные типы**:  
  ```sql
  INNER JOIN  -- (или просто JOIN): только совпадающие записи
  LEFT JOIN   -- все записи из левой таблицы + совпадения справа
  RIGHT JOIN  -- все записи из правой таблицы + совпадения слева
  FULL JOIN   -- все записи из обеих таблиц
  CROSS JOIN  -- декартово произведение (все со всеми)
  ```

- **Синтаксис**:  
  ```sql
  SELECT столбцы
  FROM таблица1
  JOIN таблица2 ON условие_связи
  ```

- **Пример**:  
  ```sql
  -- Заказы + имена клиентов
  SELECT o.order_id, o.order_date, c.contact_name
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id;
  ```

---

#### **4. Практические примеры**
**Задача 1**: Города Германии + количество покупателей  
```sql
SELECT c.city, COUNT(DISTINCT o.customer_id)
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Germany'
GROUP BY c.city;
```

**Задача 2**: Общая выручка по продуктам (с учётом скидок)  
```sql
SELECT 
    p.product_name,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name;
```

**Задача 3**: Количество заказов сотрудника Janet Leverling  
```sql
SELECT 
    e.employee_id, 
    e.first_name, 
    e.last_name, 
    COUNT(o.order_id) AS order_count
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
WHERE e.first_name = 'Janet' AND e.last_name = 'Leverling'
GROUP BY e.employee_id;
```

---

#### **5. Важные заметки**
1. **Алиасы таблиц**:  
   - Можно использовать `AS` или пробел:  
     ```sql
     SELECT * FROM products AS p  -- эквивалентно
     SELECT * FROM products p     -- 
     ```
2. **Регистр имён**:  
   - В SQL регистр не важен: `Products` = `products` (зависит от СУБД).  
3. **Группировка после JOIN**:  
   - `GROUP BY` применяется после объединения таблиц.  

---

#### **6. Итоги урока**
- Изучены типы связей: **1:1**, **1:N**, **N:M**.  
- Освоен оператор `JOIN` для объединения таблиц.  
- Практика: решения задач с агрегацией (`SUM`, `COUNT`) и фильтрацией (`WHERE`, `HAVING`).  
