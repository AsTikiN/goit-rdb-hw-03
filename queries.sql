-- ДЗ3. DQL по датасету теми 3.
-- Таблиці: products, shippers, suppliers, categories, customers,
-- employees, orders, order_details.
-- Імпорт: dataset/*.csv. Ключ співробітника — employees.employee_id.

USE goit_rdb_hw_03;

-- 1.1 Усі стовпці products.
SELECT *
FROM products;

-- 1.2 Лише назва і телефон перевізника.
SELECT name, phone
FROM shippers;

-- 2. Середня, найбільша і найменша ціна.
SELECT
  AVG(price) AS avg_price,
  MAX(price) AS max_price,
  MIN(price) AS min_price
FROM products;

-- 3. Унікальні пари категорія + ціна, 10 найдорожчих.
SELECT DISTINCT category_id, price
FROM products
ORDER BY price DESC
LIMIT 10;

-- 4. Скільки товарів коштують від 20 до 100 включно.
SELECT COUNT(*) AS products_in_price_range
FROM products
WHERE price BETWEEN 20 AND 100;

-- 5. Кількість товарів і середня ціна кожного постачальника.
SELECT
  supplier_id,
  COUNT(*) AS product_count,
  AVG(price) AS avg_price
FROM products
GROUP BY supplier_id
ORDER BY supplier_id;
