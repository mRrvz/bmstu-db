DELETE FROM errors
WHERE price > ALL (
    SELECT price
    FROM analyzers
    WHERE analyzers.price < 10000
);
