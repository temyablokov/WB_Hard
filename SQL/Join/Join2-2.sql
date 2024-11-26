SELECT product_category
FROM (
-- Подзапрос для вычисления общей суммы продаж по категории
SELECT p.product_category, SUM(o.order_ammount) AS total_sales
FROM orders_2 o
JOIN products_3 p ON o.product_id = p.product_id
-- группировка по категориям продуктов
GROUP BY p.product_category
) AS category_sales
-- Сортируем полученные категории по уменьшению числа продаж
ORDER BY total_sales DESC
-- Ограничиваем результат одной строкой, чтобы получить только категорию с максимальной суммой продаж
LIMIT 1;
