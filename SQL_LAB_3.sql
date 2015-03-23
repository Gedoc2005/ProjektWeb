--LAB_3
--Uppgift 4
IF NOT EXISTS (SELECT name FROM master.sys.databases WHERE name = N'MyLibrary')
	CREATE DATABASE MyLibrary;

GO
USE MyLibrary
GO

IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Author') AND type IN (N'U'))
CREATE TABLE Author
(
	AuthorID int NOT NULL IDENTITY(1,1),
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	YearOfBirth datetime NOT NULL,
	YearOfDeath datetime NULL,
	[Language] varchar(50) NOT NULL,
	[Country] varchar(50) NOT NULL,
	CONSTRAINT PK_Author_AuthorID PRIMARY KEY (AuthorID)
);

INSERT INTO dbo.Author 
(FirstName,LastName,YearOfBirth,YearOfDeath,[Language],[Country])
VALUES('Mattias','Thander','1957','2015', 'French', 'Sweden');

SELECT *
FROM Author

IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Customer') AND type IN (N'U'))
CREATE TABLE Customer
(
--CopyID int,
CustomerID int NOT NULL IDENTITY(1,1),
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
TelephoneNumber int NULL,
Email varchar(50) NOT NULL,
Gender varchar(50) NOT NULL,
BirthYear datetime NOT NULL,
CONSTRAINT PK_Customer_CustomerID PRIMARY KEY(CustomerID),
--CONSTRAINT FK_Customer_CopyID FOREIGN KEY(CopyID) REFERENCES Copy (CopyID)
);

INSERT INTO dbo.Customer (FirstName, LastName, TelephoneNumber, Email, Gender, BirthYear)
VALUES ('Gedoc', 'Sintset', '0722636431', 'as@hotmail.com', 'Male', '1988')

SELECT *
FROM Customer


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Book') AND type IN (N'U'))
CREATE TABLE Book
(
AuthorID int,
BookID int NOT NULL IDENTITY(1,1),
Name varchar(50) NOT NULL,
PublishedYear datetime NOT NULL,
YearOfDeath datetime NULL,
[Language] varchar(50) NOT NULL,
CONSTRAINT PK_Book_BookID PRIMARY KEY(BookID),
CONSTRAINT FK_Book_AuthorID FOREIGN KEY(AuthorID) REFERENCES Author (AuthorID)
);

declare @bookid int
INSERT INTO dbo.Book(Name, PublishedYear, YearOfDeath, [Language])
VALUES ('Alkemisten', '1989', '2029', 'Swedish')


set @bookid = SCOPE_IDENTITY()

SELECT *
FROM Book

SELECT Name, A.FirstName AS 'AuthorName', A.AuthorID
FROM dbo.BOOK AS B
	INNER JOIN dbo.Author AS A ON B.AuthorID = A.AuthorID


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Status') AND type IN (N'U'))
CREATE TABLE [Status]
(
[StatusID] int NOT NULL ,
[Value] varchar(50) NOT NULL
CONSTRAINT PK_Status_StutusID PRIMARY KEY(StatusID)
);

INSERT INTO dbo.[Status] ([StatusID],[Value])
VALUES (0,'Avaliable')
INSERT INTO dbo.[Status] ([Value])
VALUES ('Rented Out')
INSERT INTO dbo.[Status] ([Value])
VALUES ('Delaied')

SELECT *
FROM [Status]


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Copy') AND type IN (N'U'))
CREATE TABLE [Copy]
(
[StatusID] int, -- defualt = 0
[CopyID] int NOT NULL IDENTITY(1,1), 
[PurchaseCost] money NULL,
[PurchaseYear] datetime NOT NULL
CONSTRAINT PK_Copy_CopyID PRIMARY KEY(CopyID)
CONSTRAINT FK_Copy_StatusID FOREIGN KEY(StatusID) REFERENCES [Status] (StatusID)
);

ALTER TABLE dbo.Copy
ADD CONSTRAINT FK_Copy_BookID FOREIGN KEY(BookID) REFERENCES [Book] (BookID)

ALTER TABLE dbo.Copy
ADD BookID int not null

INSERT INTO dbo.[Copy] 
([PurchaseCost],[PurchaseYear], BookID)
VALUES ('5000', '2007', @bookId)

SELECT *
FROM [Copy]


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Loan') AND type IN (N'U'))
CREATE TABLE [Loan]
(
LoanID int NOT NULL IDENTITY(1,1),
CustomerID int,
CopyID int,
LoanDate datetime NULL,
	--CONSTRAINT DF_LoanDate_CurrentDate DEFAULT GETDATE(),
[ReturnDate] datetime NOT NULL,
CONSTRAINT PK_Loan_LoanID PRIMARY KEY(LoanID),
CONSTRAINT FK_Loan_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer (CustomerID),
CONSTRAINT FK_Loan_CopyID FOREIGN KEY(CopyID) REFERENCES Copy (CopyID)
);

INSERT INTO dbo.Loan (LoanDate, ReturnDate)
VALUES ('2015-03-10','2015-03-24')

SELECT *
FROM Loan

--kopia/låntagare
IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.CopyOut') AND type IN (N'U'))
CREATE TABLE [CopyOut]
(
CopyOutID int NOT NULL IDENTITY(1,1),
LoanID int,
CustomerID int,
CONSTRAINT PK_CopyOut_CopyOutID PRIMARY KEY(CopyOutID),
CONSTRAINT FK_CopyOut_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer (CustomerID),
CONSTRAINT FK_CopyOut_LoanID FOREIGN KEY(LoanID) REFERENCES [Loan] (LoanID),
);

SELECT *
FROM CopyOut

--kopia/låntagare/status
IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.LoanInfo') AND type IN (N'U'))
CREATE TABLE [LoanInfo]
(
LoanInfoID int NOT NULL IDENTITY(1,1),
CopyOutID int,
[StatusID] int,
CONSTRAINT PK_LoanInfo_LoanInfoID PRIMARY KEY(CopyOutID),
CONSTRAINT FK_LoanInfo_CopyOutID FOREIGN KEY(CopyOutID) REFERENCES CopyOut (CopyOutID),
CONSTRAINT FK_LoanInfo_StatusID FOREIGN KEY(StatusID) REFERENCES [Status] (StatusID)
);

SELECT *
FROM LoanInfo


--SELECT LI.StatusID
--	,	C.FirstName AS 'Customer Name'
--	,	B.Name AS 'BookName'
--	,	L.LoanDate
--	,	L.ReturnDate
--FROM LoanInfo AS LI
--	INNER JOIN CopyOut AS CO ON LI.CopyOutID = CO.CopyOutID
--	INNER JOIN [Status] AS S ON LI.StatusID = S.StatusID
--	INNER JOIN Loan AS L ON CO.LoanID = L.LoanID
--	INNER JOIN Customer AS C ON L.CustomerID = C.CustomerID
--	INNER JOIN Copy AS COP ON S.StatusID = COP.StatusID 
--	INNER JOIN Book AS B ON COP. = B.BookID
--	INNER JOIN Author AS AU ON B.AuthorID = AU.AuthorID



	select C.FirstName + ' ' + c.LastName
		--, b.Name
	from Customer C
		inner join loan l on l.CustomerID = c.CustomerID
		inner join Copy cp on l.CopyID = cp.CopyID
	--	inner join Book b on b.BookID = cp.BookID


SELECT LI.StatusID
	,	C.FirstName AS 'Customer Name'
	,	B.Name AS 'BookName'
	,	L.LoanDate
	,	L.ReturnDate
FROM LoanInfo AS LI

drop database MyLibrary
