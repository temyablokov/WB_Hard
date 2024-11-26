-- Выбираем для каждой категории продукт с максимальной суммой продаж
SELECT p.product_category, p.product_name, MAX(o.order_ammount) AS max_sales
FROM orders_2 o
JOIN products_3 p ON o.product_id = p.product_id
-- выбираем только те продукты которые имеют максимальную сумму продаж в своей категории
WHERE (o.product_id, o.order_ammount) IN (
-- Подзапрос для нахождения максимальной суммы продаж для каждого продукта в категории
	SELECT o2.product_id, MAX(o2.order_ammount)
	FROM orders_2 o2
	JOIN products_3 p2 ON o2.product_id = p2.product_id
--Группируем данные по категориям и продуктам
	GROUP BY p2.product_category, o2.product_id
	)
-- Группируем данные по категориям и названиям продуктов
GROUP BY p.product_category, p.product_name;
