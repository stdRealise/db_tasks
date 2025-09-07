-- Выбрать из данных по криптовалюте `DOGE` за 2018 год самую высокую цену и объем торгов за дни, когда её средняя цена была выше 0.1 цента.
SELECT dt, high_price, vol
FROM coins
WHERE 
    symbol = 'DOGE'
    AND dt LIKE '2018-%'
    AND avg_price > 0.001;
