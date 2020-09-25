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
