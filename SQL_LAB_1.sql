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

-- Uppgift 1.16
SELECT  ProductID
	,  ISNULL(Color, 'Unknown') AS 'Color'
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

-- Uppgift 2.4 A
SELECT ProductSubcategoryID
	,	Count(ProductID) AS 'Number of Products'
FROM Production.Product
WHERE ProductSubcategoryID IS NULL
GROUP BY ProductSubcategoryID

--Uppgift 2.4 B
SELECT COUNT(*) - COUNT(P.ProductSubcategoryID) AS 'Number of Products'
FROM Production.Product AS P


-- Uppgift 2.5
SELECT SUM(P.Quantity) AS 'SUM OF PRODUCTS'
FROM Production.ProductInventory AS P
GROUP BY(P.ProductID)


-- Uppgift 2.6
SELECT SUM(P.Quantity)
FROM Production.ProductInventory AS P
WHERE P.LocationID = 40	
GROUP BY(P.ProductID)
HAVING SUM(P.Quantity) < 100

-- Uppgift 2.7
SELECT SUM(P.Quantity) AS 'SUM OF Q'
	,	P.Shelf
FROM Production.ProductInventory AS P
WHERE P.LocationID = 40	
GROUP BY(P.ProductID), P.Shelf
HAVING SUM(P.Quantity) < 100

-- Uppgift 2.8
SELECT AVG(Quantity) AS 'AverageProductID'
	,	LocationID
FROM Production.ProductInventory
WHERE LocationID = '10'
GROUP BY LocationID

-- Uppgift 2.9
SELECT Name, ROW_NUMBER() OVER(ORDER BY Name ASC) AS 'Row'
FROM Production.ProductCategory


--DEL 3
--Uppgift 3.1
SELECT Table1.Name AS 'Country'
	,	 Table2.Name AS 'Province'
FROM Person.CountryRegion AS Table1
	INNER JOIN Person.StateProvince Table2 ON Table1.CountryRegionCode = Table2.CountryRegionCode


--Uppgift 3.2
SELECT Table1.Name AS 'Country'
	,	 Table2.Name AS 'Province'
FROM Person.CountryRegion AS Table1
	INNER JOIN Person.StateProvince Table2 ON Table1.CountryRegionCode = Table2.CountryRegionCode
WHERE Table1.Name LIKE 'Germany' OR Table1.Name LIKE 'Canada'
ORDER BY Table2.Name, Table1.Name

--Uppgift 3.3
SELECT  S1.SalesOrderNumber
	,	S1.SalesOrderID
	,	S1.OrderDate
	,	S1.SalesPersonID
	,	S2.BusinessEntityID
	,	S2.Bonus
	,	S2.SalesYTD
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Sales.SalesPerson AS S2 ON S1.TerritoryID = S2.TerritoryID

--Uppgift 3.4
SELECT S1.SalesOrderID
	,	S1.OrderDate
	,	S2.Bonus
	,	S2.SalesYTD
	,	S2.TerritoryID
	,	S3.JobTitle
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Sales.SalesPerson AS S2 ON S1.TerritoryID = S2.TerritoryID
	INNER JOIN HumanResources.Employee AS S3 ON S2.BusinessEntityID = S3.BusinessEntityID

--Uppgift 3.5
SELECT P.FirstName
	,	P.LastName
	,	S1.SalesOrderID
	,	S1.OrderDate
	,	S2.Bonus
	,	S2.TerritoryID
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Sales.SalesPerson AS S2 ON S1.TerritoryID = S2.TerritoryID
	INNER JOIN HumanResources.Employee AS S3 ON S2.BusinessEntityID = S3.BusinessEntityID
	INNER JOIN Person.Person AS P ON S3.BusinessEntityID = P.BusinessEntityID

--Uppgift 3.6
SELECT P.FirstName
	,	P.LastName
	,	S1.SalesOrderID
	,	S1.OrderDate
	,	S2.Bonus
	,	S2.TerritoryID
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Sales.SalesPerson AS S2 ON S1.TerritoryID = S2.TerritoryID
	INNER JOIN Person.Person AS P ON S2.BusinessEntityID = P.BusinessEntityID

--Uppgift 3.7
SELECT 	P.FirstName
	,	P.LastName
	,	S1.SalesOrderID
	,	S1.OrderDate
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Person.Person AS P ON S1.SalesPersonID = P.BusinessEntityID

--Uppgift 3.8
SELECT	P.FirstName + ' ' + P.LastName AS SalesPerson
	,	SEL.OrderQty
	,	P.PersonType
	,	SEL.SalesOrderID
	,	S1.ModifiedDate
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Person.Person AS P ON S1.SalesPersonID = P.BusinessEntityID
	INNER JOIN Sales.SalesOrderDetail AS SEL ON S1.SalesOrderID = SEL.SalesOrderID
	ORDER BY OrderDate, SalesOrderID

--Uppgift 3.9
SELECT	P.FirstName + ' ' + P.LastName AS SalesPerson
	,	SEL.OrderQty
	,	P.PersonType
	,	SEL.SalesOrderID
	,	S1.ModifiedDate
	,	P1.Name
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Person.Person AS P ON S1.SalesPersonID = P.BusinessEntityID
	INNER JOIN Sales.SalesOrderDetail AS SEL ON S1.SalesOrderID = SEL.SalesOrderID
	INNER JOIN Production.Product AS P1 ON SEL.ProductID = P1.ProductID
	ORDER BY OrderDate, SalesOrderID

--Uppgift 3.10
SELECT  P.FirstName + ' ' + P.LastName AS SalesPerson
	,	SEL.OrderQty
	,	P.PersonType
	,	SEL.SalesOrderID
	,	S1.ModifiedDate
	,	P1.Name
	,	S1.SubTotal
FROM Sales.SalesOrderHeader AS S1
	INNER JOIN Person.Person AS P ON S1.SalesPersonID = P.BusinessEntityID
	INNER JOIN Sales.SalesOrderDetail AS SEL ON S1.SalesOrderID = SEL.SalesOrderID
	INNER JOIN Production.Product AS P1 ON SEL.ProductID = P1.ProductID
	WHERE S1.SubTotal > 100000 AND DATEPART(year, S1.OrderDate) > 2004
	ORDER BY OrderDate, SalesOrderID

--Uppgift 3.11
SELECT  PC.Name AS 'RegionName'
	,	PS.Name AS 'ProvinceName'
FROM Person.CountryRegion AS PC
	LEFT OUTER JOIN Person.StateProvince AS PS ON PC.CountryRegionCode = PS.CountryRegionCode
	ORDER BY PC.Name, PS.Name

--Uppgift 3.12
SELECT SC.CustomerID AS 'Customers without orders'
FROM Sales.Customer AS SC
	FULL OUTER JOIN Sales.SalesOrderHeader AS SS ON SC.CustomerID = SS.CustomerID
	WHERE SS.CustomerID IS NULL
 
--Uppgift 3.13*
SELECT	PP.Name
	,	PP.ProductModelID
FROM Sales.Customer AS SC
	FULL OUTER JOIN Production.Product AS PP ON SC.ModifiedDate = PP.ModifiedDate
 WHERE PP.Name IS NOT NULL AND PP.ProductModelID IS NOT NULL

--Uppgift 3.14
SELECT PP.FirstName + ' ' + PP.LastName AS FULLNAME
	,	COUNT(SSOH.SalesPersonID) AS 'NoOfOrders'
	,	SUM(SSOH.SubTotal) AS 'TotalSum'
FROM Sales.SalesPerson AS SS
	INNER JOIN Person.Person AS PP ON SS.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN HumanResources.Employee AS HRE ON SS.BusinessEntityID = HRE.BusinessEntityID
	INNER JOIN Sales.SalesOrderHeader AS SSOH ON SS.BusinessEntityID = SSOH.SalesPersonID
	GROUP BY SSOH.SalesPersonID, PP.FirstName + ' ' + PP.LastName

--Uppgift 3.15
SELECT ST.Name
	,	DATEPART(YEAR, SOH.OrderDate) AS 'Year'
	,	SUM(ST.SalesLastYear) AS 'LastYearSales'
	,	SUM(SOH.SubTotal) AS 'SubTotal'
FROM Sales.SalesOrderHeader AS SOH
	INNER JOIN Sales.SalesTerritory AS ST ON SOH.TerritoryID = ST.TerritoryID
	GROUP BY DATEPART(YEAR, SOH.OrderDate), ST.Name
	ORDER BY [YEAR] , ST.Name

--Uppgift 3.16
SELECT COUNT(EDH.DepartmentID) AS 'NumberOfDepartments'
	,  P.FirstName + ' ' + P.LastName AS 'FullName'
FROM Person.Person AS P
	INNER JOIN HumanResources.Employee AS E ON P.BusinessEntityID = E.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory AS EDH ON P.BusinessEntityID = EDH.BusinessEntityID
	GROUP BY P.FirstName + ' ' + P.LastName
	HAVING COUNT(EDH.DepartmentID) > 1

--Uppgift 3.17
SELECT MIN(SOH.SubTotal) AS 'Subtotal'
	,	'MIN' AS 'MIN,MAX,AVG'
FROM Sales.SalesOrderHeader AS SOH
UNION
SELECT MAX(SOH.SubTotal)
	,	'MAX'
FROM Sales.SalesOrderHeader AS SOH
UNION
SELECT AVG(SOH.SubTotal)
	,	'AVG'
FROM Sales.SalesOrderHeader AS SOH

--Uppgift 3.18
SELECT TOP 10 P.ListPrice
	,	P.Name
FROM Production.Product AS P
ORDER BY P.ListPrice DESC

--Uppgift 3.19
SELECT TOP 1 PERCENT P.DaysToManufacture AS 'Tillverknings Längde'
	,	P.Name
	,	P.ListPrice
FROM Production.Product AS P
ORDER BY P.DaysToManufacture DESC