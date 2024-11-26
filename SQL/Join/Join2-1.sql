-- Выбираем категории продуктов и сумму всех продаж по каждой категории:
SELECT p.product_category, SUM(o.order_ammount) AS total_sales
FROM orders_2 o
JOIN products_3 p ON o.product_id = p.product_id
-- группируем по категориям продуктов
GROUP BY p.product_category;
