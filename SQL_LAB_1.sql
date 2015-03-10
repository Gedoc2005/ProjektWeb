-- Uppgift 1.1
SELECT ProductID
	,	Name
	,	Color
	,	ListPrice
FROM Production.Product

-- Uppgift 1.2
SELECT ProductID
	,	Name
	,	Color
	,	ListPrice
FROM Production.Product
WHERE ListPrice > 0

-- Uppgift 1.3
SELECT ProductID
	,	Name
	,	Color
	,	ListPrice
FROM Production.Product
WHERE Color IS NULL

-- Uppgift 1.4
SELECT ProductID
	,	Name
	,	Color
	,	ListPrice
FROM Production.Product
WHERE Color IS NOT NULL

-- Uppgift 1.5
SELECT ProductID
	,	Name
	,	Color
	,	ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0

-- Uppgift 1.6
SELECT Name + Color AS 'Name and Color'
FROM Production.Product
WHERE Color IS NOT NULL

-- Uppgift 1.7
SELECT 'Name: ' + Name + ' -- ' + 'Color: ' +  Color AS 'Name and Color'
FROM Production.Product
WHERE Color IS NOT NULL

-- Uppgift 1.8
SELECT ProductID
	,	Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500

-- Uppgift 1.9
SELECT DISTINCT Color
	,	 ProductID
	,	Name
FROM Production.Product
WHERE Color = 'black' or Color = 'blue'

-- Uppgift 1.10
SELECT Name
	,	 ListPrice
FROM Production.Product
WHERE Name LIKE 's%'

-- Uppgift 1.11
SELECT Name
	,	 ListPrice
FROM Production.Product
WHERE Name LIKE 's%' OR Name LIKE 'a%'

-- Uppgift 1.12
SELECT Name
	,	 ListPrice
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'

-- Uppgift 1.13
SELECT DISTINCT Color
FROM Production.Product

-- Uppgift 1.14
SELECT ProductSubcategoryID 
	,	Color
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL
ORDER BY ProductSubcategoryID ASC, Color DESC;

-- Uppgift 1.15
SELECT ProductSubCategoryID
	,	LEFT([Name],35) AS [Name]
	,	Color, ListPrice
FROM Production.Product
WHERE Color IN ('Red','Black')
AND ListPrice BETWEEN 1000 AND 2000
OR ProductSubCategoryID = 1
ORDER BY ProductID

-- Uppgift 1.16 ********************************************
SELECT  ProductID
	,	Color
	,	ListPrice
FROM Production.Product


--DEL 2

--SELECT ProductSubcategoryID, ProductID, Color, ListPrice
--FROM Production.Product

-- Uppgift 2.1
SELECT COUNT(*) ProductID
FROM Production.Product

-- Uppgift 2.2
SELECT COUNT(ProductSubcategoryID)
FROM Production.Product

-- Uppgift 2.3
SELECT ProductSubcategoryID
	,	Count(ProductID) AS 'Number of Products'
FROM Production.Product
GROUP BY ProductSubcategoryID

-- Uppgift 2.4******************************************
SELECT ProductSubcategoryID
	,	Count(ProductID) AS 'Number of Products'
FROM Production.Product
WHERE ProductSubcategoryID IS NULL
GROUP BY ProductSubcategoryID

-- Uppgift 2.5
SELECT ProductID
	,	COUNT(ProductID) AS 'Number of Products'
FROM Production.ProductInventory
GROUP BY ProductID


SELECT ProductID, LocationID
FROM Production.ProductInventory

-- Uppgift 2.6********************
SELECT ProductID
	,	LocationID
FROM Production.ProductInventory
WHERE LocationID NOT LIKE '40' AND ProductID < 100

-- Uppgift 2.7
SELECT ProductID
	,	LocationID
	,	Shelf
FROM Production.ProductInventory

-- Uppgift 2.8
SELECT AVG(ProductID) AS 'AverageProductID'
	,	LocationID
FROM Production.ProductInventory
WHERE LocationID = '10'
GROUP BY LocationID

-- Uppgift 2.9
SELECT Name, ROW_NUMBER() OVER(ORDER BY Name ASC) AS Row
FROM Production.ProductCategory


--DEL 3
--Uppgift 3.1
SELECT Table1.Name AS 'T1', Table2.Name AS 'T2'
	,	Table1.CountryRegionCode AS 'T3'
	,	Table2.CountryRegionCode AS 'T4'
FROM Person.CountryRegion AS Table1
	INNER JOIN Person.StateProvince Table2 ON Table1.CountryRegionCode = Table2.CountryRegionCode

SELECT Name
FROM Person.StateProvince

