-- 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
select p.EnglishProductName as Prodotto, p.ProductSubcategoryKey as Sottocategoria
from dimproduct as p 
join dimproductsubcategory as d on p.ProductSubcategoryKey = d.ProductCategoryKey

/* 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e 
la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory). */
select p.EnglishProductName as Prodotto, c.EnglishProductCategoryName as Categoria, p.ProductSubcategoryKey as Sottocategoria
from dimproduct as p 
join dimproductsubcategory as d on p.ProductSubcategoryKey = d.ProductCategoryKey
join DimProductCategory as c on d.ProductCategoryKey = c.ProductCategoryKey

-- 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales).
select distinct p.EnglishProductName as Prodotto, p.ProductKey as ID_Prodotto
from dimproduct as p  
join factresellersales as f on p.ProductKey = f.ProductKey



-- 4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).
select * 
from dimproduct as p
where p.ProductKey not in
(select distinct l.ProductKey 
from dimproduct as l  
join factresellersales as f on l.ProductKey = f.ProductKey) 
and p.FinishedGoodsFlag = 1



select distinct p.ProductKey 
from dimproduct as p  
join factresellersales as f on p.ProductKey = f.ProductKey
where p.ProductKey in (
210,
211,
226,
227,
228)


-- 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct).
select f.SalesOrderNumber as Codice_ordine, p.EnglishProductName as Prodotto, f.OrderDate as Data_ordine, f.SalesAmount as Totale
from factresellersales as f
join dimproduct as p on p.ProductKey = f.ProductKey



-- 6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
select f.SalesOrderNumber as Codice_ordine, p.EnglishProductName as Prodotto, c.EnglishProductCategoryName as Categoria, 
f.OrderDate as Data_ordine, f.SalesAmount as Totale
from factresellersales as f
join dimproduct as p on p.ProductKey = f.ProductKey
join dimproductsubcategory as d on p.ProductSubcategoryKey = d.ProductCategoryKey
join DimProductCategory as c on d.ProductCategoryKey = c.ProductCategoryKey
order by data_ordine desc

-- 7.Esplora la tabella DimReseller.
select * from DimReseller

-- 8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.
SELECT r.ResellerName as Rivenditore, r.BusinessType as Tipo_Negozio, r.phone as Telefono, g.EnglishCountryRegionName as Area_geografica
FROM dimreseller as r
join dimgeography as g on r.GeographyKey = g.GeographyKey

/* 9-Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: 
SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica.*/
SELECT 
    f.SalesOrderNumber AS N_Ordine,
    f.SalesOrderLineNumber AS Cod_Ordine,
    p.EnglishProductName AS Prodotto,
    c.EnglishProductCategoryName AS Categoria,
    r.ResellerName AS Rivenditore,
    f.OrderDate AS Data_Ordine,
    f.UnitPrice AS Prezzo_Unitario,
    f.orderQuantity AS Quantità,
    f.TotalProductCost AS Totale,
    g.EnglishCountryRegionName AS Area_geografica
from factresellersales as f
join dimproduct as p on p.ProductKey = f.ProductKey
join dimproductsubcategory as d on p.ProductSubcategoryKey = d.ProductCategoryKey
join DimProductCategory as c on d.ProductCategoryKey = c.ProductCategoryKey
join dimreseller as r on r.resellerkey = f.resellerkey
join dimgeography as g on r.GeographyKey = g.GeographyKey
order by data_ordine desc