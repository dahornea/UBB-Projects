-- Insert into Fish table (FishID, FishSpecies)
Insert into Fish values(1, 'Bass')
Insert into Fish values(2, 'Trout')
Insert into Fish values(3, 'Salmon')
Insert into Fish values(4, 'Koi')
Insert into Fish values(5, 'Black Cod')
Insert into Fish values(6, 'Tuna')

-- Insert into Salary table (SalaryID, Amount)
Insert into Salary values(1, 10000)
Insert into Salary values(2, 20000)
Insert into Salary values(3, 30000)

-- Insert into Farm Table (FarmID, FarmName, FarmCity, Number of employees)
Insert into Farms values(1, 'Dorians Farm Galati', 'Galati', 20)
Insert into Farms values(2, 'Dorians Farm Piatra Neamt', 'Piatra Neamt', 30)
Insert into Farms values(3, 'Dorians Farm Cluj-Napoca', 'Bucuresti', 40)
Insert into Farms values(-3, 'Dorians Farm Iasi', 'Iasi', 15)  -- Error, Negative ID

-- Insert into Employee Table (EmployeeID, FarmID, EmployeeName, EmployeeCity, EmployeeExperience, SalaryID)
Insert into Employee values(1, 1, 'Iakab', 'Ocna Mures' ,5, 2)
Insert into Employee values(2, 1, 'Dorian', 'Galati',10, 3)
Insert into Employee values(3, 2, 'Aurel', 'Abrud',3, 2)
Insert into Employee values(4, 2, 'Cristi', 'Piatra Neamt',4, 2)
Insert into Employee values(5, 3, 'Alex', 'Galati',2, 1)


-- Insert into Orders Table (OrderID, FishQuantity, Price, FishID)
Insert into Orders values(1, 40, 200, 1)
Insert into Orders values(2, 20, 350, 2)
Insert into Orders values(3, 10, 400, 3)
Insert into Orders values(4, 50, 450, 4)
Insert into Orders values(5, 25, 500, 5)
Insert into Orders values(6, 30, 550, 6)

-- Insert into Lakes Table (LakeID, LakeName, LakeCity, Number of Fishermen)
Insert into Lakes values(1, 'Lake Brates', 'Galati', 20)
Insert into Lakes values(2, 'Lake Izvorul Muntelui', 'Piatra Neamt', 15)
Insert into Lakes values(3, 'Lake Dambovita', 'Bucuresti', 10)
Insert into Lakes values(4, 'Lake Dumbrava', 'Iasi', 7)
Insert into Lakes values(5, 'Lake Bicaz', 'Bicaz', 5)

-- Insert into Fishermen Table (FishermanID, FishermanName, FishermanFishIncome, SalaryID, LakeID)
Insert into Fishermen values(1, 'Marian', 150, 1, 1)
Insert into Fishermen values(2, 'Ion', 100, 1, 2)
Insert into Fishermen values(3, 'Vasile', 75, 1, 3)
Insert into Fishermen values(4, 'Gheorghe', 90, 1, 4)
Insert into Fishermen values(5, 'Dorel', 120, 2, 5)
Insert into Fishermen values(6, 'Mihai', 115, 2, 1)

-- Update
update Farms set City = 'Cluj-Napoca' where FAid = 3
update Lakes set Name = 'Lake Tarnita' where Lid = 3
update Lakes set City = 'Cluj-Napoca' where Lid = 3
update Fishermen set Name = 'Stefan' where FMid = 4
update Fishermen set Supply = 100 where FMid = 4  -- "="
update Employee set FAid = 1 where FAid is null   -- null
update Farms set No_Of_Employees=No_Of_Employees + 5 where City in ('Galati', 'Piatra Neamt') and No_Of_Employees between 20 and 40   -- AND, IN, BETWEEN

-- Delete
delete from Orders where Oid = 5
delete from Fishermen where Name like 'Mihai%'  -- like

-- (A.)

-- Select all Lakes and Farms from Galati or that have more than 10 Fishermen
select name from Lakes where City = 'Galati' or No_Of_Fishermen > 10
union
select Name from Farms where City = 'Galati'

-- All employees from Farm 2 or 3
select name from Employee where FAid = 2 or FAid = 3

-- (B.)

-- All cities with Farms and Lakes
select City from Farms
intersect
select City from Lakes

select City from Farms where City in (select City from Lakes)

-- (C.)

-- Cities with Lakes but no Farms
select City from Lakes
except
select City from Farms

select City from Lakes where City not in (select City from Farms)

-- (D.)

-- Print for each Lake it's Fishermen
select L.Name, FM.Name from Lakes L inner join Fishermen FM on L.Lid = FM.Lid

-- Select Fish that can be found in at least a lake and a fish tank (2 many to many relations)
select distinct F.Species    -- distinct
from Fish F
    inner join FishTanks FT on F.Fid = FT.Fid
    inner join FishInLakes FIL on F.Fid = FIL.Fid
    inner join Lakes L on FIL.Lid = L.Lid
    inner join FishInFishTanks FIFT on F.Fid = FIFT.Fid   -- check this out later

-- Print for each Employee it's FarmName and and it's SalaryAmount  (3 tables)
select E.Name, F.Name, S.Amount from Employee E
    left join Farms F on E.FAid = F.FAid
    left join Salary S on E.SAid = S.SAid

-- Print for each Lake it's Fishermen or if there are no Fishermen, print the Lake anyway
select distinct L.Name, FM.Name from Lakes L     --distinct
    right join Fishermen FM on L.Lid = FM.Lid

-- Print all all fish-lakes relationships, whether they both exist or not
select F.Species, L.Name from Fish F
    full join FishInLakes FIL on F.Fid = FIL.Fid
    full join Lakes L on FIL.Lid = L.Lid
    order by L.Name       -- order


-- (E.)

-- Print the name of the Farms which Employees have a salary greater than 20000
select distinct F.Name  -- distinct
from Farms F
where F.FAid in(
    select E.Name
    from Employee E
    inner join Salary S on E.SAid = S.SAid
    inner join Farms F on E.FAid = F.FAid
    where S.Amount > 20000
)

-- Print the names of the FishTanks that have fish that appear in an order
select FT.name
from FishInFishTanks FT
where FT.Fid in(
    select F.Fid
    from Fish F
    where F.Fid in(
        select O.Fid
        from Orders O
    )
)

-- (F.)

-- Print Lakes that have Fishermen
select L.name
from Lakes L
where exists(
    select *
    from Fishermen FM
    where FM.Lid = L.Lid
)

-- Print Farms with Employees
select F.name
from Farms F
where exists(
    select *
    from Employee E
    where E.Faid = F.FAid
    order by F.No_Of_Employees -- order
)


-- (G.)

-- Print the Farms with at least 10 employees that have a salary greater than 10000

Select t.Name
from(
    select *
    From Farms F
    where not F.No_Of_Employees < 10    -- not 
)t where t.FAid in(
    select E.FAid
    from Employee E
    where E.SAid in(
        select S.SAid + 1000 as increased_salary -- arithmetic expression
        from Salary S
        where S.Amount > 10000
    )
)

-- Print fish which start with 'K' and which appear in an order
select a.Species
from(
    select *
    from Fish F
    where F.Species like 'K%'
)a where a.Fid in(
    select O.Fid
    from Orders O
)


-- (H.)

-- Print cities with at least 2 farms
select F.City, count(*) as farms
from Farms F
group by F.City
having count(*) > 1

-- Print the top 3 farms with the most employees
select top 3 F.FAid, F.Name, count(*) as Employees      --top
from Farms F inner join Employee E on F.FAid = E.FAid
group by F.FAid, F.Name
having count(*) = (
    select max(t.C)
    from (select count(*) C
        from Farms F inner join Employee E on F.FAid = E.FAid
        group by F.FAid, F.Name
    )t
)

-- Print the fish that appear in the most orders
select F.Species, count(*) as Orders
from Fish F inner join Orders O on F.Fid = O.Fid
group by F.Species
having count(*) = (
    select max(t.C)
    from (select count(*) C
        from Fish F inner join Orders O on F.Fid = O.Fid
        group by F.Species
    )t
)

-- Print the experience of the employees with the number of employees for each number of years
-- Also the top 3 employees with the most experience
select top 3 Experience, count(*) as number_of_employees    -- top
from Employee 
group by Experience


-- (I.)

-- Print farms with more employees than all farms in Iasi
select F.Name, F.No_Of_Employees
from Farms F
where F.No_Of_Employees > all (
    select F2.No_Of_Employees
    from Farms F2
    where F2.City = 'Iasi'
)

-- Print farms with more employees than all farms in Iasi (aggregation operator)
select F.Name, F.No_Of_Employees
from Farms F
where F.No_Of_Employees > (
    select max(F2.No_Of_Employees)
    from Farms F2
    where F2.City = 'Iasi'
)

-- Print Lakes with 3 times more Fishermen than the rest
select L.Name, L.No_Of_Fishermen
from Lakes L
where L.No_Of_Fishermen/3 > any (      -- arithmetic expression
    select L2.No_Of_Fishermen
    from Lakes L2
    where L2.Lid = L.Lid
)

-- Print Lakes with 3 times more Fishermen than the rest (aggregation operator)
select L.Name, L.No_Of_Fishermen
from Lakes L
where L.No_Of_Fishermen/3 > (
    select min (L2.No_Of_Fishermen)
    from Lakes L2
    where L2.Lid = L.Lid
)

-- Print employees who are from neither of the cities with farms, but work in at least one
select E.Name
from Employee E
where E.City <> all (
    select F.City
    from Farms F
) and E.FAid in(         -- and
    select E2.FAid
    from Employee E2
)


-- Print employees who are from neither of the cities with farms, but work in at least one (NOT IN)

select E.name
from Employee E
where E.City not in(
    select F.City
    from Farms F
) and E.FAid in(             -- and
    select E2.FAid
    from Employee E2
)

-- Print Employees from cities that start with 'G' or with more than 5 years of experience, if their farm has more than 10 employees
select E.Name
from Employee E
where E.City like 'G%' or E.Experience > 5 and E.FAid in(      -- or
    select F.FAid
    from Farms F
    where F.No_Of_Employees > 10
)

-- Print Lakes from any city

select L.Name
from Lakes L
where L.City = any(
    select distinct L2.City
    from Lakes L2
)

-- Print Lakes from any city (IN)

select L.Name
from Lakes L
where L.City in(
    select distinct L2.City
    from Lakes L2
)


-- Print Employees with Salary 3 times greater than the rest of the employees
select E.Name
from Employee E
where E.SAid in(
    select S.SAid
    from Salary S
    where S.Amount /3 >  any(
        select S2.Amount
        from Salary S2
        where S2.SAid = S.SAid
    )
)