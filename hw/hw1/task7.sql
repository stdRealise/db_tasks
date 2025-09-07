-- Вывести полные названия всех криптомонет в верхнем регистре без дубликатов. Результат должен быть отсортирован в лексикографическом порядке.
SELECT DISTINCT UPPER(full_nm) AS full_name
FROM coins
ORDER BY full_name;
