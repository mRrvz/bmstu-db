SELECT name, price, downloads
FROM analyzers
WHERE price > (
    SELECT MAX(price)
    FROM errors
    WHERE analyzers.downloads > errors.price
);
