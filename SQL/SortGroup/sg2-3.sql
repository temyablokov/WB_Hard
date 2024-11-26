SELECT 
    seller_id, 
    CONCAT(  -- Склеиваем пару категорий в одну строку
        LEAST(MIN(category), MAX(category)),  -- Сортируем категории в алфавитном порядке (по возрастанию)
        ' - ',
        GREATEST(MIN(category), MAX(category))  -- Сортируем категории в алфавитном порядке (по убыванию)
    ) AS category_pair  
FROM sellers  -- Из таблицы продавцов
WHERE EXTRACT(YEAR FROM TO_DATE(date_reg, 'DD/MM/YYYY')) = 2022  -- Выбираем продавцов, зарегистрированных в 2022 году
  AND category != 'Bedding'  -- Исключаем категорию "Bedding из расчетов
GROUP BY seller_id  -- Группируем по ID продавца, чтобы обработать каждого отдельно
HAVING COUNT(DISTINCT category) = 2  -- Продавец должен 2 категории
   AND SUM(revenue) > 75000  -- суммарная выручка должна быть больше 75 000
ORDER BY seller_id;  -- Сортируем результаты по ID продавца по возрастанию