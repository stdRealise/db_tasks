-- Упорядочить людей по их `BMI` в убывающем порядке, а также указать тип комплекции согласно их `BMI'.
-- В случае равенства BMI упорядочивать по `id` также в порядке убывания.
SELECT
    id,
    (weight / (height * height) * 703)::NUMERIC(10, 1) AS bmi,
    CASE
        WHEN (weight / (height * height)) * 703 < 18.5 THEN 'underweight'
        WHEN (weight / (height * height)) * 703 < 25 THEN 'normal'
        WHEN (weight / (height * height)) * 703 < 30 THEN 'overweight'
        WHEN (weight / (height * height)) * 703 < 35 THEN 'obese'
        ELSE 'extremely obese'
    END AS type
FROM hw
ORDER BY bmi DESC, id DESC;
