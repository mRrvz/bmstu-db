ALTER TABLE errors 
ADD (
    percentage FLOAT CHECK(percentage BETWEEN 0 AND 100),
    danger_level NUMBER(3) CHECK(danger_level BETWEEN 1 AND 10),
    price INTEGER CHECK(price > 0)
);

ALTER TABLE analyzers
ADD (
    price INTEGER CHECK(price > 0),
    downloads INTEGER CHECK(downloads > 0)
);
