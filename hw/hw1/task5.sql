-- Выбрать из таблицы все записи про биткоин ('BTC'), где его средняя цена за торговый день меньше 100 USD.
SELECT * FROM coins
WHERE symbol = 'BTC' AND avg_price < 100;
