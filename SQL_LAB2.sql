--uppgift 4.0
BACKUP DATABASE AdventureWorks2012
TO DISK = 'C:\MyBackups\AW_BU.bak'

--uppgift 4.1
SELECT LastName 
FROM Person.Person

BEGIN TRANSACTION
UPDATE Person.Person
SET LastName = 'Hult'
ROLLBACK TRANSACTION
--COMMIT
SELECT @@TRANCOUNT AS ActiveTransactions

--uppgift 4.2
CREATE TABLE [dbo].[TempCustomers]
(
[ContactID] [int] NULL,
[FirstName] [nvarchar](50) NULL,
[LastName] [nvarchar](50) NULL,
[City] [nvarchar](30) NULL,
[StateProvince] [nvarchar](50) NULL
)
GO
INSERT INTO dbo.TempCustomers
(ContactID,FirstName,LastName)
VALUES('1','Kalen','Delaney');

INSERT INTO dbo.TempCustomers
(ContactID,FirstName,LastName,City,StateProvince)
VALUES('2','Herrman','Karlsson','Vislanda','Kronoberg');

INSERT INTO dbo.TempCustomers
(ContactID,FirstName,LastName,City)
VALUES('3','Tora','Eriksson','Guldsmedshyttan');

INSERT INTO dbo.TempCustomers
(ContactID,FirstName,LastName,City)
VALUES('4','Charlie','Carpenter','Tappström');

SELECT ContactID
	,	FirstName
	,	LastName
	,	City
	,	StateProvince
FROM dbo.TempCustomers

--Uppgift 4.3
INSERT INTO Production.Product
(Name,ModifiedDate,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate)
VALUES('Racing Gizmo',GETDATE(),'1 ','2 ',' 3','4 ','5 ',' 6', GETDATE());

select *
from Production.Product

--uppgift 4.4
INSERT INTO dbo.TempCustomers 
SELECT P.BusinessEntityID, P.FirstName
	,	P.LastName, PA.City , SP.Name
FROM Person.Person AS P
	JOIN Person.BusinessEntity AS BE
	ON P.BusinessEntityID=BE.BusinessEntityID
	JOIN Person.BusinessEntityAddress AS BEA
	ON BE.BusinessEntityID = BEA.BusinessEntityID
	JOIN Person.Address PA
	ON BEA.AddressID=PA.AddressID
	JOIN Person.StateProvince AS SP
	ON PA.StateProvinceID = SP.StateProvinceID

--uppgift 4.5
--Töm tabellen
--och töm buffer och cache
TRUNCATE TABLE dbo.TempCustomers
GO
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
--Lägg till data och mät tiden
DECLARE @Start DATETIME2, @Stop DATETIME2
SELECT @Start = SYSDATETIME()

INSERT INTO dbo.TempCustomers
	(ContactID, FirstName, LastName)
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person

SELECT @Stop = SYSDATETIME()
SELECT DATEDIFF (ms,@Start, @Stop) AS MilliSeconds
--AVERAGE TIME 107 Miliseconds
--AVERAGE TIME 730 Miliseconds with index

--CREATE UNIQUE CLUSTERED INDEX [Unique_clustered]
--ON [dbo].[TempCustomers]
--([ContactID] ASC)
--GO
--CREATE NONCLUSTERED INDEX [NonClustered_LName]
--ON [dbo].[TempCustomers]
--([LastName] ASC )
--GO
--CREATE NONCLUSTERED INDEX [NonClustered_FName]
--ON [dbo].[TempCustomers]
--([FirstName] ASC)

--Den gå långsamere att köra med index

--uppgift 4.6

CREATE TABLE #TempTab(
BusinessEntityID int,
PersonType varchar(50), 
FirstName varchar(50),
LastName varchar(50),
Title varchar(50),
EmailPromotion varchar(50))

INSERT INTO #TempTab
SELECT P.BusinessEntityID
	,	P.PersonType
	,	P.FirstName
	,	P.LastName
	,	P.Title
	,	P.EmailPromotion
FROM Person.Person AS P
WHERE P.LastName LIKE 'Achong' OR P.LastName LIKE 'Acevedo'

UPDATE #TempTab
SET BusinessEntityID = (SELECT MAX(BusinessEntityID) + 1
FROM Person.Person)

SELECT *
FROM #TempTab

UPDATE TOP (1) #TempTab
SET BusinessEntityID = BusinessEntityID + 1;

INSERT INTO Person.Person(BusinessEntityID,PersonType,
FirstName,LastName,Title,EmailPromotion)
SELECT BusinessEntityID
	,	PersonType
	,	FirstName
	,	LastName
	,	Title
	,	EmailPromotion
FROM #TempTab

INSERT INTO Person.BusinessEntity
VALUES(DEFAULT, DEFAULT)

DROP TABLE #TempTab

SELECT ModifiedDate
	, BusinessEntityID
	, FirstName
	, LastName
FROM Person.Person
WHERE ModifiedDate > '2015-03-10'

--Uppgift 4.7
UPDATE Person.Person
SET FirstName = 'Gurra', LastName = 'Tjong'
WHERE BusinessEntityID IN (
SELECT BusinessEntityID
FROM Person.Person
WHERE LastName IN ('Achong', 'Acevedo')
);


--Uppgift 4.8

SELECT P.Name, P.ListPrice * 1.1 AS 'ListPrice10%'
FROM Production.Product AS P
	INNER JOIN Production.ProductSubcategory AS PS
	ON PS.ProductSubcategoryID = P.ProductSubcategoryID
WHERE PS.Name = 'Gloves';

--UPDATE Production.Product
--SET ListPrice = ListPrice + (0.1*ListPrice)
--WHERE ProductSubcategoryID IN (SELECT ProductCategoryID
--FROM Production.ProductSubcategory
--WHERE Name = 'Gloves' )

--SELECT ProductCategoryID, Name
--FROM Production.ProductSubcategory
--WHERE Name = 'Gloves'


--Uppgift 4.9
DELETE FROM dbo.TempCustomers
WHERE LastName = 'Smith'