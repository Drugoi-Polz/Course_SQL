# Десятый урок

#### **1. Функции для работы со строками**
| Функция          | Пример использования                     | Результат для "Apple" | Описание |
|------------------|------------------------------------------|-----------------------|----------|
| `UPPER()`        | `SELECT UPPER('apple')`                  | APPLE                 | Верхний регистр |
| `LOWER()`        | `SELECT LOWER('APPLE')`                  | apple                 | Нижний регистр |
| `LEFT(n)`        | `SELECT LEFT('Apple', 3)`                | App                   | Первые `n` символов |
| `RIGHT(n)`       | `SELECT RIGHT('Apple', 3)`               | ple                   | Последние `n` символов |
| `LENGTH()`       | `SELECT LENGTH('Apple')`                 | 5                     | Длина строки |
| `CONCAT(a,b,...)`| `SELECT CONCAT('Mr.', ' ', 'Smith')`     | Mr. Smith             | Объединение строк |
| `SUBSTRING(str, start, length)` | `SELECT SUBSTRING('Marketing', 3, 4)` | rket | Извлечение подстроки |
| `REPLACE(str, old, new)` | `SELECT REPLACE('Mr.', 'Mr', 'Mister')` | Mister. | Замена части строки |

---

#### **Практические примеры**
**1. Форматирование ФИО:**
```sql
SELECT 
    CONCAT(UPPER(LEFT(e.first_name, 1)), LOWER(SUBSTRING(e.first_name, 2)),
    CONCAT(UPPER(LEFT(e.last_name, 1)), LOWER(SUBSTRING(e.last_name, 2)))
FROM employees e;
```
**2. Извлечение должности:**
```sql
SELECT 
    contact_title,
    SUBSTRING(contact_title FROM 7 FOR 18) AS position 
FROM customers 
WHERE contact_title = 'Owner/Marketing Assistant';
```
---

#### **Сложная аналитика: доля заказов по странам**
**Задача:** Рассчитать % заказов из Германии по месяцам с округлением и знаком %:
```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN ship_country = 'Germany' THEN order_id END) AS germany_orders,
    CONCAT(
        ROUND(
            COUNT(CASE WHEN ship_country = 'Germany' THEN order_id END) * 100.0 / 
            COUNT(order_id)::NUMERIC, 
        2
    ), ' %') AS percent_germany
FROM orders
GROUP BY year, month
ORDER BY year, month;
```

**Ключевые техники:**
- `CASE` внутри `COUNT()` для условного подсчета
- Преобразование типов `::NUMERIC` для точного деления
- Комбинация `ROUND()` и `CONCAT()` для форматирования

---

#### **Самостоятельная работа: Анализ США**
**Запрос для поиска месяца с максимальной долей заказов из США:**
```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    ROUND(
        COUNT(CASE WHEN ship_country = 'USA' THEN order_id END) * 100.0 / 
        COUNT(order_id)::NUMERIC, 
    2) AS usa_percent
FROM orders
GROUP BY year, month
ORDER BY usa_percent DESC
LIMIT 1;
```
---

#### **Война запросов: Скидки**
**Задача:** Найти заказы с суммарной скидкой > 3000:
```sql
SELECT 
    order_id,
    SUM(unit_price * quantity * discount) AS total_discount
FROM order_details
GROUP BY order_id
HAVING SUM(unit_price * quantity * discount) > 3000;
```
---

#### **Итоги:**
1. **Трюк с `CASE` в агрегации:** Мощный инструмент для сегментированного подсчета без `JOIN`.
2. **Форматирование > красоты:** Комбинация строковых и математических функций создает читаемые отчеты.
3. **Типы решают всё:** Явное преобразование типов (`::NUMERIC`) спасает от целочисленного деления.
4. **SUBSTRING — хирург строк:** Точно извлекает части данных даже из сложных форматов ("Owner/Marketing Assistant").
