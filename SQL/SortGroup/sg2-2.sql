WITH poor_sellers AS (
    SELECT 
        seller_id,
        date_reg,
        delivery_days
    FROM sellers
    WHERE category != 'Bedding' -- Исключаем категорию "Bedding
    GROUP BY seller_id, date_reg, delivery_days -- Группируем по продавцу, дате регистрации и дням доставки
    HAVING COUNT(DISTINCT category) > 1  -- Продавец должен продавать больше одной категории
       AND SUM(revenue) <= 50000 -- суммарная выручка должна быть меньше или равна 50000
)
SELECT 
    seller_id,
    FLOOR(EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(date_reg, 'YYYY-MM-DD'))) * 12 + -- Год в месяцах
          EXTRACT(MONTH FROM AGE(CURRENT_DATE, TO_DATE(date_reg, 'YYYY-MM-DD')))) AS month_from_registration, -- Добавляем количество месяцев
    (MAX(delivery_days) - MIN(delivery_days)) AS max_delivery_difference
FROM poor_sellers
GROUP BY seller_id, date_reg
ORDER BY seller_id;
