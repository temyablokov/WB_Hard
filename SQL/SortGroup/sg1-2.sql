SELECT 
    category,  -- Категория товара, определенная по ключевым словам "hair" или "home"
    ROUND(AVG(price), 2) AS avg_price  -- Средняя цена товаров в категории, округленная до 2 знаков
FROM (
    SELECT
        CASE 
            WHEN LOWER(name) LIKE '%hair%' THEN 'hair'  -- Определяем категорию 'hair' для товаров с "hair"
            WHEN LOWER(name) LIKE '%home%' THEN 'home'  -- Определяем категорию 'home' для товаров с "home"
        END AS category,  price  -- Поле с ценой товара, которое будет использоваться для расчета средней цены
    FROM 
        products
    WHERE 
        LOWER(name) LIKE '%hair%' OR LOWER(name) LIKE '%home%'  -- Условие отбора: только товары с hair или home в названии
) AS filtered_products  -- Обозначаем результат подзапроса filtered_products
GROUP BY 
    category;  -- Группируем результаты по каждой категории для вычисления средней цены
