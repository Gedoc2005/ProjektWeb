CREATE VIEW HumanResources.vEmployeeList
AS
SELECT P.FirstName
	,	P.LastName
	,	PE.EmailAddress
	,	E.HireDate
FROM Person.Person AS P
	INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
	INNER JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID


SELECT*
FROM HumanResources.vEmployeeList
SELECT LastName + ' ' + FirstName AS 'FullName'
	,	EmailAddress
	,	HireDate
FROM HumanResources.vEmployeeList
WHERE LastName LIKE	'H%'
ORDER BY LastName