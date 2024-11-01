CREATE TABLE Koristuvach (
    id INT,
    imya VARCHAR(100),
    rol VARCHAR(50)
);

ALTER TABLE Koristuvach ADD CONSTRAINT koristuvach_pk PRIMARY KEY (id);
ALTER TABLE Koristuvach ADD CONSTRAINT koristuvach_imya_format CHECK (regexp_like(imya, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\\s]{1,100}$'));
ALTER TABLE Koristuvach ADD CONSTRAINT koristuvach_rol_format CHECK (regexp_like(rol, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\\s]{1,50}$'));

CREATE TABLE Pysmennyk (
    id INT
);

ALTER TABLE Pysmennyk ADD CONSTRAINT pysmennyk_pk PRIMARY KEY (id);
ALTER TABLE Pysmennyk ADD CONSTRAINT pysmennyk_koristuvach_fk FOREIGN KEY (id) REFERENCES Koristuvach(id);

CREATE TABLE Riven_osvitlenosti (
    id INT,
    znachennya_osvitlenosti FLOAT,
    data DATE,
    chas TIME,
    istoriya_osvitlenosti_id INT
);

CREATE TABLE Istoriya_osvitlenosti (
    id INT,
    pysmennyk_id INT,
    zmina_rivnya_osvitlenosti FLOAT
);

ALTER TABLE Istoriya_osvitlenosti ADD CONSTRAINT istoriya_osvitlenosti_pk PRIMARY KEY (id);
ALTER TABLE Istoriya_osvitlenosti ADD CONSTRAINT istoriya_osvitlenosti_pysmennyk_fk FOREIGN KEY (pysmennyk_id) REFERENCES Pysmennyk(id);

ALTER TABLE Riven_osvitlenosti ADD CONSTRAINT riven_osvitlenosti_pk PRIMARY KEY (id);
ALTER TABLE Riven_osvitlenosti ADD CONSTRAINT riven_osvitlenosti_value CHECK (znachennya_osvitlenosti > 0);
ALTER TABLE Riven_osvitlenosti ADD CONSTRAINT riven_osvitlenosti_istoriya_fk FOREIGN KEY (istoriya_osvitlenosti_id) REFERENCES Istoriya_osvitlenosti(id);

CREATE TABLE Tvir (
    id INT,
    nazva VARCHAR(200),
    tekst TEXT,
    data_stvorennya DATE
);

ALTER TABLE Tvir ADD CONSTRAINT tvir_pk PRIMARY KEY (id);
ALTER TABLE Tvir ADD CONSTRAINT tvir_nazva_length CHECK (LENGTH(nazva) <= 200);

CREATE TABLE Rekomendatsii (
    id INT,
    tekst_rekomendatsii TEXT,
    tvir_id INT
);

ALTER TABLE Rekomendatsii ADD CONSTRAINT rekomendatsii_pk PRIMARY KEY (id);
ALTER TABLE Rekomendatsii ADD CONSTRAINT rekomendatsii_tvir_fk FOREIGN KEY (tvir_id) REFERENCES Tvir(id);

CREATE TABLE Chernetka (
    id INT,
    nazva_chernetky VARCHAR(200),
    pysmennyk_id INT,
    tvir_id INT
);

ALTER TABLE Chernetka ADD CONSTRAINT chernetka_pk PRIMARY KEY (id);
ALTER TABLE Chernetka ADD CONSTRAINT chernetka_nazva_length CHECK (LENGTH(nazva_chernetky) <= 200);
ALTER TABLE Chernetka ADD CONSTRAINT chernetka_pysmennyk_fk FOREIGN KEY (pysmennyk_id) REFERENCES Pysmennyk(id);
ALTER TABLE Chernetka ADD CONSTRAINT chernetka_tvir_fk FOREIGN KEY (tvir_id) REFERENCES Tvir(id);
