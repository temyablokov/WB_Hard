SELECT 
    s.shopnumber, 
    sh.city, 
    sh.adress, 
    SUM(s.qty) OVER (PARTITION BY s.shopnumber) AS sum_qty, -- считаем количество товаров по каждому магазину
    SUM(s.qty * g.price) OVER (PARTITION BY s.shopnumber) AS sum_qty_price -- считаем общую сумму продаж по каждому магазину
FROM 
    sales s
JOIN 
    goods g ON s.id_good = g.id_good -- соединяем продажи с товарами
    
JOIN 
    shops sh ON s.shopnumber = sh.shopnumber -- соединяем с магазинами, чтобы получить адрес и город
WHERE 
    s.date = '2016-01-02'; -- только продажи за 2 января