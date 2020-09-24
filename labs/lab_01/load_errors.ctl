LOAD DATA
INFILE '/datasets/errors.csv'
INSERT INTO TABLE errors
FIELDS TERMINATED BY  "," OPTIONALLY ENCLOSED BY '"'
(
   cwe_id,
   description CHAR(256),
   analyzer_name,
   percentage,
   danger_level,
   price
)
