# Второй урок

#### **1. Повторение пройденного**  
- **Базовые операции**:  
  `SELECT`, `WHERE`, `LIKE`, фильтрация по датам и тексту.  
- **Примеры запросов**:  
  ```sql
  -- Фильтрация товаров
  SELECT * FROM products WHERE product_name = 'Chai';
  
  -- Фильтрация заказов по дате
  SELECT * FROM orders WHERE order_date < '1996-07-09';
  
  -- Поиск по шаблону
  SELECT contact_name, contact_title FROM customers 
  WHERE contact_title LIKE 'Sales%';
  ```

---

#### **2. Логические операторы**  
| Оператор | Описание                                  | Пример запроса                              |
|----------|-------------------------------------------|---------------------------------------------|
| **AND**  | Вернет `TRUE`, если оба условия истинны.  | `WHERE country = 'Germany' AND city LIKE 'B%'` |
| **OR**   | Вернет `TRUE`, если хотя бы одно условие истинно. | `WHERE country = 'Germany' OR city = 'Paris'` |
| **BETWEEN**| Фильтрация по диапазону (числа, даты, текст). | `WHERE unit_price BETWEEN 10 AND 15`        |

**Примеры**:  
```sql
-- Клиенты из Германии или Парижа:
SELECT * FROM customers 
WHERE country = 'Germany' OR city = 'Paris';

-- Товары ценой от 10 до 15:
SELECT product_name, unit_price FROM products 
WHERE unit_price BETWEEN 10 AND 15;

-- Заказы за период:
SELECT order_id, order_date FROM orders 
WHERE order_date BETWEEN '1996-07-09' AND '1996-07-12';
```

---

#### **3. Сортировка (`ORDER BY`)**  
- **Синтаксис**:  
  ```sql
  SELECT столбцы FROM таблица 
  ORDER BY столбец1 [ASC|DESC], столбец2 [ASC|DESC];
  ```
- **Правила**:  
  - По умолчанию сортировка по возрастанию (`ASC`).  
  - `DESC` — сортировка по убыванию.  
  - Можно сортировать по нескольким столбцам.  

**Примеры**:  
```sql
-- Сортировка товаров по цене (от дешевых к дорогим):
SELECT product_name, unit_price, units_in_stock FROM products 
ORDER BY unit_price;

-- Сортировка по цене (убывание) и количеству (возрастание):
SELECT product_name, unit_price, units_in_stock FROM products 
ORDER BY unit_price DESC, units_in_stock ASC;

-- Клиенты из Франции (сортировка по имени):
SELECT contact_name, country FROM customers 
WHERE country = 'France' 
ORDER BY contact_name;
```

---

#### **4. Ограничение выборки (`LIMIT`)**  
- **Для чего**: Вывод первых `N` записей (часто используется с сортировкой).  
- **Пример**:  
  ```sql
  -- Топ-3 клиентов из Франции:
  SELECT contact_name, country FROM customers 
  WHERE country = 'France' 
  ORDER BY contact_name 
  LIMIT 3;
  ```
  **Результат**:  
  | contact_name      | country |  
  |-------------------|---------|  
  | Annette Roulet    | France  |  
  | Carine Schmitt    | France  |  
  | Daniel Tonini     | France  |  

---

#### **5. Самостоятельная работа**  
**Задание 1**:  
> Клиент из США с должностью "Marketing Assistant".  
```sql
SELECT contact_name, contact_title 
FROM customers 
WHERE country = 'USA' 
  AND contact_title = 'Marketing Assistant';
```
**Ответ**: `Margaret Peacock` (пример из базы Northwind).  

**Задание 2**:  
> Товары дороже $100 или "Chai".  
```sql
SELECT product_name, unit_price 
FROM products 
WHERE unit_price > 100 OR product_name = 'Chai';
```
**Ответ**: 10 товаров (зависит от данных).  

**Задание 3**:  
> Заказы за 26.02.1998 с сортировкой по весу (`freight`).  
```sql
SELECT order_id, freight 
FROM orders 
WHERE order_date = '1998-02-26' 
ORDER BY freight DESC 
LIMIT 1;
```
**Ответ**: `order_id = 10906` (самый тяжелый заказ).  

**Задание 4**:  
> Минимальный вес заказа сотрудника `employee_id = 1` за 26.02.1998.  
```sql
SELECT MIN(freight) 
FROM orders 
WHERE order_date = '1998-02-26' 
  AND employee_id = 1;
```
**Ответ**: `58.17` (примерное значение).  

---

#### **6. Ключевые выводы**  
1. **Логические операторы**:  
   - `AND`/`OR` комбинируют условия.  
   - `BETWEEN` упрощает работу с диапазонами.  
2. **Сортировка**:  
   - `ORDER BY` управляет порядком вывода.  
   - `DESC` — по убыванию, `ASC` — по возрастанию.  
3. **Ограничение выборки**:  
   - `LIMIT N` выводит первые `N` записей.  
4. **Фильтрация + сортировка**:  
   ```sql
   SELECT ... WHERE ... ORDER BY ... LIMIT ...
   ```
