-- Сотрудники с самой низкой зарплатой в отделе с использованием оконных функций
SELECT 
    first_name, 
    last_name, 
    salary, 
    industry, 
    FIRST_VALUE(first_name || ' ' || last_name) 
    OVER (PARTITION BY industry ORDER BY salary ASC) AS name_lowest_sal
FROM salary;
