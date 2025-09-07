-- Создайте список общего количества слотов, забронированных на объект в месяц в 2012 году. Создайте выходную таблицу, состоящую из идентификатора объекта и слотов, отсортированных по идентификатору и месяцу.
SELECT 
    facid,
    EXTRACT(MONTH FROM starttime) AS month,
    SUM(slots) AS total_slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY facid, month
ORDER BY facid, month;
