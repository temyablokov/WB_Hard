SELECT 
    city, -- Город покупателя
    CASE 
        WHEN age BETWEEN 0 AND 20 THEN 'young'  -- Категория "молодёжь"
        WHEN age BETWEEN 21 AND 49 THEN 'adult' -- Категория "взрослые" для в-та от 21 до 49
        WHEN age >= 50 THEN 'old'               -- Категория "пожилые" для возраста от 50 и выше
    END AS age_category, 
    COUNT(*) AS customer_count  -- Подсчитываем количество покупателей в каждой категории
FROM 
    users
GROUP BY 
    age_category, city  -- Группируем по городу и возрастной категории
ORDER BY 
    city, customer_count DESC; -- Сортируем по городу и убыванию числа покупателей
