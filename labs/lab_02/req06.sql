SELECT * 
FROM analyzers
WHERE price > ALL (
    SELECT price
    FROM errors
);
