WITH sales_with_amount AS (
    -- Считаем сумму продаж (количество * цена) для каждого товара в магазинах Санкт-Петербурга
    SELECT 
        s.date AS date_,
        s.shopnumber,
        g.category,
        s.qty * g.price AS total_sales
    FROM 
        sales s
    JOIN 
        goods g ON s.id_good = g.id_good
    JOIN 
        shops sh ON s.shopnumber = sh.shopnumber
    WHERE 
        sh.city = 'Санкт-Петербург'
),
ranked_sales AS (
    -- Считаем общую сумму продаж нарастающим итогом по магазинам и категориям, упорядочено по дате
    SELECT 
        date_,
        shopnumber,
        category,
        SUM(total_sales) OVER (
            PARTITION BY shopnumber, category
            ORDER BY date_
        ) AS running_sales
    FROM 
        sales_with_amount
),
prev_sales AS (
    -- Берем сумму продаж за предыдущую дату (LAG возвращает значение из предыдущей строки)
    SELECT
        date_,
        shopnumber,
        category,
        LAG(running_sales) OVER (
            PARTITION BY shopnumber, category
            ORDER BY date_
        ) AS prev_sales
    FROM
        ranked_sales
)
-- Выводим дату, магазин, категорию и продажи за предыдущую дату
SELECT
    date_,
    shopnumber,
    category,
    prev_sales
FROM
    prev_sales
WHERE
    prev_sales IS NOT NULL; -- Убираем строки, где нет данных о продажах за предыдущую дату
