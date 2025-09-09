-- Найдите нисходящую цепочку рекомендаций для участника с идентификатором 1: то есть участников, которых учасник с memid=1 рекомендовал, участников, рекомендованных этими участниками, и так далее. Возвращает идентификатор и имя, фамилия участника, а также порядок по возрастанию идентификатора участника.
WITH RECURSIVE recommendations(memid, firstname, surname, depth) AS (
    SELECT memid, firstname, surname, 0 AS depth
    FROM cd.members
    WHERE memid = 1
    UNION ALL
    SELECT m.memid, m.firstname, m.surname, r.depth + 1
    FROM recommendations r
    JOIN cd.members m ON m.recommendedby = r.memid
)
SELECT memid, firstname, surname
FROM recommendations
WHERE memid != 1
ORDER BY memid;
