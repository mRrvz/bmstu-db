UPDATE analyzers
SET price = price * 13,
    downloads = downloads * 37
WHERE downloads > 100000;
