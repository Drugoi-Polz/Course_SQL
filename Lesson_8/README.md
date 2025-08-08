# Восьмой урок

#### **1. Что было пройдено ранее**
- Подзапросы и их использование  
- Команда `WITH` для создания временных таблиц  

---

#### **2. Условная конструкция CASE**
**Назначение:**  
- Замена `NULL` значений на понятные метки (например, `'undefined'`).  
- Классификация данных по заданным условиям (сегментация).  

**Синтаксис:**  
```sql
SELECT 
    column1,
    CASE 
        WHEN условие1 THEN результат1
        WHEN условие2 THEN результат2
        ELSE результат_по_умолчанию
    END AS new_column_name
FROM table_name;
```

**Примеры:**  
1. **Замена NULL:**  
   ```sql
   SELECT 
       customer_id, 
       contact_name,
       CASE WHEN region IS NULL THEN 'undefined' ELSE region END AS region_new
   FROM customers;
   ```

2. **Классификация стран по континентам:**  
   ```sql
   SELECT 
       contact_name, 
       country,
       CASE 
           WHEN country IN ('Argentina', 'Brazil') THEN 'South America'
           WHEN country = 'Canada' THEN 'North America'
           WHEN country IN ('Portugal', 'Spain') THEN 'Europe'
       END AS continent
   FROM customers;
   ```

3. **Сегментация выручки:**  
   ```sql
   SELECT 
       order_id,
       SUM(unit_price * quantity * (1 - discount)) AS profit,
       CASE
           WHEN SUM(...) BETWEEN 1 AND 999 THEN '0-999'
           WHEN SUM(...) BETWEEN 1000 AND 4999 THEN '1000-4999'
           WHEN SUM(...) >= 5000 THEN '5000+'
       END AS profit_category
   FROM order_details
   GROUP BY order_id;
   ```

---

#### **3. Практические задания**
**Самостоятельная работа №1:**  
- Замена `NULL` в регионе на `'undefined'` и подсчет таких записей.  
  ```sql
  WITH region_table AS (
      SELECT 
          contact_name, 
          city,
          CASE WHEN region IS NULL THEN 'undefined' ELSE region END AS region_new
      FROM customers
  )
  SELECT COUNT(*) AS count_undefined
  FROM region_table
  WHERE region_new = 'undefined';
  ```

**Самостоятельная работа №2:**  
- Определение пола сотрудников по обращению (`title_of_courtesy`).  
  ```sql
  SELECT 
      gender, 
      COUNT(*)
  FROM (
      SELECT 
          first_name,
          CASE 
              WHEN title_of_courtesy IN ('Ms.', 'Mrs.') THEN 'women'
              WHEN title_of_courtesy IN ('Mr.', 'Dr.') THEN 'men'
          END AS gender
      FROM employees
  ) AS gender_employees
  GROUP BY gender;
  ```

---

#### **4. Игра "Война запросов"**
**Задача:**  
- Сегментация товаров по цене (`0-9.99`, `10-29.99`, `30-49.99`, `50+`).  
- Подсчет количества товаров в каждом сегменте.  

**Решение:**  
```sql
SELECT 
    price_segment, 
    COUNT(*)
FROM (
    SELECT 
        product_name,
        unit_price,
        CASE
            WHEN unit_price BETWEEN 0 AND 9.99 THEN '0-9.99'
            WHEN unit_price BETWEEN 10 AND 29.99 THEN '10-29.99'
            WHEN unit_price BETWEEN 30 AND 49.99 THEN '30-49.99'
            WHEN unit_price >= 50 THEN '50+'
        END AS price_segment
    FROM products
) AS segmented_products
GROUP BY price_segment;
```

---

#### **5. Итоги урока**
- Освоили `CASE` для условной логики в SQL.  
- Научились комбинировать `CASE` с подзапросами и агрегацией.  
- Применили знания на практике и в игровом формате.  
