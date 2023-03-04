create or alter procedure setSalaryAmountBigInt as
    alter table Salary alter column amount bigint
go
create or alter procedure setSalaryAmountInt as
    alter table Salary alter column amount int
go
create or alter procedure addAgeToEmployee as
    alter table Employee add age int
go
create or alter procedure removeAgeFromEmployee as
    alter table Employee drop column age
go
create or alter procedure addDefaultToLakeCity as
    alter table Lakes add constraint default_city default 'Galati' for City
go
create or alter procedure removeDefaultFromLakeCity as
    alter table Lakes drop constraint default_city
go
create or alter procedure addFishFood as
    create table FishFood (
        Provider varchar(50) not null,
        Flavor varchar(50) not null,
        Price int not null,
        Quantity int not null,
        constraint pk_fishfood primary key (Provider)
    )
go
create or alter procedure removeFishFood as
    drop table FishFood
go
create or alter procedure addFlavorPrimaryKeyFishFood as
    alter table FishFood
        drop constraint pk_fishfood
    alter table FishFood
        add constraint pk_fishfood primary key (Provider, Flavor)
go
create or alter procedure removeFlavorPrimaryKeyFishFood as
    alter table FishFood
        drop constraint pk_fishfood
    alter table FishFood
        add constraint pk_fishfood primary key (Provider)
go
create or alter procedure newCandidateKeySalary as
    alter table Salary
        add constraint Salary_Candidate_Key unique (SAid, Amount)
go
create or alter procedure removeCandidateKeySalary as
    alter table Salary
        drop constraint Salary_Candidate_Key
go
create or alter procedure newForeignKeyFarm as
    alter table Farms
        add constraint Farms_Foreign_Key foreign key (FTid) references FishTanks(FTid)
go
create or alter procedure removeForeignKeyFarm as
    alter table Farms
        drop constraint Farms_Foreign_Key
go


create table versionTable(
    version int
)

insert into versionTable values (1)  -- v 1.0

create table proceduresTable(
    fromVersion int,
    toVersion int,
    primary key (fromVersion, toVersion),
    nameProcedure varchar(100)
)

insert into proceduresTable values (1, 2, 'setSalaryAmountBigInt')
insert into proceduresTable values (2, 1, 'setSalaryAmountInt')
insert into proceduresTable values (2, 3, 'addAgeToEmployee')
insert into proceduresTable values (3, 2, 'removeAgeFromEmployee')
insert into proceduresTable values (3, 4, 'addDefaultToLakeCity')
insert into proceduresTable values (4, 3, 'removeDefaultFromLakeCity')
insert into proceduresTable values (4, 5, 'addFishFood')
insert into proceduresTable values (5, 4, 'removeFishFood')
insert into proceduresTable values (5, 6, 'addFlavorPrimaryKeyFishFood')
insert into proceduresTable values (6, 5, 'removeFlavorPrimaryKeyFishFood')
insert into proceduresTable values (6, 7, 'newCandidateKeySalary')
insert into proceduresTable values (7, 6, 'removeCandidateKeySalary')
insert into proceduresTable values (7, 8, 'newForeignKeyFarm')
insert into proceduresTable values (8, 7, 'removeForeignKeyFarm')
go
create or alter procedure updateDatabase(@newVersion int) as
    declare @curr int
    declare @var varchar(100)
    select @curr = version from versionTable

    
    while @curr > @newVersion begin
        select @var = nameProcedure from proceduresTable where fromVersion = @curr and toVersion = @curr - 1
        exec (@var)
        set @curr = @curr - 1
    end

    while @curr < @newVersion begin
        select @var=nameProcedure from proceduresTable where fromVersion = @curr and toVersion = @curr + 1
        exec(@var)
        set @curr = @curr + 1
    end

    update versionTable set version = @newVersion
go

execute updateDatabase 1

execute newForeignKeyFarm

update versio

select * from versionTable