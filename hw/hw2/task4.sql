-- Составьте список общего количества слотов, забронированных по каждому объекту в месяц в 2012 году. В эту версию включите выходные строки, содержащие итоги за все месяцы по объекту и итоги за все месяцы по всем объектам. Выходная таблица должна состоять из идентификатора объекта, месяца и слотов, отсортированных по идентификатору и месяцу. При вычислении агрегированных значений для всех месяцев и всех `facid` возвращайте нулевые значения в столбцах `month` и `facid`.

SELECT 
    facid,
    EXTRACT(MONTH FROM starttime) AS month,
    SUM(slots) AS slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY facid, EXTRACT(MONTH FROM starttime)

UNION ALL
SELECT 
    facid,
    NULL AS month,
    SUM(slots) AS slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY facid
    
UNION ALL
SELECT 
    NULL AS facid,
    NULL AS month,
    SUM(slots) AS slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
ORDER BY facid, month;
