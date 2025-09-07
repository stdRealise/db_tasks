-- Как вывести список всех участников, включая тех, кто их порекомендовал (если есть)? Убедитесь, что результаты упорядочены по (фамилии, имени).
SELECT 
    m.firstname AS memfname,
    m.surname AS memsname,
    r.firstname AS recfname,
    r.surname AS recsname
FROM cd.members m
LEFT JOIN cd.members r ON m.recommendedby = r.memid
ORDER BY m.surname, m.firstname;
