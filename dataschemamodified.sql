CREATE TABLE koristuvach (
    id INT PRIMARY KEY,
    imya VARCHAR(100) CHECK (REGEXP_LIKE(imya, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\s]{1,100}$')),
    rol VARCHAR(50) CHECK (REGEXP_LIKE(rol, '^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\s]{1,50}$'))
);

CREATE TABLE pysmennyk (
    id INT PRIMARY KEY,
    CONSTRAINT pysmennyk_koristuvach_fk FOREIGN KEY (id) REFERENCES koristuvach(id)
);

CREATE TABLE riven_osvitlenosti (
    id INT PRIMARY KEY,
    znachennya_osvitlenosti FLOAT CHECK (znachennya_osvitlenosti > 0),
    date_column DATE,
    time_column TIME,
    istoriya_osvitlenosti_id INT,
    CONSTRAINT riven_osvitlenosti_istoriya_fk
        FOREIGN KEY (istoriya_osvitlenosti_id) REFERENCES istoriya_osvitlenosti(id)
);

CREATE TABLE istoriya_osvitlenosti (
    id INT PRIMARY KEY,
    pysmennyk_id INT,
    zmina_rivnya_osvitlenosti FLOAT,
    CONSTRAINT istoriya_osvitlenosti_pysmennyk_fk
        FOREIGN KEY (pysmennyk_id) REFERENCES pysmennyk(id)
);

CREATE TABLE tvir (
    id INT PRIMARY KEY,
    nazva VARCHAR(200) CHECK (LENGTH(nazva) <= 200),
    tekst TEXT,
    date_created DATE
);

CREATE TABLE rekomendatsii (
    id INT PRIMARY KEY,
    tekst_rekomendatsii TEXT,
    tvir_id INT,
    CONSTRAINT rekomendatsii_tvir_fk FOREIGN KEY (tvir_id) REFERENCES tvir(id)
);

CREATE TABLE chernetka (
    id INT PRIMARY KEY,
    nazva_chernetky VARCHAR(200) CHECK (LENGTH(nazva_chernetky) <= 200),
    pysmennyk_id INT,
    tvir_id INT,
    CONSTRAINT chernetka_pysmennyk_fk FOREIGN KEY (pysmennyk_id) REFERENCES pysmennyk(id),
    CONSTRAINT chernetka_tvir_fk FOREIGN KEY (tvir_id) REFERENCES tvir(id)
);
