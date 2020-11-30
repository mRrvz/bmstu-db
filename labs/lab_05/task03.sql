DROP TABLE fixers;

CREATE TABLE fixers(
    id INT PRIMARY KEY,
    accuracy INT CHECK(accuracy BETWEEN 1 AND 5),
    rapidity INT CHECK(rapidity BETWEEN 1 AND 10),
    reviews CLOB
);

INSERT INTO fixers VALUES (
    1, 5, 9, TO_CLOB('{"Alexey": "Great fixer!", "Sergey": "Cool!"}')
);

INSERT INTO fixers VALUES (
    2, 5, 5, TO_CLOB('{"Mikhail": "Average fixer but not entirely bad..", "Artyom": "Quickly and clearly"}')
);

INSERT INTO fixers VALUES (
    3, 3, 1, TO_CLOB('{"Pavel": "Very bad fixer...", "Dmitry": "HORRIBLE"}')
);
