SELECT SUM(price) AS price
FROM (
    SELECT errors.price
    FROM errors
    WHERE errors.analyzer_name = 'clang-tidy'
);
