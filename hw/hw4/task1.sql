-- Посчитать первые 100 чисел Фибоначчи через рекурсивный CTE. Индексация начинается с нуля. Ответ упорядочить по колонке с индексом.
WITH RECURSIVE fib(idx, a, b) AS (
    VALUES(1, 1::numeric, 1::numeric)
    UNION ALL
    SELECT idx + 1, b, a + b FROM fib
    WHERE idx < 100
)
SELECT idx, a AS value FROM fib;
