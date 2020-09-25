SELECT errors.danger_level,
       AVG(errors.price),
       MIN(errors.price)
FROM analyzers JOIN errors ON analyzers.name = errors.analyzer_name
WHERE analyzers.name = 'clang-tidy'
GROUP BY errors.danger_level
HAVING AVG(errors.price) BETWEEN 4000 AND 5000 AND MAX(errors.price) > 1000;
