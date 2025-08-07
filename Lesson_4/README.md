# Четвертый урок 

---

#### **1. Повторение пройденного**  
- **Агрегирующие функции**: `COUNT`, `SUM`, `MIN`, `MAX`, `AVG`, `ROUND`.  
- **Оператор `DISTINCT`**: Возврат уникальных значений.  
- **Псевдонимы (`AS`)**: Присвоение имён столбцам.  

---

#### **2. Группировка данных (`GROUP BY`)**  
- **Для чего**: Агрегация данных по группам (например, сумма товаров по категориям).  
- **Синтаксис**:  
  ```sql
  SELECT столбец_группировки, агрегатная_функция(...)
  FROM таблица
  GROUP BY столбец_группировки;
  ```  
- **Пример**:  
  ```sql
  -- Количество клиентов в каждой стране
  SELECT country, COUNT(customer_id) 
  FROM customers
  GROUP BY country;
  ```  
  **Как это выглядит**:  
  | country   | count |  
  |-----------|-------|  
  | Germany   | 11    |  
  | France    | 11    |  
  | UK        | 7     |  

---

#### **3. Фильтрация групп (`HAVING`)**  
| Особенность         | `WHERE`                          | `HAVING`                          |  
|---------------------|----------------------------------|-----------------------------------|  
| **Когда применяется** | До группировки                  | После группировки                |  
| **Работа с агрегатами** | Нельзя использовать агрегаты   | Можно использовать агрегаты      |  
| **Пример**          | `WHERE country = 'Germany'`      | `HAVING COUNT(*) > 10`           |  

**Пример запроса**:  
```sql
-- Страны с >10 клиентами (кроме UK)
SELECT country, COUNT(customer_id) 
FROM customers
WHERE country != 'UK'
GROUP BY country
HAVING COUNT(customer_id) > 10;
```

---

#### **4. Группировка по нескольким столбцам**  
- **Для чего**: Анализ комбинаций параметров (например, страна + должность).  
- **Пример**:  
  ```sql
  -- Количество клиентов по странам и должностям
  SELECT country, contact_title, COUNT(customer_id)
  FROM customers
  GROUP BY country, contact_title
  ORDER BY country, COUNT(customer_id);
  ```  
  **Как это выглядит**:  
  | country   | contact_title          | count |  
  |-----------|------------------------|-------|  
  | Germany   | Sales Representative   | 5     |  
  | France    | Owner                  | 3     |  
  | UK        | Marketing Manager      | 2     |  

---

#### **5. Практические примеры**  
**Пример 1**: Сумма товаров по категориям (с округлением).  
```sql
SELECT 
    category_id,
    ROUND(SUM(unit_price * units_in_stock)) AS sum_price
FROM products
GROUP BY category_id
ORDER BY category_id;
```  

**Пример 2**: Статистика цен по категориям (кроме категории 4).  
```sql
SELECT 
    category_id,
    COUNT(product_id) AS products_count,
    MIN(unit_price) AS min_price,
    ROUND(AVG(unit_price)) AS avg_price,
    MAX(unit_price) AS max_price
FROM products
WHERE category_id != 4
GROUP BY category_id
HAVING 
    COUNT(product_id) >= 10 
    AND MIN(unit_price) > 5
ORDER BY category_id;
```  

---

#### **6. Самостоятельная работа**  
**Задание 1**:  
> Заказы в марте 1998 года с ровно 4 заказами в день.  
```sql
SELECT 
    order_date, 
    COUNT(order_id) AS orders_count
FROM orders
WHERE 
    order_date BETWEEN '1998-03-01' AND '1998-03-31'
GROUP BY order_date
HAVING COUNT(order_id) = 4;
```  
**Задание 2**:  
> Города с >3 клиентов.  
```sql
SELECT city, COUNT(customer_id) 
FROM customers
GROUP BY city
HAVING COUNT(customer_id) > 3;
```  
---

#### **7. Ключевые выводы**  
1. **`GROUP BY`** группирует данные для агрегации.  
2. **`HAVING`** фильтрует группы (аналогично `WHERE` для строк).  
3. **Группировка по нескольким столбцам** даёт детализацию.  
4. **Порядок операторов**:  
   ```sql
   SELECT ... FROM ... 
   WHERE ... 
   GROUP BY ... 
   HAVING ... 
   ORDER BY ...;
   ```  
