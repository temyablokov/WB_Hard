
SELECT c.name AS customer_name, o.customer_id, 
o.order_id, 
o.order_date, 
o.shipment_date, 
-- Выбираем клиента с максимальным временем ожидания между заказом и доставкой
(DATE(o.shipment_date) - DATE(o.order_date)) AS waiting_time
FROM orders_new o
JOIN customers_new c 
ON o.customer_id = c.customer_id
-- Сортируем результаты по времени ожидания в порядке убывания
ORDER BY waiting_time DESC
-- Оставляем только первую строку с максимальным временем
LIMIT 1;
