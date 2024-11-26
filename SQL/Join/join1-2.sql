SELECT 
c.name AS customer_name, 
---- Для каждого клиента считаем общее количество заказов, среднее время доставки и общую сумму заказов
COUNT(o.order_id) AS total_orders, 
AVG(DATE(o.shipment_date) - DATE(o.order_date)) AS average_delivery_time, 
SUM(o.order_ammount) AS total_order_amount
FROM orders_new o
JOIN customers_new c 
ON o.customer_id = c.customer_id
-- Группируем по клиентам
GROUP BY c.name, o.customer_id
-- Сортируем по общей сумме заказов в порядке убывания
ORDER BY total_order_amount DESC;
