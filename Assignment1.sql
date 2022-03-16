--1.
select ProductID, Name, Color, ListPrice 
from Production.Product 

--2.
select ProductID, Name, Color, ListPrice 
from Production.Product 
where ListPrice <>0

--3.
select ProductID, Name, Color, ListPrice 
from Production.Product 
where Color is null


--4.
select ProductID, Name, Color, ListPrice 
from Production.Product 
where Color is not null


--5.
select ProductID, Name, Color, ListPrice 
from Production.Product 
where Color is not null
and ListPrice  >0

--6.
select Name+Color
from Production.Product 
where Color is not null


--7.
select Name, Color
from Production.Product 
where (Name like '%Crankarm%' or Name like '%Chainring%')
and Color in ('Black','Silver')

--8.
select ProductID ,Name
from Production.Product 
where ProductID between 400 and 500

--9.
select ProductID ,Name
from Production.Product 
where ProductID between 400 and 500

--10.
select *
from Production.Product 
where Name like 'S%'

--11.
select  Name, ListPrice 
from Production.Product 
where (Name like 'Seat%'
or name like 'Short-Sleeve Classic%')
and name not like '%, XL'
AND name not like '%, S'
ORDER BY NAME

--12.
select  Name, ListPrice 
from Production.Product 
where Name like 'S%'
OR Name like 'A%'
order by Name

--13.
select  Name, ListPrice 
from Production.Product 
where Name like 'SPO%'
and Name not like 'SPOK%'
order by Name

--14.
select distinct Color
from Production.Product 
order by Color desc

--15
select distinct  ProductSubcategoryID,Color 
from Production.Product 
where ProductSubcategoryID  is not null 
and Color is not null
order by ProductSubcategoryID desc

