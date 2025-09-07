-- Проранжировать дни на бирже по объему торгов криптовалютой, выдать топ-10 таких дней.
SELECT
    RANK() OVER (ORDER BY vol DESC) AS rank,
    dt,
    vol
FROM coins
ORDER BY vol DESC
LIMIT 10;
