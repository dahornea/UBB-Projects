GO
use FishFarm
GO

-- INSERT AND DELETE STATEMENTS
-- 1. A table with a single-column primary key and no foreign keys: Salary
-- Insert into Salary

CREATE or ALTER procedure addSalary
@n INT
AS
BEGIN
        DECLARE @i INT = 0
        WHILE @i < @n
        BEGIN
                INSERT  INTO Salary(SAid, Amount) VALUES (-1 * @i,-1 * @i)
                SET @i = @i + 1
        END
END
GO

-- Delete from Salary
CREATE or ALTER procedure deleteSalary
AS 
BEGIN
        DELETE FROM Salary WHERE Amount <= 0
END
GO

-- Insert into Fish
CREATE OR ALTER PROCEDURE addFish
@n INT
AS
BEGIN
        DECLARE @i INT = 0
        WHILE @i < @n
        BEGIN
                INSERT INTO Fish(Species) VALUES (CONCAT('Type ', @i))
                SET @i = @i + 1
        END
END
GO

-- Delete from Fish
CREATE OR ALTER PROCEDURE deleteFish
AS
BEGIN
        DELETE FROM Fish WHERE Species LIKE 'Type %'
END
GO

--INSERT INTO Lakes(Name, City, No_Of_Fishermen) VALUES ('Lake 1', 'City 1', 5)

-- 2. A table with a single-column primary key and at least one foreign key: Fishermen
-- Insert into Fishermen

CREATE OR ALTER PROCEDURE addFishermen
@n INT
AS
BEGIN
        DECLARE @i INT = 0
        DECLARE @type INT = (SELECT TOP 1 SAid FROM Salary WHERE Amount < 0)
		DECLARE @id INT = (SELECT TOP 1 Lid FROM Lakes)
        WHILE @i < @n
        BEGIN
                INSERT INTO Fishermen(FMName, Supply, SAid, Lid) VALUES (CONCAT('Type ', @i), 0, @type, @id)
                SET @i = @i + 1
        END
END
GO
-- Delete from Fishermen

CREATE OR ALTER PROCEDURE deleteFishermen
AS
BEGIN
        DELETE FROM Fishermen WHERE FMName LIKE 'Type %'
END
GO

-- 3. A table with a multi-column primary key: FishInLakes
-- Insert into FishInLakes

CREATE OR ALTER PROCEDURE addFishInLakes
@n INT
AS
BEGIN
        DECLARE @Fid INT
        DECLARE @Lid INT
        DECLARE c CURSOR
                LOCAL
                FOR
                SELECT F.Fid, L.Lid FROM (SELECT F.Fid from Fish F WHERE Species LIKE 'Type %') F CROSS JOIN Lakes L
        OPEN c
        DECLARE @i INT = 0
		FETCH NEXT FROM c INTO @Fid, @Lid
        WHILE @i < @n AND @@FETCH_STATUS >=0
        BEGIN
                INSERT INTO FishInLakes(Fid, Lid, filAmount) VALUES (@Fid, @Lid, -13)
                SET @i = @i + 1
				FETCH NEXT FROM c INTO @Fid, @Lid
        END
        CLOSE c
        DEALLOCATE c
END
GO
-- Delete from FishInLakes
CREATE OR ALTER PROCEDURE deleteFishInLakes
AS
BEGIN
        DELETE FROM FishInLakes WHERE filAmount = -13
END
GO

-- Views
-- 1. A view with a SELECT statement operating on one table
CREATE OR ALTER VIEW view1
AS
    SELECT * FROM Fish
GO
-- 2. A view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator;

CREATE OR ALTER VIEW view2
AS
    SELECT L.Name, FM.FMName FROM Lakes L
    JOIN Fishermen FM ON L.Lid = FM.Lid

-- 3. A view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator
GO
CREATE OR ALTER VIEW view3
AS
    SELECT L.Name, SUM(FM.Supply) AS SumSupply FROM Lakes L
    JOIN Fishermen FM ON L.Lid = FM.Lid
    where FM.Supply > 20
    GROUP BY L.Name
GO
CREATE OR ALTER PROCEDURE selectView
(@name VARCHAR(200))
AS
BEGIN
        DECLARE @sql VARCHAR(250) = CONCAT('SELECT * FROM ', @name)
        EXEC(@sql)
END
GO
INSERT INTO Tests (Name) VALUES ('addSalary'), ('deleteSalary'), ('addFish'), ('deleteFish'), ('addFishermen'), ('deleteFishermen'), ('addFishInLakes'), ('deleteFishInLakes'), ('selectView')
INSERT INTO Tables(Name) VALUES ('Salary'), ('Fish'), ('Fishermen'), ('FishInLakes')
INSERT INTO Views (Name) VALUES ('view1'), ('view2'), ('view3')
INSERT INTO TestViews (TestID, ViewID) VALUES (9, 1), (9, 2), (9, 3)
INSERT INTO TestTables(TestID, TableID, NoOfRows, Position) VALUES (2, 1, 400, 4), (1, 1, 200, 1), (4, 2, 700, 3), (3, 2, 500, 2), (6, 3, 800, 2), (5, 3, 600, 3), (8, 4, 900, 1), (7, 4, 1000, 4)

SELECT * FROM Tests
SELECT * FROM Tables
SELECT * FROM Views
SELECT * FROM TestViews
SELECT * FROM TestTables

GO
CREATE OR ALTER PROCEDURE runDeleteTests
AS 
BEGIN 
        DECLARE @tID INT 
        DECLARE @tName VARCHAR(200)

        DECLARE c CURSOR 
                LOCAL
                FOR SELECT t2.Name, t1.TestID FROM TestTables t1 INNER JOIN Tests t2 ON t1.TestID = t2.TestID WHERE t2.Name LIKE 'delete%'
                ORDER BY t1.Position
        OPEN c
        FETCH NEXT FROM c INTO @tName, @tID
        WHILE @@FETCH_STATUS = 0
        BEGIN
                EXEC @tName
                FETCH NEXT FROM c INTO @tName, @tID
        END

        CLOSE c
        DEALLOCATE c
END
GO

CREATE OR ALTER PROCEDURE runInsertTests (@tID INT)
AS
BEGIN
        DECLARE @testID INT
        DECLARE @tableID INT
        DECLARE @rows INT
        DECLARE @tName VARCHAR(200)

        DECLARE c CURSOR
                LOCAL
                FOR SELECT t2.Name, t1.TestID, t1.TableID, t1.NoOfRows FROM TestTables t1 INNER JOIN Tests t2 ON t1.TestID = t2.TestID WHERE t2.Name like 'add%'
                ORDER BY Position
        OPEN c
        FETCH NEXT FROM c INTO @tName, @testID, @tableID, @rows
        WHILE @@FETCH_STATUS = 0
        BEGIN
                DECLARE @t1 DATETIME = GETDATE()
                EXEC @tName @rows
                DECLARE @t2 DATETIME = GETDATE()
                INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt) VALUES (@tID, @tableID, @t1, @t2)
                FETCH NEXT FROM c INTO @tName, @testID, @tableID, @rows
        END

        CLOSE c
        DEALLOCATE c
END
GO

CREATE OR ALTER PROCEDURE runViewTests
@tID INT
AS 
BEGIN 
        DECLARE @vID INT

        DECLARE c CURSOR
                LOCAL
                FOR SELECT ViewID FROM TestViews

        OPEN c 
        FETCH NEXT FROM c INTO @vID
        WHILE @@FETCH_STATUS = 0
        BEGIN
                DECLARE @t1 DATETIME = GETDATE()

                DECLARE @vName VARCHAR(200) = (SELECT Name FROM Views WHERE ViewID = @vID)
                DECLARE @testName VARCHAR(200) = (SELECT Name FROM Tests t INNER JOIN TestViews tv ON t.TestID = tv.TestID WHERE tv.ViewID = @vID)

                EXEC @testName @vName

                DECLARE @t2 DATETIME = GETDATE()

                INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt) VALUES (@tID, @vID, @t1, @t2)

                FETCH NEXT FROM c INTO @vID

        END

        CLOSE c
        DEALLOCATE c

END
GO

CREATE OR ALTER PROCEDURE runProcs
AS
BEGIN
        INSERT INTO TestRuns (StartAt) VALUES (GETDATE())
        DECLARE @tID INT = SCOPE_IDENTITY()
        DECLARE @t0 DATETIME = GETDATE()

        EXEC runDeleteTests
        EXEC runInsertTests @tID
        EXEC runViewTests @tID

        UPDATE TestRuns SET Description = 'Just a test', EndAt = GETDATE() WHERE TestRunID = @tID
END

GO
CREATE OR ALTER PROCEDURE runAllTests(@n INT)
AS
BEGIN 
        DECLARE @i INT = 0
        WHILE @i < @n 
        BEGIN
                EXEC runProcs
                SET @i = @i + 1
        END

        SELECT * FROM TestRunTables
        SELECT * FROM TestRunViews
        SELECT * FROM TestRuns
END

EXEC runAllTests 1