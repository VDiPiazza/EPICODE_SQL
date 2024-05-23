-- punto 3
SELECT 
    *
FROM
    dimproduct;


-- punto 4
SELECT 
    ProductKey AS Prodotto,
    ProductAlternateKey AS Altro,
    EnglishProductName AS Nome_inglese,
    Color AS Colore,
    StandardCost AS Prezzo,
    FinishedGoodsFlag AS Prodotto_finito
FROM
    DimProduct;


-- punto 5
SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1;


-- punto 6
SELECT 
    ProductKey, Model, ProductName, StandardCost, ListPrice
FROM
    DimProduct
WHERE
    ProductKey LIKE 'FR%'
        OR ProductKey LIKE 'BK%';


-- punto 7
SELECT 
    ProductKey,
    Model,
    ProductName,
    StandardCost,
    ListPrice,
    ListPrice - StandardCost AS Markup
FROM
    DimProduct
WHERE
    ProductKey LIKE 'FR%'
        OR ProductKey LIKE 'BK%';


-- punto 8
SELECT 
    FinishedGoodsFlag, ListPrice
FROM
    DimProduct
WHERE
    ListPrice BETWEEN 1000 AND 2000;


-- punto 9
SELECT 
    *
FROM
    DimEmployee;


-- punto 10
select * from DimEmployee
where SalesPersonFlag = 1


-- punto 11
select SalesAmount - TotalProductCost as Profitto
from FactResellerSales
where ProductId in (597, 598, 477, 214)
and OrderDate >= 2020-01-01

