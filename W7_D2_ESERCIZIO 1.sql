1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?

La chiave primaria deve essere univoca e non deve mai ripetersi più di una sola volta, Per verificare se ProductKey è una chiave primaria nella tabella DimProduct, è necessario assicurarsi che non ci siano valori duplicati in questo campo.
Se la query restituisce un numero di record unici uguale al numero totale di record, significa che non ci sono valori ProductKey duplicati e che ProductKey è una chiave primaria valida.

Query:

SELECT
    COUNT(*) AS NumeroRecord,
    COUNT(DISTINCT ProductKey) AS NumeroRecordUnici
FROM DimProduct;



2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

SELECT
    COUNT(*) AS NumeroRecord,
    COUNT(DISTINCT SalesOrderNumber, SalesOrderLineNumber) AS NumeroRecordUnici
FROM FactSales;



3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.


SELECT
    SalesOrderDate AS DataTransazione,
    COUNT(*) AS NumeroTransazioni
FROM FactSales
WHERE SalesOrderDate >= '2020-01-01'
GROUP BY SalesOrderDate
ORDER BY DataTransazione;




4.Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!


SELECT
    p.ProductDescription AS NomeProdotto,
    SUM(frs.SalesAmount) AS FatturatoTotale,
    SUM(frs.OrderQuantity) AS QuantitàTotaleVenduta,
    AVG(frs.UnitPrice) AS PrezzoMedioVendita
FROM FactResellerSales frs
INNER JOIN DimProduct p ON p.ProductID = frs.ProductID
WHERE frs.SalesDate >= '2020-01-01'
GROUP BY p.ProductDescription
ORDER BY FatturatoTotale DESC;




5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!



SELECT
    pc.ProductCategoryDescription AS NomeCategoriaProdotto,
    SUM(frs.SalesAmount) AS FatturatoTotale,
    SUM(frs.OrderQuantity) AS QuantitàTotaleVenduta
FROM FactResellerSales frs
INNER JOIN DimProduct p ON p.ProductID = frs.ProductID
INNER JOIN DimProductCategory pc ON pc.ProductCategoryID = p.ProductCategoryID
WHERE frs.SalesDate >= '2020-01-01'
GROUP BY pc.ProductCategoryDescription
ORDER BY FatturatoTotale DESC;




6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.


SELECT
    g.City AS NomeCittà,
    SUM(frs.SalesAmount) AS FatturatoTotale
FROM FactResellerSales frs
INNER JOIN DimCustomer c ON c.CustomerID = frs.CustomerID
INNER JOIN DimGeography g ON g.GeographyKey = c.CustomerGeographyKey
WHERE frs.SalesDate >= '2020-01-01'
GROUP BY g.City
HAVING SUM(frs.SalesAmount) > 60000
ORDER BY FatturatoTotale DESC;
