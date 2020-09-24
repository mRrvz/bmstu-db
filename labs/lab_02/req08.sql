SELECT  name,
        (
            SELECT AVG(errors.price)
            FROM errors
            WHERE errors.analyzer_name = analyzers.name
        ) AS AvgErrorPrice,
        homepage
FROM analyzers
WHERE analyzers.price > 8500000;
