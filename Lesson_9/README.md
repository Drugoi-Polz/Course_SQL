# Девятый урок

---

#### **1. Основные типы данных в SQL**
**Числовые типы:**
- `INTEGER`, `BIGINT`, `SMALLINT` — целые числа разных диапазонов.
- `REAL`, `FLOAT` — числа с плавающей запятой.
- `NUMERIC(precision, scale)` — точные числа (например, для денег).
- `DOUBLE PRECISION` — числа с двойной точностью.

**Дата и время:**
- `DATE` — дата (год, месяц, день).
- `TIMESTAMP` — дата и время.
- `TIME` — время (часы, минуты, секунды).
- `INTERVAL` — временной интервал.

**Строковые типы:**
- `CHAR(n)` — строка фиксированной длины.
- `VARCHAR(n)` — строка переменной длины.
- `TEXT` — длинный текст.

**Прочие типы:**
- `BOOLEAN` — логические значения (`true/false`).
- `JSON`, `XML` — структурированные данные.
- `UUID` — уникальные идентификаторы.
- `ARRAY` — массивы значений.

---

#### **2. Преобразование типов данных**
**Пример:** Округление цены товара.  
Проблема: функция `ROUND` требует тип `NUMERIC`, а поле `unit_price` имеет тип `FLOAT`.  
**Решение:** Явное преобразование с помощью `::`:
```sql
SELECT 
    product_name,
    ROUND(unit_price::NUMERIC, 1) AS rounded_price
FROM products;
```

---

#### **3. Функции для работы с числами**
- `ROUND(value, precision)` — округление числа.
- `SQRT(value)` — квадратный корень.
- `POW(value, exponent)` — возведение в степень.
- `DIV(value, divisor)` — целочисленное деление.
- `MOD(value, divisor)` — остаток от деления.

**Пример:**  
```sql
SELECT 
    product_name,
    ROUND(unit_price::NUMERIC, 1),
    SQRT(unit_price),
    POW(unit_price, 2)
FROM products;
```

---

#### **4. Функции для работы с датами**
**Извлечение компонентов даты:**
- `EXTRACT(field FROM date)`:
  ```sql
  SELECT 
      order_id,
      EXTRACT(YEAR FROM order_date) AS year,
      EXTRACT(MONTH FROM order_date) AS month
  FROM orders;
  ```
- Альтернатива: `DATE_PART('field', date)`:
  ```sql
  SELECT 
      DATE_PART('week', order_date) AS week_number
  FROM orders;
  ```

**Округление дат:**  
`DATE_TRUNC('precision', date)` — обрезает дату до указанной точности:
```sql
SELECT 
    DATE_TRUNC('month', order_date) AS month_start
FROM orders;
```
*Пример:* `DATE_TRUNC('month', '1996-07-04')` → `1996-07-01`.

**Текущие дата и время:**
- `CURRENT_DATE` — текущая дата.
- `CURRENT_TIME` — текущее время.
- `NOW()` или `CURRENT_TIMESTAMP` — текущие дата и время.

**Разница между датами:**  
```sql
SELECT 
    shipped_date - order_date AS delivery_days
FROM orders;
```

---

#### **5. Практические примеры**
**Заказы по месяцам и годам:**
```sql
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(*) AS order_count
FROM orders
GROUP BY year, month
ORDER BY year, month;
```

**Быстрая доставка (≤10 дней):**  
```sql
SELECT COUNT(*)
FROM orders
WHERE shipped_date - order_date <= 10;
```

---

#### **6. Самостоятельная работа**
**Задача 1:** Общая выручка за 1996 год (округлить до целого).  
**Решение:**  
```sql
SELECT ROUND(SUM(unit_price * quantity * (1 - discount))::NUMERIC) 
FROM order_details
WHERE order_id IN (
    SELECT order_id 
    FROM orders 
    WHERE EXTRACT(YEAR FROM order_date) = 1996
);
```
**Задача 2:** Количество заказов в 4-м квартале 1997 года.  
**Решение:**  
```sql
SELECT COUNT(*)
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1997
  AND EXTRACT(QUARTER FROM order_date) = 4;
```
---

#### **7. Игра "Война запросов"**
**Задача:** Количество не доставленных заказов.  
**Решение:**  
```sql
SELECT COUNT(*)
FROM orders
WHERE shipped_date IS NULL;
```
---

#### **8. Итоги урока**
- **Типы данных:** Умение выбирать правильный тип для хранения информации.
- **Преобразование типов:** Оператор `::` для явного приведения.
- **Функции:**  
  ✅ Числа: `ROUND`, `SQRT`, `POW`.  
  ✅ Даты: `EXTRACT`, `DATE_TRUNC`, разница дат.  
- **Практика:** Анализ продаж по времени, работа с условиями на даты.
