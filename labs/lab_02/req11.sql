SELECT SUM(errors.price) AS ErrorSum,
       AVG(errors.price) AS ErrorAvg,
       analyzers.price
INTO MoneyStat
FROM errors JOIN analyzers ON errors.analyzer_name = analyzers.name;
