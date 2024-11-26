WITH ranked_queries AS (
    SELECT
        year,
        month,
        day,
        userid,
        devicetype,
        deviceid,
        ts,
        query,
        LEAD(ts) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_ts,
        LEAD(query) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_query
        -- Добавляем временные метки следующего запроса и следующий запрос
    FROM query
),
final_classification AS (
    -- Определяем значение is_final
    SELECT
        year,
        month,
        day,
        userid,
        ts,
        devicetype,
        deviceid,
        query,
        next_query,
        CASE
            WHEN next_ts IS NULL THEN 1 -- Если следующий запрос отсутствует
            WHEN next_ts - ts > 180 THEN 1 -- Если прошло больше 3 минут
            WHEN LENGTH(next_query) < LENGTH(query) AND next_ts - ts > 60 THEN 2 -- Если следующий запрос короче и прошло больше минуты
            ELSE 0 -- Во всех остальных случаях
        END AS is_final
    FROM ranked_queries
)
-- Фильтруем запросы за определенный день и устройства android, где is_final == 1 или 2
SELECT
    year,
    month,
    day,
    userid,
    ts,
    devicetype,
    deviceid,
    query,
    next_query,
    is_final
FROM final_classification
WHERE 
    devicetype = 'android' 
    AND day = 26 -- Указываем  день
    AND is_final IN (1, 2);
