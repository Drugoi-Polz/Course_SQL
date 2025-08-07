# Третий урок

#### **1. Повторение пройденного**  
- **Логические операторы**: `AND`, `OR`, `BETWEEN`.  
- **Сортировка**: `ORDER BY` с `ASC/DESC`.  
- **Ограничение выборки**: `LIMIT`.  

---

#### **2. Агрегирующие функции**  
| Функция       | Описание                                  | Пример запроса                              |  
|---------------|-------------------------------------------|---------------------------------------------|  
| **COUNT()**   | Подсчёт количества строк/значений.        | `SELECT COUNT(customer_id) FROM customers;` |  
| **MIN()**     | Нахождение минимального значения.         | `SELECT MIN(unit_price) FROM products;`     |  
| **MAX()**     | Нахождение максимального значения.        | `SELECT MAX(unit_price) FROM products;`     |  
| **AVG()**     | Расчёт среднего значения.                 | `SELECT AVG(unit_price) FROM products;`     |  
| **SUM()**     | Суммирование значений.                    | `SELECT SUM(units_in_stock) FROM products;` |  
| **ROUND()**   | Округление чисел.                         | `SELECT ROUND(AVG(unit_price)) FROM ...;`   |  

**Особенности `COUNT`**:  
- `COUNT(*)` — считает все строки (включая `NULL`).  
- `COUNT(column)` — считает не-`NULL` значения в столбце.  
- `COUNT(DISTINCT column)` — считает уникальные значения.  

**Пример**:  
```sql
-- Статистика по товарам
SELECT 
    COUNT(*) AS total_products,
    MIN(unit_price) AS min_price,
    MAX(unit_price) AS max_price,
    ROUND(AVG(unit_price)) AS avg_price
FROM products;
```

---

#### **3. Псевдонимы (`AS`)**  
- **Для чего**: Присвоение понятных имён столбцам в результате.  
- **Пример**:  
  ```sql
  SELECT 
      COUNT(DISTINCT country) AS unique_countries
  FROM customers;
  ```

---

#### **4. Оператор `DISTINCT`**  
- **Для чего**: Возврат уникальных значений (исключает дубликаты).  
- **Примеры**:  
  ```sql
  -- Уникальные страны клиентов
  SELECT DISTINCT country FROM customers;
  
  -- Количество уникальных должностей
  SELECT COUNT(DISTINCT contact_title) FROM customers;
  ```

---

#### **5. Работа с выражениями**  
Агрегирующие функции можно комбинировать с арифметикой:  
```sql
-- Общая стоимость товаров на складе
SELECT SUM(unit_price * units_in_stock) AS total_value 
FROM products;
```
**Результат**:  
| total_value |  
|-------------|  
| 135 678.95  |  

---

#### **6. Самостоятельная работа**  
**Задание 1**:  
> Статистика по товарам категории 3 (округлить до целого).  
```sql
SELECT 
    ROUND(MIN(unit_price)) AS min_price,
    ROUND(AVG(unit_price)) AS avg_price,
    ROUND(MAX(unit_price)) AS max_price
FROM products
WHERE category_id = 3;
```
**Ответ**:  
| min_price | avg_price | max_price |  
|-----------|-----------|-----------|  
| 10        | 37        | 43        |  

**Задание 2**:  
> Уникальные должности клиентов из Великобритании.  
```sql
SELECT COUNT(DISTINCT contact_title) 
FROM customers 
WHERE country = 'UK';
```
**Ответ**: `3` (пример: `Owner`, `Sales Manager`).  

---

#### **7. Вопросы для самопроверки**  
1. **Как вывести уникальные даты заказов?**  
   ```sql
   SELECT DISTINCT order_date FROM orders;
   ```  
2. **Как посчитать уникальные ID категорий?**  
   ```sql
   SELECT COUNT(DISTINCT category_id) FROM products;
   ```  

---

#### **8. Ключевые выводы**  
1. **Агрегирующие функции** упрощают анализ данных:  
   - `COUNT`, `MIN`, `MAX`, `AVG`, `SUM`.  
2. **`DISTINCT`** исключает дубликаты.  
3. **`AS`** делает результаты запроса понятнее.  
4. **`ROUND()`** округляет числа для удобства.  
5. **Комбинации функций** с арифметикой:  
   ```sql
   SELECT SUM(unit_price * quantity) FROM order_details;
   ```
