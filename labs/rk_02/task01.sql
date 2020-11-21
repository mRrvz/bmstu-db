-- Вариант №1

DROP TABLE animals;
DROP TABLE dilease;
DROP TABLE host;
DROP TABLE animals_dilease; 
DROP TABLE animals_host; 

CREATE TABLE animals( 
    id INTEGER PRIMARY KEY,
    animal_type VARCHAR2(32),
    breed VARCHAR2(32),
    nickname VARCHAR2(32)
);

CREATE TABLE dilease(
    id INTEGER PRIMARY KEY,
    name VARCHAR2(32),
    symptom VARCHAR2(32),
    analysis VARCHAR2(32)
);

CREATE TABLE host(
    id INTEGER PRIMARY KEY,
    fullname VARCHAR2(32),
    address VARCHAR2(32),
    phone_number VARCHAR2(32)
);

CREATE TABLE animals_dilease(
    animal_id INTEGER REFERENCES dilease(id),
    dilease_id INTEGER REFERENCES animals(id)
);

CREATE TABLE animals_host(
    animal_id INTEGER REFERENCES host(id),
    host_id INTEGER REFERENCES animals(id)
);

INSERT INTO animals VALUES(
    1, 'SuperFlexDog01', 'Bulldog', 'NichegoNePridumal01'
);

INSERT INTO animals VALUES(
    2, 'SuperFlexDog02', 'Doberman', 'NichegoNePridumal02'
);
INSERT INTO animals VALUES(
    3, 'SuperFlexDog03', 'Bulldog', 'NichegoNePridumal03'
);
INSERT INTO animals VALUES(
    4, 'SuperFlexDog04', 'Doberman', 'NichegoNePridumal04'
);
INSERT INTO animals VALUES(
    5, 'SuperFlexDog05', 'Bulldog', 'NichegoNePridumal05'
);
INSERT INTO animals VALUES(
    6, 'SuperFlexDog06', 'Doberman', 'NichegoNePridumal06'
);
INSERT INTO animals VALUES(
    7, 'SuperFlexDog07', 'Bulldog', 'NichegoNePridumal07'
);
INSERT INTO animals VALUES(
    8, 'SuperFlexDog08', 'Doberman', 'NichegoNePridumal08'
);
INSERT INTO animals VALUES(
    9, 'SuperFlexDog09', 'Bulldog', 'NichegoNePridumal09'
);
INSERT INTO animals VALUES(
    10, 'SuperFlexDog10', 'Doberman', 'NichegoNePridumal10'
);



INSERT INTO dilease VALUES(
    1, 'Ebola2000', 'No symptom', 'Analys01'
);

INSERT INTO dilease VALUES(
    2, 'Ebola2002', 'Cough', 'Analys02'
);
INSERT INTO dilease VALUES(
    3, 'Ebola2004', 'No symptom', 'Analys03'
);
INSERT INTO dilease VALUES(
    4, 'Ebola2006', 'Runny nose', 'Analys04'
);
INSERT INTO dilease VALUES(
    5, 'Ebola2008', 'Cough && Runny nose', 'Analys05'
);
INSERT INTO dilease VALUES(
    6, 'Ebola2010', 'No symptom', 'Analys06'
);
INSERT INTO dilease VALUES(
    7, 'Ebola2012', 'Ears hurt', 'Analys07'
);
INSERT INTO dilease VALUES(
    8, 'Ebola2014', 'No symptom', 'Analys08'
);
INSERT INTO dilease VALUES(
    9, 'Ebola2016', 'Cough', 'Analys09'
);
INSERT INTO dilease VALUES(
    10, 'Ebola2018', 'Cough', 'Analys10'
);


INSERT INTO host VALUES(
    1, 'Perestoronin Pavel', 'Moscow, Yasenevo', '89652861521'
);

INSERT INTO host VALUES(
    2, 'Sergey Kononenko', 'Moscow, Izmailovo', '89652861522'
);
INSERT INTO host VALUES(
    3, 'Romanov Alexey', 'Krasnogorsk, Lesnaya', '89652861523'
);
INSERT INTO host VALUES(
    4, 'Nitenko Mikhail', 'Moscow, Vikhino', '89652861524'
);
INSERT INTO host VALUES(
    5, 'Dmirty Yakuba', 'Moscow, Yasenevo', '89652861525'
);
INSERT INTO host VALUES(
    6, 'Dmirty Kovalev', 'Moscow, VDNKH', '89652861526'
):
INSERT INTO host VALUES(
    7, 'Efim Sokolov', 'Moscow, Socol', '89652861527'
):
INSERT INTO host VALUES(
    8, 'Artem Sarkisoff', 'Moscow, Socol', '89652861528'
);
INSERT INTO host VALUES(
    9, 'Vlasov Pavel', 'Moscow, BMSTU', '89652861529'
);
INSERT INTO host VALUES(
    10, 'Ryazanova Natalya', 'Moscow, BMSTU', '89652861520'
);

INSERT INTO animals_dilease VALUES(
    1, 1
);

INSERT INTO animals_dilease VALUES(
    3, 2
);

INSERT INTO animals_dilease VALUES(
    1, 2
);

INSERT INTO animals_dilease VALUES(
    2, 3
);

INSERT INTO animals_dilease VALUES(
    4, 5
);
INSERT INTO animals_dilease VALUES(
    5, 5
);
INSERT INTO animals_dilease VALUES(
    6, 2
);
INSERT INTO animals_dilease VALUES(
    7, 2
);
INSERT INTO animals_dilease VALUES(
    8, 9
);
INSERT INTO animals_dilease VALUES(
    9, 2
);




INSERT INTO animals_host VALUES(
    1, 1
);

INSERT INTO animals_host VALUES(
    2, 2
);
INSERT INTO animals_host VALUES(
    3, 3
);
INSERT INTO animals_host VALUES(
    1, 1
);
INSERT INTO animals_host VALUES(
    4, 5
);
INSERT INTO animals_host VALUES(
    5, 6
);
INSERT INTO animals_host VALUES(
    6, 7
);
INSERT INTO animals_host VALUES(
    7, 8
);
INSERT INTO animals_host VALUES(
    8, 9
);
INSERT INTO animals_host VALUES(
    9, 9
);
