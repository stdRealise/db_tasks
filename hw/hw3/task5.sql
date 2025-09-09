-- Составьте список трех самых доходных объектов. Выведите название и ранг (с разрывом в нумерации при равенстве значений*) объекта, отсортированные по рангу и названию объекта.
SELECT name, rank
FROM (
    SELECT f.name,
        RANK() OVER (ORDER BY SUM(
            CASE 
                WHEN b.memid = 0 THEN b.slots * f.guestcost
                ELSE b.slots * f.membercost
            END
        ) DESC) AS rank
    FROM cd.facilities f
    JOIN cd.bookings b ON f.facid = b.facid
    GROUP BY f.facid, f.name
) AS ranked
ORDER BY rank, name
LIMIT 3;
