-- Подсчитайте количество рекомендаций, сделанных каждым участником. Упорядочить по идентификатору участника. Примечание: Надо выводить только тех участников, которые сделали хотя бы 1 рекомендацию.
SELECT 
    recommendedby,
    COUNT(*) AS count
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;
