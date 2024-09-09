-- creazione del database e delle tabelle

CREATE SCHEMA consegna;

CREATE TABLE prodotto (
   id_prodotto INT PRIMARY KEY,
   nome VARCHAR(255),
   categoria VARCHAR(255)
);

CREATE TABLE regione (
    id_regione INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE vendite (
    id_vendita INT PRIMARY KEY,
    id_prodotto INT,
    id_regione INT,
    data_vendita DATE,
    quantità INT,
    prezzo FLOAT,
    FOREIGN KEY (id_prodotto) REFERENCES prodotto(id_prodotto),
    FOREIGN KEY (id_regione) REFERENCES regione(id_regione)
);

-- popolamento delle tabelle

INSERT INTO prodotto VALUES
(1, 'Football Manager', 'Calcio'),
(2, 'Halo', 'Guerra'),
(3, 'e-Football', 'Calcio'),
(4, 'Fortnite', 'Sparatutto'),
(5, 'Super Mario', 'Avventura'),
(6, 'Pokémon', 'Fantasy'),
(7, 'Tomb Raider', 'Avventura'),
(8, 'Spyro', 'Fantasy'),
(9, 'Zelda', 'Avventura'),
(10, 'Warcraft', 'Guerra');

INSERT INTO regione VALUES
(1, 'Nord America'),
(2, 'America Latina'),
(3, 'Africa Settentrionale'),
(4, 'Africa Subsahariana'),
(5, 'Europa Meridionale'),
(6, 'Europa Settentrionale'),
(7, 'Asia Centrale'),
(8, 'Asia Orientale'),
(9, 'Oceania'),
(10, 'Antartide');

INSERT INTO vendite VALUES
(101, 1, 1, '2023-01-15', 10, 15.99),
(102, 2, 2, '2023-02-20', 8, 12.50),
(103, 1, 3, '2024-01-10', 15, 18.99),
(104, 2, 4, '2024-04-05', 12, 14.50),
(105, 3, 5, '2023-05-20', 20, 24.99),
(106, 4, 3, '2023-06-15', 8, 19.99),
(107, 5, 4, '2023-07-01', 10, 22.50),
(108, 6, 6, '2022-08-10', 18, 21.99),
(109, 7, 7, '2023-09-05', 14, 16.50),
(110, 8, 8, '2023-10-20', 25, 29.99);

-- 1. Verificare che i campi definiti come PK siano univoci.

show columns from prodotto;
show columns from vendite;
show columns from regione;

-- 2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.

SELECT 
    P.nome AS Nome,
    YEAR(V.data_vendita) AS Anno,
    SUM(V.quantità * V.prezzo) AS Totale
FROM
    prodotto P
        LEFT JOIN
    vendite V ON P.id_prodotto = V.id_prodotto
GROUP BY Nome , Anno;


-- 3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.

SELECT 
    R.nome AS Regione,
    YEAR(V.data_vendita) AS Anno,
    SUM(V.quantità * V.prezzo) AS Totale
FROM
    regione R
        LEFT JOIN
    vendite V ON R.id_regione = V.id_regione
GROUP BY Regione , Anno
ORDER BY Anno , Totale DESC;

-- 4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? 

SELECT 
    P.categoria AS Categoria, COUNT(V.id_prodotto) AS NumeroVendite
FROM
    prodotto P
        LEFT JOIN
    vendite V ON P.id_prodotto = V.id_prodotto
GROUP BY P.categoria
ORDER BY NumeroVendite DESC;

-- 5. Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.

-- Approccio 1: 

SELECT 
    P.id_prodotto, P.nome
FROM
    prodotto P
        LEFT JOIN
    vendite V ON P.id_prodotto = V.id_prodotto
WHERE
    V.id_prodotto IS NULL;
    
-- Approccio 2:

SELECT 
    P.id_prodotto, P.nome
FROM
    prodotto P
WHERE
    P.id_prodotto NOT IN (SELECT 
            V.id_prodotto
        FROM
            vendite V);
            
-- 6. Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).

SELECT 
    P.id_prodotto,
    P.nome AS Nome,
    MAX(V.data_vendita) AS UltimaDataVendita
FROM
    prodotto P
        LEFT JOIN
    vendite V ON P.id_prodotto = V.id_prodotto
GROUP BY P.id_prodotto, Nome
ORDER BY P.id_prodotto;