

ALTER PROCEDURE Production.uspInsertCategory
(
	@Name varchar(50)
)
AS
BEGIN
INSERT INTO Production.ProductCategory(Name)
VALUES (@Name)

--returnera det senaste identity-id som skapades
SELECT SCOPE_IDENTITY()

END


