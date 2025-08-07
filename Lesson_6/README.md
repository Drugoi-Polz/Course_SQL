# Шестой урок

#### **1. Работа с несколькими таблицами через JOIN**
- **Объединение 3+ таблиц**:  
  ```sql
  SELECT c.contact_name, e.first_name, e.last_name
  FROM orders o
  JOIN employees e ON o.employee_id = e.employee_id
  JOIN customers c ON o.customer_id = c.customer_id
  WHERE e.first_name = 'Andrew' AND e.last_name = 'Fuller';
  ```
- **Устранение дубликатов**:  
  `DISTINCT` для уникальных значений (например, клиенты с несколькими заказами).  

---

#### **2. LEFT JOIN**
- **Назначение**: Возвращает все строки из левой таблицы + совпадения из правой. Если совпадений нет → `NULL`.  
- **Пример**: Количество заказов для каждого клиента (включая тех, у кого заказов нет):  
  ```sql
  SELECT c.contact_name, COUNT(o.order_id) AS order_count
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id;
  ```
- **Фильтрация по отсутствию заказов**:  
  ```sql
  -- Клиенты без заказов
  SELECT c.city
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id
  HAVING COUNT(o.order_id) = 0;
  ```

---

#### **3. Операторы для работы с наборами**
| Оператор   | Описание                                                                 | Пример                              |
|------------|--------------------------------------------------------------------------|-------------------------------------|
| **UNION**  | Объединяет результаты двух запросов (уникальные значения).               | ```sql
SELECT contact_title FROM customers
UNION
SELECT title FROM employees; ``` |
| **UNION ALL** | Объединяет результаты с дубликатами.                                  | ```sql
... UNION ALL ... ```              |
| **EXCEPT** | Возвращает строки из первого запроса, отсутствующие во втором.           | ```sql
SELECT contact_title FROM customers
EXCEPT
SELECT title FROM employees; ``` |
| **INTERSECT** | Возвращает общие строки для двух запросов.                            | ```sql
... INTERSECT ... ```             |

---

#### **4. Практические примеры**
**Задача 1**: Уникальные города клиентов и сотрудников  
```sql
SELECT city FROM customers
UNION
SELECT city FROM employees;
```

**Задача 2**: Должности, которые есть только у клиентов  
```sql
SELECT contact_title FROM customers
EXCEPT
SELECT title FROM employees;
```

**Задача 3**: Общие должности клиентов и сотрудников  
```sql
SELECT contact_title FROM customers
INTERSECT
SELECT title FROM employees;
```

---

#### **5. Важные заметки**
1. **Порядок таблиц в `LEFT JOIN`**:  
   `FROM A LEFT JOIN B` ≠ `FROM B LEFT JOIN A`.  
2. **`UNION` vs `UNION ALL`**:  
   - `UNION` удаляет дубликаты, `UNION ALL` сохраняет.  
3. **Совместимость наборов**:  
   - Запросы в `UNION/EXCEPT/INTERSECT` должны иметь одинаковое число столбцов и совместимые типы данных.  

---

#### **6. Итоги урока**
- **Многотабличные JOIN**: Объединение 3+ таблиц для сложных запросов.  
- **LEFT JOIN**: Анализ данных с учётом отсутствующих значений.  
- **Операторы наборов**:  
  - `UNION` — объединение данных,  
  - `EXCEPT` — вычитание наборов,  
  - `INTERSECT` — пересечение наборов.  
