WITH ranked_sales AS (
    SELECT 
        s.date AS date_, 
        s.shopnumber, 
        s.id_good, 
        SUM(s.qty) AS total_qty, -- считаем количество проданных товаров
        RANK() OVER (PARTITION BY s.date, s.shopnumber ORDER BY SUM(s.qty) DESC) AS rank -- присваиваем ранг товару по количеству продаж
    FROM 
        sales s
    GROUP BY 
        s.date, s.shopnumber, s.id_good -- группируем по дате, магазину и товару
)
SELECT 
    date_, 
    shopnumber, 
    id_good -- выводим дату, магазин и товар с топ-3 по продажам
FROM 
    ranked_sales
WHERE 
    rank <= 3 -- выбираем только топ-3 товара
ORDER BY 
    date_, shopnumber, rank; -- сортируем по дате и магазину
