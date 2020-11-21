-- Запрос №1
-- Выводит id, animal_type и коментарий по поводу породы собаки (сравнение через CASE).
-- Если порода бульдог, то выводится фразу This is dangerous dog!
-- Если порода доберман, выводится фразу This is service dog!
-- Во всех остальных случаях выводится фраза This is unidentified dog!

SELECT id, animal_type,
    CASE breed
        WHEN 'Bulldog' THEN 'This is dangerous dog!'
        WHEN 'Doberman' THEN 'This is service dog!'
        ELSE 'This is unidentified dog!'
    END
FROM animals;


-- Запрос №2
-- Выводит id, animal_type и среднее значение по dilease_id (из джойна
-- таблицы animals и связывающий таблицы animals_dilease) по разбиению animal_type 


SELECT id, animal_type, AVG(dilease_id) OVER(PARTITION BY animal_type) AS AVGFLEX
FROM animals 
JOIN animals_dilease 
ON animals.id = animals_dilease.animal_id;

-- Запрос №3
-- Выводит среднее значение ID, из таблицы animals, группируя по породе (breed),
-- при этом сумма id для разбиения должна быть больше 5.

SELECT AVG(id)
FROM animals
GROUP BY breed
HAVING SUM(id) > 5;