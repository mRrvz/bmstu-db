SELECT name, 
    CASE
        WHEN price < 10000   THEN 'TATTY ANALYZER'
        WHEN price < 100000  THEN 'COOL ANALYZER'
        WHEN price < 1000000 THEN 'FLEX ANALYZER'
        ELSE 'MEGACOOLFLEX ANALYZER'
    END 
FROM analyzers
WHERE analyzers.proprietary = 'Y';
