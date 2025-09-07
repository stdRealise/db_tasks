-- Выведите названия объектов и их ценовую категорию:
-- ● ежемесячная стоимость обслуживания превышает 100 долларов - 'expensive';
-- ● иначе - 'cheap';
SELECT 
    name,
    CASE 
        WHEN monthlymaintenance > 100 THEN 'expensive'
        ELSE 'cheap'
    END AS cost
FROM cd.facilities;
