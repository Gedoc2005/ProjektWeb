--LAB_3
--Uppgift 4

--CREATE DATABASE MyLibre;

CREATE TABLE Author
(
AuthorID int NOT NULL IDENTITY(1,1),
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
YearOfBirth date NOT NULL,
YearOfDeath date NULL,
[Language] varchar(50) NOT NULL,
[Country] varchar(50) NOT NULL,
CONSTRAINT PK_Author_AuthorID PRIMARY KEY (AuthorID)
);

CREATE TABLE Customer
(
--CopyID int,
CustomerID int NOT NULL IDENTITY(1,1),
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
TelephoneNumber int NULL,
Email varchar(50) NOT NULL,
Gender varchar(50) NOT NULL,
BirthYear date NOT NULL,
CONSTRAINT PK_Customer_CustomerID PRIMARY KEY(CustomerID),
--CONSTRAINT FK_Customer_CopyID FOREIGN KEY(CopyID) REFERENCES Copy (CopyID)
);

CREATE TABLE Book
(
AuthorID int,
BookID int NOT NULL IDENTITY(1,1),
Name varchar(50) NOT NULL,
PublishedYear date NOT NULL,
YearOfDeath date NULL,
[Language] varchar(50) NOT NULL,
CONSTRAINT PK_Book_BookID PRIMARY KEY(BookID),
CONSTRAINT FK_Book_AuthorID FOREIGN KEY(AuthorID) REFERENCES Author (AuthorID)
);

CREATE TABLE [Status]
(
[StatusID] int NOT NULL IDENTITY(1,1),
[Value] varchar(50) NOT NULL
CONSTRAINT PK_Status_StutusID PRIMARY KEY(StatusID)
);

CREATE TABLE [Copy]
(
[StatusID] int,
[CopyID] int NOT NULL IDENTITY(1,1),
[PurchaseCost] money NULL,
[PurchaseYear] date NOT NULL
CONSTRAINT PK_Copy_CopyID PRIMARY KEY(CopyID)
CONSTRAINT FK_Copy_StatusID FOREIGN KEY(StatusID) REFERENCES [Status] (StatusID)
);

CREATE TABLE [Loan]
(
LoanID int NOT NULL IDENTITY(1,1),
CustomerID int,
CopyID int,
LoanDate date NULL,
	--CONSTRAINT DF_LoanDate_CurrentDate DEFAULT GETDATE(),
[ReturnDate] date NOT NULL,
CONSTRAINT PK_Loan_LoanID PRIMARY KEY(LoanID),
CONSTRAINT FK_Loan_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer (CustomerID),
CONSTRAINT FK_Loan_CopyID FOREIGN KEY(CopyID) REFERENCES Copy (CopyID)
);

--kopia/låntagare
CREATE TABLE [CopyOut]
(
CopyOutID int NOT NULL IDENTITY(1,1),
LoanID int,
CustomerID int,
CONSTRAINT PK_CopyOut_CopyOutID PRIMARY KEY(CopyOutID),
CONSTRAINT FK_CopyOut_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer (CustomerID),
CONSTRAINT FK_CopyOut_LoanID FOREIGN KEY(LoanID) REFERENCES [Loan] (LoanID),
);

--kopia/låntagare/status
CREATE TABLE [LoanInfo]
(
LoanInfoID int NOT NULL IDENTITY(1,1),
CopyOutID int,
[StatusID] int,
CONSTRAINT PK_LoanInfo_LoanInfoID PRIMARY KEY(CopyOutID),
CONSTRAINT FK_LoanInfo_CopyOutID FOREIGN KEY(CopyOutID) REFERENCES CopyOut (CopyOutID),
CONSTRAINT FK_LoanInfo_StatusID FOREIGN KEY(StatusID) REFERENCES [Status] (StatusID)
);
