SELECT c.name AS customer_name,
--Для каждого клиента считаем количество заказов с задержками более 5 дней и количество отмененных заказов
COUNT(CASE WHEN (DATE(o.shipment_date) - DATE(o.order_date)) > 5 THEN 1 END) AS delayed_deliveries, 
COUNT(CASE WHEN o.order_status = 'Cancelled' THEN 1 END) AS cancelled_orders, 
SUM(o.order_ammount) AS total_order_amount
FROM orders_new o
join customers_new c 
ON o.customer_id = c.customer_id
-- Группируем по клиентам
GROUP BY c.name, o.customer_id
-- Сортируем по сумме заказов в порядке убывания
ORDER BY total_order_amount DESC;
