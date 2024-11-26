-- Сотрудники с самой высокой зарплатой в отделе с использованием оконных функций
SELECT 
    first_name, 
    last_name, 
    salary, 
    industry, 
    FIRST_VALUE(first_name || ' ' || last_name) 
    OVER (PARTITION BY industry ORDER BY salary DESC) AS name_highest_sal
FROM salary;
