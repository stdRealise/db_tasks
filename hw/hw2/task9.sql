-- Как вы можете составить список бронирований на `2012-09-14`, которые обойдутся участнику (или гостю) более чем в 30 долларов? Помните, что гости имеют разные затраты по сравнению с участниками (перечисленные расходы указаны за получасовой «слот»), а гостевой пользователь всегда имеет идентификатор 0. Включите в свой вывод название объекта, имя члена, отформатированное как одно колонка и стоимость. Упорядочить по убыванию стоимости, в случае равенства отсортировать по `member` и `facility` лексикографически. Решение не должно содержать ни одного соединения (`[INNER/LEFT OUTER/RIGHT OUTER/FULL] JOIN`, декартово соединение также).
SELECT 
    (SELECT firstname || ' ' || surname FROM cd.members WHERE memid = b.memid) AS member,
    (SELECT name FROM cd.facilities WHERE facid = b.facid) AS facility,
    CASE 
        WHEN b.memid = 0 THEN b.slots * (SELECT guestcost FROM cd.facilities WHERE facid = b.facid)
        ELSE b.slots * (SELECT guestcost FROM cd.facilities WHERE facid = b.facid)
    END AS cost
FROM cd.bookings AS b
WHERE b.starttime::date = '2012-09-14'
    AND ((b.memid = 0 AND b.slots * (SELECT guestcost FROM cd.facilities WHERE facid = b.facid) > 30)
        OR (b.memid != 0 AND b.slots * (SELECT membercost FROM cd.facilities WHERE facid = b.facid) > 30))
ORDER BY cost DESC, member, facility;
