CREATE TABLE Користувач (
    id INT,
    імя VARCHAR(100),
    роль VARCHAR(50)
);

ALTER TABLE Користувач ADD CONSTRAINT користувач_pk PRIMARY KEY (id);
ALTER TABLE Користувач ADD CONSTRAINT користувач_імя_format CHECK (regexp_like(імя, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\\s]{1,100}$'));
ALTER TABLE Користувач ADD CONSTRAINT користувач_роль_format CHECK (regexp_like(роль, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\\s]{1,50}$'));

CREATE TABLE Письменник (
    id INT
);

ALTER TABLE Письменник ADD CONSTRAINT письменник_pk PRIMARY KEY (id);
ALTER TABLE Письменник ADD CONSTRAINT письменник_користувач_fk FOREIGN KEY (id) REFERENCES Користувач(id);

CREATE TABLE Рівень_освітленості (
    id INT,
    значення_освітленості FLOAT,
    дата DATE,
    час TIME,
    історія_освітленості_id INT
);

CREATE TABLE Історія_освітленості (
    id INT,
    письменник_id INT,
    зміна_рівня_освітленості FLOAT
);

ALTER TABLE Історія_освітленості ADD CONSTRAINT історія_освітленості_pk PRIMARY KEY (id);
ALTER TABLE Історія_освітленості ADD CONSTRAINT історія_освітленості_письменник_fk FOREIGN KEY (письменник_id) REFERENCES Письменник(id);

ALTER TABLE Рівень_освітленості ADD CONSTRAINT рівень_освітленості_pk PRIMARY KEY (id);
ALTER TABLE Рівень_освітленості ADD CONSTRAINT рівень_освітленості_value CHECK (значення_освітленості > 0);
ALTER TABLE Рівень_освітленості ADD CONSTRAINT рівень_освітленості_історія_fk FOREIGN KEY (історія_освітленості_id) REFERENCES Історія_освітленості(id);

CREATE TABLE Твір (
    id INT,
    назва VARCHAR(200),
    текст TEXT,
    дата_створення DATE
);

ALTER TABLE Твір ADD CONSTRAINT твір_pk PRIMARY KEY (id);
ALTER TABLE Твір ADD CONSTRAINT твір_назва_length CHECK (LENGTH(назва) <= 200);

CREATE TABLE Рекомендації (
    id INT,
    текст_рекомендацій TEXT,
    твір_id INT
);

ALTER TABLE Рекомендації ADD CONSTRAINT рекомендації_pk PRIMARY KEY (id);
ALTER TABLE Рекомендації ADD CONSTRAINT рекомендації_твір_fk FOREIGN KEY (твір_id) REFERENCES Твір(id);

CREATE TABLE Чернетка (
    id INT,
    назва_чернетки VARCHAR(200),
    письменник_id INT,
    твір_id INT
);

ALTER TABLE Чернетка ADD CONSTRAINT чернетка_pk PRIMARY KEY (id);
ALTER TABLE Чернетка ADD CONSTRAINT чернетка_назва_length CHECK (LENGTH(назва_чернетки) <= 200);
ALTER TABLE Чернетка ADD CONSTRAINT чернетка_письменник_fk FOREIGN KEY (письменник_id) REFERENCES Письменник(id);
ALTER TABLE Чернетка ADD CONSTRAINT чернетка_твір_fk FOREIGN KEY (твір_id) REFERENCES Твір(id);
