UPDATE errors
SET price = price + (
    SELECT AVG(price)
    FROM errors
    WHERE danger_level > 3
)
WHERE percentage > 20;
