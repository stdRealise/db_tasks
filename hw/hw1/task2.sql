-- Посчитайте BMI (Body Mass Index)для каждого измерения.
SELECT
    (703 * 1.0001092375 * weight) / (height * height) AS bmi
FROM hw;
