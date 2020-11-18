SELECT name, SumErrors(name)
FROM analyzers
WHERE name = 'clang-tidy';