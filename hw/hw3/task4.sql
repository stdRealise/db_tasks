-- Разделите объекты отдыха загородного клуба на группы одинакового размера: высокие (`high`), средние (`average`) и низкие (`low`) в зависимости от их дохода. Упорядочить по группам (сначала `high`, потом `average` и `low`) и названию объекта. Возможно, вам поможет функция ntile.
SELECT 
    name,
    CASE 
        WHEN revenue_group = 1 THEN 'high'
        WHEN revenue_group = 2 THEN 'average'
        ELSE 'low'
    END AS revenue
FROM (
    SELECT
        f.name,
        NTILE(3) OVER (ORDER BY SUM(
            CASE
                WHEN b.memid = 0 THEN b.slots * f.guestcost
                ELSE b.slots * f.membercost
            END
        ) DESC) AS revenue_group
    FROM cd.facilities f
    JOIN cd.bookings b ON f.facid = b.facid
    GROUP BY f.facid, f.name
) AS grouped
ORDER BY revenue, name;
