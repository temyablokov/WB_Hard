-- сначала считаем общие продажи по дате, потом делим на эту сумму продажи для каждого магазина
WITH total_sales AS (
    SELECT 
        s.date, 
        SUM(s.qty * g.price) AS total_sales -- считаем общую сумму продаж по каждому дню
    FROM 
        sales s
    JOIN 
        goods g ON s.id_good = g.id_good -- соединяем с товарами для фильтра по категории "ЧИСТОТА"
    WHERE 
        g.category = 'ЧИСТОТА' -- фильтруем по категории "ЧИСТОТА"
    GROUP BY 
        s.date -- группируем по дате
)
SELECT 
    s.date AS date_, 
    sh.city, 
    (SUM(s.qty * g.price) OVER (PARTITION BY s.date, sh.city) / ts.total_sales) AS sum_sales_rel -- вычисляем долю для каждого магазина
FROM 
    sales s
JOIN 
    goods g ON s.id_good = g.id_good -- соединяем с товарами
JOIN 
    shops sh ON s.shopnumber = sh.shopnumber -- соединяем с магазинами
JOIN 
    total_sales ts ON s.date = ts.date -- соединяем с общей суммой продаж по дате
WHERE 
    g.category = 'ЧИСТОТА' -- фильтруем по категории "ЧИСТОТА"
ORDER BY 
    s.date, sh.city; -- сортируем по дате и городу
