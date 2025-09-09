-- Составьте список участников (включая гостей), а также количество часов, которые они забронировали в учреждениях, округлив до ближайших десятков часов. Вывод следует отсортировать по рангу, фамилии и имени.
SELECT 
    m.firstname,
    m.surname,
    ROUND(SUM(b.slots * 0.5), -1) AS hours,
    RANK() OVER (ORDER BY ROUND(SUM(b.slots * 0.5), -1) DESC) AS rank
FROM cd.members m
JOIN cd.bookings b ON m.memid = b.memid
GROUP BY m.memid, m.firstname, m.surname
ORDER BY rank, m.surname, m.firstname;
