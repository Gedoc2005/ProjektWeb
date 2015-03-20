CREATE DATABASE DemoDatabase1;
USE DemoDatabase1

CREATE TABLE Orders
(
	OrderID int NOT NULL,
	OrderDate date NOT NULL,
	Shipdate date NULL
);
GO

--Ändra en kolumn
ALTER TABLE Orders
ADD CustomerID int NOT NULL;

--Ändra
ALTER TABLE Orders
ALTER COLUMN OrderDate datetime NOT NULL

--TA BORT KOLUMN
ALTER TABLE Orders
DROP COLUMN CustomerID

