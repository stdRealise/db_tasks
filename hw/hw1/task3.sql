-- Найдите количество людей с дефицитом массы тела (`BMI &lt; 18.5`).
SELECT COUNT(*) AS underweight_count
FROM hw
WHERE (703 * 1.0001092375 * weight) / (height * height) < 18.5;
