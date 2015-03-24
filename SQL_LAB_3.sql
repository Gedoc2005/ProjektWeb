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


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Customer') AND type IN (N'U'))

CREATE TABLE Customer
(
	CustomerID int NOT NULL IDENTITY(1,1),
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	TelephoneNumber int NULL,
	Email varchar(50) NOT NULL,
	Gender varchar(50) NOT NULL,
	BirthYear datetime NOT NULL,
	CONSTRAINT PK_Customer_CustomerID PRIMARY KEY(CustomerID),
);

ALTER TABLE Customer
ADD CONSTRAINT AK_Customer_Email UNIQUE (Email)


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Book') AND type IN (N'U'))

CREATE TABLE Book
(
	BookID int NOT NULL IDENTITY(1,1),
	AuthorID int NOT NULL,
	Name varchar(50) NOT NULL,
	PublishedYear datetime NOT NULL,
	YearOfDeath datetime NULL,
	[Language] varchar(50) NOT NULL,
	CONSTRAINT PK_Book_BookID PRIMARY KEY(BookID),
	CONSTRAINT FK_Book_AuthorID FOREIGN KEY(AuthorID) REFERENCES Author (AuthorID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Status') AND type IN (N'U'))

CREATE TABLE [Status]
(
	[StatusID] int NOT NULL ,
	[Value] varchar(50) NOT NULL
	CONSTRAINT PK_Status_StutusID PRIMARY KEY(StatusID)
);

IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Copy') AND type IN (N'U'))

CREATE TABLE [Copy]
(
	[CopyID] int NOT NULL IDENTITY(1,1),
	[StatusID] int NOT NULL
		CONSTRAINT DF_Copy_StatusID DEFAULT 1, 
	[BookID] int NOT NULL,
	[PurchaseCost] money NULL,
	[PurchaseYear] datetime NOT NULL
	CONSTRAINT PK_Copy_CopyID PRIMARY KEY(CopyID),
	CONSTRAINT FK_Copy_StatusID FOREIGN KEY(StatusID) REFERENCES [Status] (StatusID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT FK_Copy_BookID FOREIGN KEY(BookID) REFERENCES [Book] (BookID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,

);


IF NOT EXISTS (SELECT object_id, type FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Loan') AND type IN (N'U'))

CREATE TABLE [Loan]
(
	LoanID int NOT NULL IDENTITY(1,1),
	CustomerID int NOT NULL,
	CopyID int NOT NULL,
	LoanDate datetime NULL,
	[ReturnDate] AS DATEADD(dd, 14, [LoanDate]),
	CONSTRAINT PK_Loan_LoanID PRIMARY KEY(LoanID),
	CONSTRAINT FK_Loan_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer (CustomerID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT FK_Loan_CopyID FOREIGN KEY(CopyID) REFERENCES Copy (CopyID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);

ALTER TABLE [Loan]
Add CONSTRAINT AK_Loan UNIQUE (LoanID)


DECLARE @AuthorID INT
INSERT INTO dbo.Author 
(FirstName,LastName,YearOfBirth,YearOfDeath,[Language],[Country])
VALUES('Mattias','Thander','1957',NULL, 'French', 'Sweden')
	, ('jeams', 'alssoon','1985', NULL, 'English', 'Britain')
	, ('Adam', 'davidson','1955', NULL, 'Spanish', 'Spain')
	, ('Hone', 'ahsson','1981', NULL, 'English', 'Britain')
	, ('Asbon', 'Lock','1995', NULL, 'English', 'Britain')
	, ('Matta', 'dogsson','1977', NULL, 'French', 'France')

SET @AuthorID = SCOPE_IDENTITY()

SELECT *
FROM Author

DECLARE @CustomerID INT
INSERT INTO dbo.Customer (FirstName, LastName, TelephoneNumber, Email, Gender, BirthYear)
VALUES('Gedoc', 'Sintset', '0922636435', 'as@hotmail.com', 'Male', '1988')
	, ('malin', 'person', '0822636431', 'as@facebook.org', 'Male', '1990')
	, ('karin', 'olsson', '0522636433', 'as@lnu.fr', 'Male', '1989')
	, ('Mats', 'samsson', '0722636431', 'as@yahoo.nu', 'Male', '1948')
	, ('Stafan', 'edsson', '0725636437', 'as@gmail.se', 'Male', '1978')

SET @CustomerID = SCOPE_IDENTITY()

SELECT *
FROM Customer


DECLARE @BookID int
INSERT INTO dbo.Book(AuthorID, Name, PublishedYear, YearOfDeath, [Language])
VALUES(@AuthorID, 'Alkemisten', '1989', null, 'Swedish')
	, (@AuthorID, 'Pipi', '1990', '2014', 'English')
	, (@AuthorID, 'The Secrete', '1955', null, 'Spanish')
	, (@AuthorID, 'Obama', '1980', null, 'English')
	, (@AuthorID, 'The Night', '1933', null, 'English')
	, (@AuthorID, 'Once Upon a time', '1990', null, 'French')


SET @BookID = SCOPE_IDENTITY()

SELECT *
FROM Book

SELECT Name, A.FirstName AS 'AuthorName', A.AuthorID
FROM dbo.BOOK AS B
	INNER JOIN dbo.Author AS A ON B.AuthorID = A.AuthorID;


INSERT INTO dbo.[Status] ([StatusID],[Value])
VALUES (1,'Avaliable')
	,(2,'Rented Out')
	,(3,'Delaied')

SELECT *
FROM [Status]

DECLARE @CopyID INT
INSERT INTO dbo.Copy
(StatusID, BookID, [PurchaseCost],[PurchaseYear])
VALUES(1, @BookID, '5000', '2007')
	, (1, @BookID, '678', '2008')
	, (1, @BookID, '600', '2010')
	, (1, @BookID, '400', '2001')
	, (1, @BookID, '3000', '2015')
	, (1, @BookID, '100', '1990')

SET @CopyID = SCOPE_IDENTITY()

SELECT *
FROM [Copy]

DECLARE @LoanID int
INSERT INTO dbo.Loan (CustomerID, CopyID ,LoanDate, ReturnDate)
VALUES(@CustomerID, @CopyID,'2015-03-10','2015-03-24')
	, (@CustomerID, @CopyID,null,null)
	, (@CustomerID, @CopyID,null,null)
	, (@CustomerID, @CopyID,null,null)
	, (@CustomerID, @CopyID,null,null)
	, (@CustomerID, @CopyID,null,null)

SET @LoanID = SCOPE_IDENTITY()


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
		, l.LoanDate
		, cp.CopyID
		, cp.StatusID
		, b.Name
		, s.Value
	from Customer C
		inner join loan l on l.CustomerID = c.CustomerID
		inner join Copy cp on l.CopyID = cp.CopyID
		inner join Book b on b.BookID = cp.BookID
		inner join [Status] s on s.StatusID = cp.StatusID

SELECT *
	
FROM Author AS A
	INNER JOIN Book AS B ON B.AuthorID = A.AuthorID 
	INNER JOIN Copy AS CO ON B.BookID = CO.BookID
	INNER JOIN Loan AS L ON CO.CopyID = L.CopyID
	INNER JOIN Customer AS C ON C.CustomerID = L.CustomerID
	INNER JOIN [Status] AS S ON S.StatusID = CO.StatusID