LOAD DATA
INFILE '/datasets/cwe.csv'
INSERT INTO TABLE cwe
FIELDS TERMINATED BY  "," OPTIONALLY ENCLOSED BY '"'
(
   cwe_id,
   name CHAR(256),
   weakness_abstraction,
   status,
   description CHAR(512)
)
