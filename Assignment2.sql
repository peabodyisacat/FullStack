
--1.      How many products can you find in the Production.Product table?
select count(ProductID) from Production.Product




--2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. 
--The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
select count(distinct ProductID) from Production.Product
where ProductSubcategoryID is not null



--3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.
--ProductSubcategoryID CountedProducts
-------------------- ---------------
select ProductSubcategoryID, count(distinct ProductID) as CountedProducts 
from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID

--4.      How many products that do not have a product subcategory.
select count(distinct ProductID) from Production.Product
where ProductSubcategoryID is null


--5.      Write a query to list the sum of products quantity in the Production.ProductInventory table.
select sum(Quantity)
from Production.ProductInventory 

--6.    Write a query to list the sum of products in the Production.ProductInventory table 
--and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
--          	ProductID	TheSum
              -----------    	----------
select ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having sum(quantity) < 100

select * from Production.ProductInventory

--7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table 
--and LocationID set to 40 and limit the result to include just summarized quantities less than 100
--    Shelf  	ProductID	TheSum
    ----------   -----------    	-----------
	select distinct a.Shelf, a.ProductID, b.TheSum from Production.ProductInventory a
	inner join (
select  ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having sum(quantity) < 100) b
on a.ProductID = b.ProductID 

--8. Write the query to list the average quantity for products where column LocationID has 
--the value of 10 from the table Production.ProductInventory table.
select  avg(Quantity)
from Production.ProductInventory
where LocationID = 10

--9.    Write query  to see the average quantity  of  products by shelf  
--from the table Production.ProductInventory
--    ProductID   Shelf  	TheAvg
    ----------- ---------- -----------
select ProductID,   Shelf , avg(Quantity)
from Production.ProductInventory
group by ProductID, Shelf



--10.  Write query  to see the average quantity  of  products by shelf excluding 
--rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
   -- ProductID   Shelf  	TheAvg
    ----------- ---------- -----------
select ProductID,   Shelf , avg(Quantity)
from Production.ProductInventory
where Shelf <> 'N/A'
group by ProductID, Shelf

--11.  List the members (rows) and average list price in the Production.Product table. 
--This should be grouped independently over the Color and the Class column. 
--Exclude the rows where Color or Class are null.
--    Color       	         	Class          	TheCount     	 AvgPrice
    -------------- - -----    -----------        	---------------------
select Color, Class, count(ProductID), avg(ListPrice)
from Production.Product
group by Color, Class

--Joins:
--12.   Write a query that lists the country and province names from person. CountryRegion and 
--person. StateProvince tables. Join them and produce a result set similar to the following.
   -- Country                        Province
    ---------                      	----------------------
	select distinct r.name as Country, p.Name as Province
	from [Person].[CountryRegion] r 
	inner join [Person].[StateProvince] p
	on r.CountryRegionCode = p.CountryRegionCode


--13.  Write a query that lists the country and province names from person. CountryRegion and 
--person. StateProvince tables and list the countries filter them 
--by Germany and Canada. Join them and produce a result set similar to the following.
 
  --  Country                    	Province
    ---------                      	----------------------
	select distinct r.name as Country, p.Name as Province
	from [Person].[CountryRegion] r 
	inner join [Person].[StateProvince] p
	on r.CountryRegionCode = p.CountryRegionCode
	where r.name in ('Germany','Canada')



-- Using Northwnd Database: (Use aliases for all the Joins)
--14.  List all Products that has been sold at least once in last 25 years.

select * from [dbo].[Orders]
where OrderDate >= dateadd(yy,-25,getdate()) 


--15.  List top 5 locations (Zip Code) where the products sold most.
select top 5 ShipPostalCode,sum(d.quantity) from [dbo].[Orders] o 
inner join [dbo].[Order Details] d on o.OrderID = d.OrderID
where ShipPostalCode is not null
group by ShipPostalCode
order by 2 desc

--16.  List top 5 locations (Zip Code) where the products sold most in last 25 years.
select top 5 ShipPostalCode,sum(d.quantity) from [dbo].[Orders] o 
inner join [dbo].[Order Details] d on o.OrderID = d.OrderID
where ShipPostalCode is not null and OrderDate >= dateadd(yy,-25,getdate()) 
group by ShipPostalCode
order by 2 desc

--17.   List all city names and number of customers in that city.    
select city, count([CustomerID])
from [dbo].[Customers]
group by [City]
 
--18.  List city names which have more than 2 customers, and number of customers in that city
--17.   List all city names and number of customers in that city.    
select city, count([CustomerID])
from [dbo].[Customers]
group by [City]
having  count([CustomerID])>2

--19.  List the names of customers who placed orders after 1/1/98 with order date.
select c.CompanyName from [dbo].[Orders] o 
inner join dbo.Customers c on o.CustomerID = c.CustomerID
where OrderDate > '1/1/98'

--20.  List the names of all customers with most recent order dates
select o.CompanyName,  a.maxd from [dbo].[Customers] o 
inner join
(
select CustomerID, max(OrderDate) as maxd from [dbo].[Orders] 
group by CustomerID) a
on a.CustomerID = o.CustomerID 

--21.  Display the names of all customers  along with the  count of products they bought
select c.CompanyName, sum(d.[Quantity]) 
from [dbo].[Orders] o 
inner join dbo.Customers c on o.CustomerID = c.CustomerID
inner join [dbo].[Order Details] d on d.OrderID = o.OrderID
group by c.CompanyName

--22.  Display the customer ids who bought more than 100 Products with count of products.
select c.CompanyName, sum(d.[Quantity]) 
from [dbo].[Orders] o 
inner join dbo.Customers c on o.CustomerID = c.CustomerID
inner join [dbo].[Order Details] d on d.OrderID = o.OrderID
group by c.CompanyName
having sum(d.[Quantity]) >100

--23.  List all of the possible ways that suppliers can ship their products. Display the results as below
--    Supplier Company Name            	Shipping Company Name
--    ---------------------------------        	----------------------------------
select distinct sp.CompanyName as 'Supplier Company Name ', s.CompanyName as 'Shipping Company Name'
from Orders o inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p on p.ProductID = od.ProductID
inner join Shippers s on s.ShipperID = o.ShipVia
inner join Suppliers sp on sp.SupplierID = p.SupplierID



--24.  Display the products order each day. Show Order date and Product Name.
select distinct o.OrderDate, p.ProductName  from Orders o inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p on p.ProductID = od.ProductID


--25.  Displays pairs of employees who have the same job title.
select distinct e.FirstName+e.LastName, e1.FirstName+e1.LastName from [dbo].[Employees] e
inner join [dbo].[Employees] e1 on e.Title = e1.Title
where e.FirstName+e.LastName <>e1.FirstName+e1.LastName

--26.  Display all the Managers who have more than 2 employees reporting to them.
select distinct m.EmployeeID from [dbo].[Employees] m
inner join [dbo].[Employees] e on e.ReportsTo = m.EmployeeID
group by m.EmployeeID
having count(distinct e.EmployeeID)>2

--27.  Display the customers and suppliers by city. The results should have the following columns
--City
--Name
--Contact Name,
--Type (Customer or Supplier)

select c.City, c.CompanyName, c.ContactName, 'Customer'
from Orders o inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p on p.ProductID = od.ProductID
inner join Customers c on c.CustomerID = o.CustomerID
union
select sp.City, sp.CompanyName,sp.ContactName, 'Supplier'
from Orders o inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p on p.ProductID = od.ProductID
inner join Suppliers sp on sp.SupplierID = p.SupplierID