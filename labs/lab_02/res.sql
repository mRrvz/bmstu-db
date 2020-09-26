-- Request 1


SELECT cwe.cwe_id, cwe.name 
FROM cwe 
WHERE cwe.weakness_abstraction = 'Class';



-- Request 2


SELECT errors.id, errors.percentage
FROM errors
WHERE errors.percentage BETWEEN 10.5 AND 40.5;



-- Request 3


SELECT name, homepage
FROM analyzers
WHERE languages LIKE '%haskell%';



-- Request 4


SELECT cwe_id, name
FROM cwe
WHERE weakness_abstraction IN (
    SELECT weakness_abstraction
    FROM cwe
    WHERE description LIKE '%memory%'
);



-- Request 5


SELECT cwe_id, description
FROM errors
WHERE EXISTS (
    SELECT *
    FROM analyzers
    WHERE price BETWEEN 100000 AND 1000000
);




-- Request 6


SELECT * 
FROM analyzers
WHERE price > ALL (
    SELECT price
    FROM errors
);



-- Request 7


SELECT SUM(price) AS price
FROM (
    SELECT errors.price
    FROM errors
    WHERE errors.analyzer_name = 'clang-tidy'
);



-- Request 8


SELECT  name,
        (
            SELECT AVG(errors.price)
            FROM errors
            WHERE errors.analyzer_name = analyzers.name
        ) AS AvgErrorPrice,
        homepage
FROM analyzers
WHERE analyzers.price > 8500000;



-- Request 9


SELECT cwe_id, name,
    CASE status
        WHEN 'Incomplete' THEN 'This is new error.'
        WHEN 'Draft' THEN 'This is future error.'
        ELSE 'This is old error.'
    END
FROM cwe;



-- Request 10


SELECT name, 
    CASE
        WHEN price < 10000   THEN 'TATTY ANALYZER'
        WHEN price < 100000  THEN 'COOL ANALYZER'
        WHEN price < 1000000 THEN 'FLEX ANALYZER'
        ELSE 'MEGACOOLFLEX ANALYZER'
    END 
FROM analyzers
WHERE analyzers.proprietary = 'Y';



-- Request 11


CREATE GLOBAL TEMPORARY TABLE AnalyzerErrorsStat (
    name VARCHAR(50) NOT NULL,
    analyzer_price INTEGER,
    error_id INTEGER,
    error_price INTEGER
) ON COMMIT DELETE ROWS;

INSERT INTO AnalyzerErrorsStat (
SELECT analyzers.name,
       analyzers.price,
       errors.id,
       errors.price
FROM errors JOIN analyzers ON errors.analyzer_name = analyzers.name);



-- Request 12


SELECT name, price, downloads
FROM analyzers
WHERE price > (
    SELECT MAX(price)
    FROM errors
    WHERE analyzers.downloads > errors.price
);



-- Request 13


SELECT name, price, AnalyzersID.id
FROM analyzers
JOIN (
    SELECT analyzer_name, id
    FROM errors
    JOIN (
        SELECT cwe_id
        FROM cwe
        WHERE EXISTS (
            SELECT price
            FROM errors
            WHERE price > 100
        )
    ) StatusID ON StatusID.cwe_id = errors.cwe_id
) AnalyzersID ON AnalyzersID.analyzer_name = analyzers.name;



-- Request 14


SELECT errors.danger_level,
       AVG(errors.price),
       MIN(errors.price)
FROM analyzers JOIN errors ON analyzers.name = errors.analyzer_name
WHERE analyzers.name = 'clang-tidy'
GROUP BY errors.danger_level;



-- Request 15


SELECT errors.danger_level,
       AVG(errors.price),
       MIN(errors.price)
FROM analyzers JOIN errors ON analyzers.name = errors.analyzer_name
WHERE analyzers.name = 'clang-tidy'
GROUP BY errors.danger_level
HAVING AVG(errors.price) BETWEEN 4000 AND 5000 AND MAX(errors.price) > 1000;



-- Request 16


INSERT INTO analyzers (name, homepage, description, languages, proprietary, price, downloads)
VALUES ('FlexAnalyzer', 'https://google.com', 'GoogleFlexAnalyzer', 'MindFuck', 'N', '1', '99999999');



-- Request 17


INSERT INTO errors (cwe_id, description, analyzer_name, percentage, danger_level, price)
SELECT cwe_id, description, analyzer_name, percentage / 10, danger_level * 0.5, price + 1000
FROM errors
WHERE errors.price > 10000;



-- Request 18


UPDATE analyzers
SET price = price * 13,
    downloads = downloads * 37
WHERE downloads > 100000;



-- Request 19


UPDATE errors
SET price = price + (
    SELECT AVG(price)
    FROM errors
    WHERE danger_level > 3
)
WHERE percentage > 20;



-- Request 20


DELETE FROM errors
WHERE price < 10000;



-- Request 21


DELETE FROM errors
WHERE price > ALL (
    SELECT price
    FROM analyzers
    WHERE analyzers.price < 10000
);



-- Request 22


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



-- Request 23


WITH ErrorsTree (id, parent_id, description, analyzer_name)
AS (
    SELECT id, parent_id, description, analyzer_name
    FROM errors
    WHERE id = 2190
    UNION ALL
    SELECT e.id, e.parent_id, e.description, e.analyzer_name
    FROM errors e
    JOIN ErrorsTree et
    ON e.parent_id = et.id
) 
SELECT * 
FROM ErrorsTree;



-- Request 24


SELECT id,
       analyzers.name,
       errors.price,
       errors.percentage,
       danger_level,
       AVG(percentage) OVER(PARTITION BY danger_level) AS AvgPercentage,
       MIN(errors.price) OVER(PARTITION BY danger_level) AS MinPrice,
       MAX(errors.price) OVER(PARTITION BY danger_level) AS MaxPrice
FROM errors 
JOIN analyzers
ON errors.analyzer_name = analyzers.name;



