SELECT 
    seller_id,
    COUNT(DISTINCT category) AS total_categ,  -- Количество уникальных категорий, которые продает продавец
    AVG(rating) AS avg_rating,                -- Средний рейтинг категорий продавца
    SUM(revenue) AS total_revenue,            -- Суммарная выручка продавца
    CASE 
        WHEN SUM(revenue) > 50000 AND COUNT(DISTINCT category) > 1 THEN 'rich' -- Метка "rich" для успешных
        WHEN SUM(revenue) <= 50000 AND COUNT(DISTINCT category) > 1 THEN 'poor' -- Метка 'poor' для остальных
    END AS seller_type
FROM 
    sellers
WHERE 
    category != 'Bedding'  -- Исключаем категорию Bedding
GROUP BY 
    seller_id
HAVING 
    COUNT(DISTINCT category) > 1  -- Учитываем только продавцов с более чем одной категорией
ORDER BY 
    seller_id ASC;  -- Сортируем по возрастанию seller_id
