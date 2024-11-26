-- Сумма продаж в рублях за предыдущую дату для магазинов Санкт-Петербурга
SELECT 
    sa."DATE" AS "DATE_",               -- Дата продажи
    sa."SHOPNUMBER",                   -- Номер магазина
    g."CATEGORY",                      -- Категория товара
    SUM(sa."QTY" * g."PRICE") AS "PREV_SALES" -- Сумма продаж в рублях за предыдущую дату
FROM "sales" sa
JOIN "shops" sh ON sa."SHOPNUMBER" = sh."SHOPNUMBER"  -- Присоединяем информацию о магазине
JOIN "goods" g ON sa."ID_GOOD" = g."ID_GOOD"         -- Присоединяем информацию о товаре
WHERE sh."CITY" = 'Санкт-Петербург'               -- Отбираем только магазины в Санкт-Петербурге
AND sa."DATE" < CURRENT_DATE                    -- Отбираем только продажи до текущей даты
GROUP BY sa."DATE", sa."SHOPNUMBER", g."CATEGORY"   -- Группируем по дате, магазину и категории товара
ORDER BY sa."DATE";
