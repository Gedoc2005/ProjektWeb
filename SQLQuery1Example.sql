ALTER AUTHORIZATION on Database::AdventureWorks2012 to [sa]
--SELECT P.Name
--	,	E.HireDate AS 'ProductionDate'
--FROM Production.Product AS P
--	CROSS JOIN HumanResources.Employee AS E


--INSERT INTO Production.ProductCategory(name)
--VALUES ('WIDGET')


--SELECT PC.Name AS 'CategoryName'
--	,	PSC.Name AS 'SubCategoryName'
--	,	PC.ProductCategoryID AS 'PC-ProductCategoryID'
--	,	PSC.ProductCategoryID AS 'PSC-ProductCategoryID'
--FROM Production.ProductCategory AS PC
--	LEFT JOIN Production.ProductSubcategory AS PSC
--		ON PC.ProductCategoryID = PSC.ProductCategoryID



--SELECT PC.Name AS 'CategoryName'
--	,PSC.Name AS 'SubCategoryName'
--	--,	PC.ProductCategoryID AS 'PC-ProductCategoryID'
--	--,	PSC.ProductCategoryID AS 'PSC-ProductCategoryID'

--FROM Production.ProductCategory AS PC
--	INNER JOIN Production.ProductSubcategory AS PSC
--		ON PC.ProductCategoryID = PSC.ProductCategoryID

--SELECT Name
--	, ListPrice - AP.AverageListPricePerCategory
--FROM Production.Product AS P
--	INNER JOIN
--	(
--		SELECT ProductSubCategoryID
--			AVG(ListPrice) AS 'AverageListPricePerCategory'
--		FROM Production.Product
--	) AS AP ON P.ProductSubcategoryID = AP.ProductSubcategoryID


--SELECT P.FirstName
--	,	P.LastName
--FROM Person.Person AS P
----	INNER JOIN Sales.Customer AS C ON P.BusinessEntityID = C.PersonID

----WHERE C.CustomerID IN(SELECT CustomerID FROM Sales.SalesOrderHeader);

--WHERE FirstName IN ('Kim','Sam')

--SELECT P.FirstName + ' ' + P.LastName AS FullName
--FROM Person.Person AS P

--UNION 

--SELECT ReviewerName
--FROM Production.ProductReview
--ORDER BY FullName

--SELECT COUNT(*) AS 'TotalNumberOfPerson'
--	,	COUNT(MiddleName) AS 'PersonsWithMiddleName'
--FROM Person.Person

--SELECT ST.Name
--	,	SUM(SOH.TotalDue) AS 'SalesAmout'
--	,	AVG(SOH.TotalDue) AS 'OrderAverage'

--FROM Sales.SalesOrderHeader AS SOH
--	INNER JOIN Sales.SalesTerritory AS ST ON SOH.TerritoryID = ST.TerritoryID
--WHERE ST.Name IN('Northwest','Southwest' , 'Southeast', 'Northeast')
--GROUP BY ST.Name
--HAVING SUM(SOH.TotalDue) > 15000000

--SELECT DISTINCT FirstName
--	,	LastName
--FROM Person.Person
--ORDER BY LastName DESC
--	,	FirstName DESC