-- Удалить из таблицы записи, где не было транзакций или торгов.
DELETE FROM coins
WHERE tx_cnt = 0 OR tx_cnt IS NULL
    OR tx_vol = 0 OR tx_vol IS NULL
    OR vol = 0 OR vol IS NULL;
