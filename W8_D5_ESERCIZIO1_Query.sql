/* Creazione e popolamento del database "ToysGroup"
1. Creazione dello schema e delle tabelle: */

CREATE SCHEMA ToysGroup;

USE ToysGroup;

CREATE TABLE Product (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  category VARCHAR(50) NOT NULL);

CREATE TABLE Region (
  region_id INT PRIMARY KEY AUTO_INCREMENT,
  region_name VARCHAR(255) NOT NULL);

CREATE TABLE Sales (
  sale_id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL,
  region_id INT NOT NULL,
  sale_date DATE NOT NULL,
  sale_amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES Product(product_id),
  FOREIGN KEY (region_id) REFERENCES Region(region_id));





/* 2. Popolamento delle tabelle:
Tabella Product: */

INSERT INTO Product (product_name, category)
VALUES
  ('Bambola Barbie', 'Bambole'),
  ('Macchina Telecomandata', 'Giocattoli'),
  ('Puzzle', 'Giochi Educativi'),
  ('Palloncino', 'Feste e Compleanni'),
  ('Gioco di Carte', 'Giochi di Società'),
  ('Lego', 'Costruzioni'),
  ('Set di Cucina Giocattolo', 'Giochi di Imitazione'),
  ('Peluche Orsetto', 'Peluche'),
  ('Pista Macchinine', 'Veicoli Giocattolo'),
  ('Libro da Colorare', 'Libri per Bambini'),
  ('Stoviglie Giocattolo', 'Giochi di Imitazione'),
  ('Tenda Tipi', 'Giochi per Bambini'),
  ('Gioco da Tavolo', 'Giochi di Società'),
  ('Costruzioni Magnetiche', 'Costruzioni'),
  ('Palestrina Neonatale', 'Giochi per Neonati'),
  ('Gioco di Imitazione Dottore', 'Giochi di Imitazione'),
  ('Set di Trucchi Giocattolo', 'Giochi di Imitazione'),
  ('Bambola Interattiva', 'Bambole'),
  ('Gioco di Equilibrio', 'Giochi Educativi');


/* Tabella Region: */

INSERT INTO Region (region_name)
VALUES
  ('Italia'),
  ('Francia'),
  ('Germania'),
  ('Spagna'),
  ('Regno Unito'),
  ('Stati Uniti'),
  ('Canada'),
  ('Australia'),
  ('Giappone'),
  ('Cina');


/* Tabella Sales: */

INSERT INTO Sales (product_id, region_id, sale_date, sale_amount)
VALUES
  (1, 1, '2023-05-20', 25.99),
  (2, 2, '2023-05-15', 39.99),
  (3, 3, '2023-05-12', 14.99),
  (4, 4, '2023-05-10', 5.99),
  (5, 5, '2023-05-08', 12.99),
  (6, 1, '2023-05-05', 34.99),
  (7, 2, '2023-05-03', 29.99),
  (8, 3, '2023-05-01', 19.99),
  (9, 4, '2024-04-29', 49.99),
  (10, 5, '2024-04-27', 9.99),
  (11, 1, '2024-04-25', 22.99),
  (12, 2, '2024-04-22', 18.99),
  (13, 3, '2024-04-20', 16.99),
  (14, 4, '2024-04-18', 35.99),
  (15, 5, '2024-04-17', 79.99);







/*     */

/* 1. Verificare l'univocità delle chiavi primarie:
1.1 Chiave primaria product_id nella tabella Product: */
SELECT COUNT(*) AS prodotti_duplicati
FROM product
GROUP BY product_id
HAVING COUNT(*) > 1;


/* 1.2 Chiave primaria region_id nella tabella Region: */
SELECT COUNT(*) AS regioni_duplicate
FROM region
GROUP BY region_id
HAVING COUNT(*) > 1;


/* 1.3 Chiave primaria sale_id nella tabella Sales: */
SELECT COUNT(*) AS vendite_duplicate
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1;


/*  2. Elenco dei prodotti venduti e fatturato totale per anno:   */
SELECT p.product_name, p.category, YEAR(s.sale_date) AS anno, SUM(s.sale_amount) AS fatturato_totale
FROM product p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name, p.category, YEAR(s.sale_date)
ORDER BY anno, fatturato_totale DESC;


/*  3. Fatturato totale per stato per anno (ordinato per data e fatturato decrescente):   */
SELECT r.region_name, YEAR(s.sale_date) AS anno, SUM(s.sale_amount) AS fatturato_totale
FROM region r
JOIN sales s ON r.region_id = s.region_id
GROUP BY r.region_name, YEAR(s.sale_date)
ORDER BY anno, fatturato_totale DESC;


/*  4. Categoria di articoli maggiormente richiesta dal mercato:   */
SELECT p.category, SUM(s.sale_amount) AS fatturato_totale
FROM product p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY fatturato_totale DESC
LIMIT 1;


/*  5. Prodotti invenduti (due approcci):
Approccio 1: Utilizzo di una sottoquery:   */
SELECT p.product_name, p.category
FROM product p
WHERE NOT EXISTS (
  SELECT 1
  FROM sales s
  WHERE p.product_id = s.product_id);


/*   Approccio 2: Utilizzo di una LEFT JOIN:  */
SELECT p.product_name, p.category
FROM product p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;



/*   6. Elenco dei prodotti con l'ultima data di vendita:  */
SELECT p.product_name, p.category, MAX(s.sale_date) AS ultima_data_vendita
FROM product p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name, p.category
ORDER BY ultima_data_vendita DESC;

