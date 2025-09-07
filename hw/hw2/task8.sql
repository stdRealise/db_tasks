-- Как составить список всех участников, которые пользовались теннисным кортом? Включите в свой вывод имена и фамилии участников, отформатированное как один столбец. Убедитесь, что данные не повторяются, и упорядочьте сначала по именам участников, в случае равенства по названиям объектов.
SELECT DISTINCT
    m.firstname || ' ' || m.surname AS member,
    f.name AS facility
FROM cd.members m
JOIN cd.bookings b ON m.memid = b.memid
JOIN cd.facilities f ON b.facid = f.facid
WHERE f.name LIKE 'Tennis Court%'
ORDER BY member, facility;
