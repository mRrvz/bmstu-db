CREATE TABLE analyzers(
    name VARCHAR(50) PRIMARY KEY,
    homepage VARCHAR(512) NOT NULL,
    description VARCHAR(512) NOT NULL,
    languages VARCHAR(256) NOT NULL,
    proprietary CHAR(1) NOT NULL
    CHECK (proprietary IN ('N', 'Y'))
);

CREATE TABLE cwe(
    cwe_id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    weakness_abstraction VARCHAR(128) NOT NULL,
    status VARCHAR(64) NOT NULL,
    description VARCHAR(512) NOT NULL,
    CHECK (cwe_id > 0),
    CHECK (weakness_abstraction IN('Base', 'Class', 'Variant', 'Pillar', 'Compound')),
    CHECK (status IN('Incomplete', 'Draft', 'Stable'))
);

CREATE TABLE errors(
    id INTEGER GENERATED ALWAYS AS IDENTITY START WITH 1 PRIMARY KEY,
    cwe_id INTEGER,
    description VARCHAR(256) NOT NULL,
    analyzer_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (cwe_id) REFERENCES cwe(cwe_id),
    FOREIGN KEY (analyzer_name) REFERENCES analyzers(name),
    CHECK (cwe_id > 0)
);
