WITH ProprietaryAnalyzers(languages, AvgPrice)
AS (
    SELECT languages, AVG(price)
    FROM analyzers
    WHERE proprietary = 'Y'
    GROUP BY languages
) 
SELECT errors.id, errors.price, AvgPrice, languages
FROM ProprietaryAnalyzers
JOIN errors
ON ProprietaryAnalyzers.AvgPrice / 1000000 > errors.price;
