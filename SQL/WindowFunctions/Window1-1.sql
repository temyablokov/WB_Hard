-- Сотрудники с самой высокой зарплатой в отделе (без оконных функци)
SELECT 
    first_name, 
    last_name, 
    salary, 
    industry, 
    (
        -- Подзапрос нахождения сотрудника с максимальной зарплатой в отделе
        SELECT first_name || ' ' || last_name
        FROM salary
        WHERE industry = salary.industry
        AND salary = (SELECT MAX(salary) FROM salary WHERE industry = salary.industry)
        LIMIT 1
    ) AS name_highest_sal 
FROM salary;
