GO
use FishFarm
GO

-- Ta: Salary(Amount)
-- Tb: Lakes(Name, City, No_Of_Fishermen)
-- Tc: Fishermen(FMName, Supply, SAid, Lid)

CREATE OR ALTER PROCEDURE insertSalary
@n INT
AS
BEGIN
		DECLARE @i INT = 0
		WHILE @i < @n
		BEGIN
				INSERT INTO Salary(SAid, Amount, Bonus) VALUES (1000 * @i+ @i,@i, 100*(@i%2))
				SET @i = @i + 1
		END
END
GO

CREATE OR ALTER PROCEDURE insertLakes
@n INT
AS
BEGIN
		DECLARE @i INT = 0
		WHILE @i < @n
		BEGIN
				INSERT INTO Lakes(Name, City, No_Of_Fishermen) VALUES (CONCAT('Name',@i), CONCAT('City',@i), @i)
				SET @i = @i + 1
		END
END
GO

CREATE OR ALTER PROCEDURE insertFishermen
@n INT
AS
BEGIN
		DECLARE @i INT =0
		declare @id int = (SELECT TOP 1 Lid FROM Lakes)
		WHILE @i < @n
		BEGIN
				INSERT INTO Fishermen(FMName, Supply, SAid, Lid) VALUES (Concat('FMName', @i), @i,-1* @i, @id)
				SET @i = @i + 1
		END
END
GO

CREATE OR ALTER PROCEDURE deleteAll
AS
BEGIN
		
		DELETE FROM Fishermen WHERE SAid <= 0
		DELETE FROM Salary WHERE SAid >= 0
		DELETE FROM Lakes WHERE Name LIKE 'Name%'
END
GO

EXEC insertSalary 1000
EXEC insertLakes 1000
EXEC insertFishermen 1000

EXEC deleteAll



SELECT * FROM Fishermen

-- a) clustered index scan
SELECT * 
FROM Salary
WHERE Amount > 50
ORDER BY SAid DESC
-- clustered index seek
SELECT *
FROM Salary
WHERE SAid > 0

--nonclustered index scan + key lookup
SELECT S.Amount
From Salary S
ORDER BY Amount

SELECT Bonus FROM Salary
WHERE Amount = -50

--nonclustered index seek
SELECT SAid
From Salary
where Amount = 20000

-- b)

GO
DROP INDEX Idx_NC_No_Of_Fishermen ON Lakes
GO
--without creating the index, the query will be a clustered index scan
SELECT *
FROM Lakes
WHERE No_Of_Fishermen = 5

CREATE nonclustered INDEX Idx_NC_No_Of_Fishermen ON Lakes(No_Of_Fishermen)
--with the index, the query will be a nonclustered index seek

-- c)

GO
CREATE OR ALTER VIEW cView
AS
    SELECT F.FMName, S.Amount
    FROM Salary S
    INNER JOIN Lakes L ON S.Amount = L.No_Of_Fishermen
    INNER JOIN Fishermen F  ON S.SAid = F.SAid

GO
SELECT * FROM cView 
