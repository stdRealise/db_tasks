-- Как вывести список всех участников, включая тех, кто их порекомендовал (если таковые имеются), без использования каких-либо объединений? Убедитесь, что каждая пара имя + фамилия отформатирована как столбец и упорядочена. Решение не должно содержать ни одного соединения (`[INNER/LEFT OUTER/RIGHT OUTER/FULL] JOIN`, декартово соединение также).
SELECT 
    m.firstname || ' ' || m.surname AS member,
    (SELECT r.firstname || ' ' || r.surname FROM cd.members AS r WHERE r.memid = m.recommendedby) AS recommender
FROM cd.members AS m
ORDER BY m.surname, m.firstname;
