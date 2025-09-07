-- Как вывести список всех участников, которые порекомендовали другого участника? Убедитесь, что в списке нет дубликатов и что результаты упорядочены по (фамилии, имени).
SELECT DISTINCT r.firstname, r.surname
FROM cd.members m
JOIN cd.members r ON m.recommendedby = r.memid
ORDER BY r.surname, r.firstname;
