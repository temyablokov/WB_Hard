--Сотрудники с самой низкой зарплатой в отделе (без оконных функций)
SELECT 
    first_name, 
    last_name, 
    salary, 
    industry, 
    (
        -- Подзапрос для нахождения сотрудника с минимальной зарплатой в отделе
        SELECT first_name || ' ' || last_name
        FROM salary
        WHERE industry = salary.industry
        AND salary = (SELECT MIN(salary) FROM salary WHERE industry = salary.industry)
        LIMIT 1
    ) AS name_lowest_sal 
FROM salary;
