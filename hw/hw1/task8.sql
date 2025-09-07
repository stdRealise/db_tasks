-- Вывести для каждой криптомонеты день, когда значение цены (`high_price`) было самым высоким. Упорядочить результат по цене в порядке убывания, а в случае равенства цен упорядочить по имени монеты. Если имеется несколько дней с таким значением, то выбираем самый ранний. Имя криптовалюты ожидается в верхнем регистре.
SELECT 
    UPPER(full_nm) AS full_name,
    dt,
    high_price AS price
FROM (
    SELECT DISTINCT ON (symbol)
        full_nm,
        dt,
        high_price
    FROM  coins
    ORDER BY 
        symbol,
        high_price DESC,
        dt ASC
) AS distinct_coins
ORDER BY 
    price DESC,
    full_name ASC;
