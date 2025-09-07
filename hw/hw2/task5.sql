-- Верните таблицу имен и идентификаторов каждого участника и их первого бронирования после 1 сентября 2012 года. Упорядочьте по идентификатору участника.
SELECT 
    m.surname,
    m.firstname,
    m.memid,
    MIN(b.starttime) AS starttime
FROM cd.members m
JOIN cd.bookings b ON m.memid = b.memid
WHERE b.starttime > '2012-09-01'
GROUP BY m.memid, m.surname, m.firstname
ORDER BY m.memid;
