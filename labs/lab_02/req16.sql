INSERT INTO errors (cwe_id, description, analyzer_name, percentage, danger_level, price)
SELECT cwe_id, description, analyzer_name, percentage / 10, danger_level * 0.5, price + 1000
FROM errors
WHERE errors.price > 10000;
