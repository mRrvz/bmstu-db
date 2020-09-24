LOAD DATA
INFILE '/datasets/analyzers.csv'
INSERT INTO TABLE analyzers
FIELDS TERMINATED BY  "," OPTIONALLY ENCLOSED BY '"'
(
   name,
   homepage,
   description CHAR(512),
   languages,
   proprietary,
   price,
   downloads
)

