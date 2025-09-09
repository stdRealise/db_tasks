-- Написать функцию serial_generator(start_val_inc INTEGER, last_val_ex INTEGER), которая возвращает таблицу из последовательных чисел с шагом +1. Скрипт создания должен быть нечувствителен к уже объявленным функциям.
CREATE OR REPLACE FUNCTION serial_generator(start_val_inc INTEGER, last_val_ex INTEGER)
RETURNS TABLE(serial_generator INTEGER) AS $$
DECLARE
    curr_val INTEGER;
BEGIN
    curr_val := start_val_inc;
    WHILE curr_val < last_val_ex LOOP
        serial_generator := curr_val;
        RETURN NEXT;
        curr_val := curr_val + 1;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;
