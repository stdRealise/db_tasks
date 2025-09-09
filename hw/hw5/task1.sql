-- Написать функцию count_non_volatile_days(full_nm TEXT), которая считает кол-во дней, когда цена торгов криптомонеты не менялась. Если такой криптомонеты не существует, то следует вызвать исключение с текстом: Crypto currency with name "{full_nm}"; is absent in database!, {full_nm} — имя криптомонеты, взятое из аргументов функции. Исключение должно иметь ERRCODE = '02000';. Скрипт создания должен быть нечувствителен к уже объявленным функциям. Функция должна быть написана на plpgsql.
CREATE OR REPLACE FUNCTION count_non_volatile_days(full_nm TEXT)
RETURNS INTEGER AS $$
DECLARE
    coin_exists BOOLEAN;
    days_count INTEGER;
BEGIN
    SELECT EXISTS (
        SELECT 1 
        FROM coins 
        WHERE coins.full_nm = count_non_volatile_days.full_nm
    ) INTO coin_exists;
    IF NOT coin_exists THEN
        RAISE EXCEPTION 'Crypto currency with name "%" is absent in database!', full_nm
        USING ERRCODE = '02000';
    END IF;
    SELECT COUNT(*) INTO days_count
    FROM coins
    WHERE coins.full_nm = count_non_volatile_days.full_nm
      AND open_price = close_price;
    RETURN days_count;
END;
$$ LANGUAGE plpgsql;
