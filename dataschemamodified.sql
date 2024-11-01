CREATE TABLE koristuvach (
    id INT,
    imya VARCHAR(100),
    rol VARCHAR(50)
);

ALTER TABLE koristuvach
    ADD CONSTRAINT koristuvach_pk PRIMARY KEY (id),
    ADD CONSTRAINT koristuvach_imya_format 
        CHECK (regexp_like(imya, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\\s]{1,100}$')),
    ADD CONSTRAINT koristuvach_rol_format 
        CHECK (regexp_like(rol, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\\s]{1,50}$'));

CREATE TABLE pysmennyk (
    id INT
);

ALTER TABLE pysmennyk
    ADD CONSTRAINT pysmennyk_pk PRIMARY KEY (id),
    ADD CONSTRAINT pysmennyk_koristuvach_fk 
        FOREIGN KEY (id) REFERENCES koristuvach(id);

CREATE TABLE riven_osvitlenosti (
    id INT,
    znachennya_osvitlenosti FLOAT,
    date_column DATE,
    time_column TIME,
    istoriya_osvitlenosti_id INT
);

CREATE TABLE istoriya_osvitlenosti (
    id INT,
    pysmennyk_id INT,
    zmina_rivnya_osvitlenosti FLOAT
);

ALTER TABLE istoriya_osvitlenosti
    ADD CONSTRAINT istoriya_osvitlenosti_pk PRIMARY KEY (id),
    ADD CONSTRAINT istoriya_osvitlenosti_pysmennyk_fk 
        FOREIGN KEY (pysmennyk_id) REFERENCES pysmennyk(id);

ALTER TABLE riven_osvitlenosti
    ADD CONSTRAINT riven_osvitlenosti_pk PRIMARY KEY (id),
    ADD CONSTRAINT riven_osvitlenosti_value 
        CHECK (znachennya_osvitlenosti > 0),
    ADD CONSTRAINT riven_osvitlenosti_istoriya_fk 
        FOREIGN KEY (istoriya_osvitlenosti_id) REFERENCES istoriya_osvitlenosti(id);

CREATE TABLE tvir (
    id INT,
    nazva VARCHAR(200),
    tekst TEXT,
    date_created DATE
);

ALTER TABLE tvir
    ADD CONSTRAINT tvir_pk PRIMARY KEY (id),
    ADD CONSTRAINT tvir_nazva_length 
        CHECK (length(nazva) <= 200);

CREATE TABLE rekomendatsii (
    id INT,
    tekst_rekomendatsii TEXT,
    tvir_id INT
);

ALTER TABLE rekomendatsii
    ADD CONSTRAINT rekomendatsii_pk PRIMARY KEY (id),
    ADD CONSTRAINT rekomendatsii_tvir_fk 
        FOREIGN KEY (tvir_id) REFERENCES tvir(id);

CREATE TABLE chernetka (
    id INT,
    nazva_chernetky VARCHAR(200),
    pysmennyk_id INT,
    tvir_id INT
);

ALTER TABLE chernetka
    ADD CONSTRAINT chernetka_pk PRIMARY KEY (id),
    ADD CONSTRAINT chernetka_nazva_length 
        CHECK (length(nazva_chernetky) <= 200),
    ADD CONSTRAINT chernetka_pysmennyk_fk 
        FOREIGN KEY (pysmennyk_id) REFERENCES pysmennyk(id),
    ADD CONSTRAINT chernetka_tvir_fk 
        FOREIGN KEY (tvir_id) REFERENCES tvir(id);
