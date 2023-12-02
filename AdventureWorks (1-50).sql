----SQL Queries: AdventureWorks (1-50)

   --1.  Write a query to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.
      
   select *
     from HumanResources.Employee
     order by JobTitle;

   --2. Write a query to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname.

   select P.* 
     from person.Person as P
     order by LastName asc;

   --3. Write a query to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.
      
   select FirstName,LastName,BusinessEntityID as Employee_Id 
   from Person.Person as P
   order by LastName;

   --4. Write a query to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.
      
   select productid, productnumber,name 
   from Production.Product
   where SellStartDate is not null and ProductLine = 'T'
   order by Name asc;

   --5. Write a query to return all rows from the salesorderheader table and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal. 
   
   select salesorderid,customerid,orderdate,subtotal, (TaxAmt*100)/SubTotal as tax_percent
   from Sales.SalesOrderHeader
   order by SubTotal;  
	 
   --6. Write a query to create a list of unique jobtitles in the employee table. Return jobtitle column and arranged the resultset in ascending order.
     
   select distinct JobTitle
   from HumanResources.Employee;

   --7. Write a query to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.

   select SalesOrderID, sum(freight) as total_freight
   from Sales.SalesOrderHeader
   group by SalesOrderID 
   order by SalesOrderID;

   --8. Write a query to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
      
   select SalesOrderID, avg(subtotal) as avg_subtotal, sum(subtotal) as sum_subtotal 
   from Sales.SalesOrderHeader 
   group by SalesOrderID 
   order by SalesOrderID desc;

   --9. Write a query to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order.  
      
    select productid,sum(quantity) as total_quantity 
    from production.ProductInventory
    where Shelf IN('A','C','H')
    group by ProductID having sum(quantity)>500
    order by ProductID; 

   --10. Write a query in SQL to find the total quentity for a group of locationid multiplied by 10.

   select SUM(quantity) as total_quantity 
   from Production.ProductInventory 
   GROUP BY (LocationID*10);

   --11. Write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName. Sort the result on lastname and firstname.

   select BusinessEntityID, FirstName, LastName
   from Person.Person
   where LastName like 'L%' 
   order by LastName, FirstName;

   --12. Write a query to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
   
   Select  distinct salespersonid, customerid,sum(subtotal) as sum_subtotal 
   from sales.SalesOrderHeader 
   group by Rollup(SalesPersonID,CustomerID);

   --13. Write a query to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.

   select  LocationID,Shelf,sum(quantity) as total_quantity 
   from Production.ProductInventory 
   group by cube(LocationID,Shelf); 

   --14. Write a query to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.
  
  select  LocationID,Shelf,sum(quantity) as total_quantity 
   from Production.ProductInventory 
   group by grouping sets(rollup(LocationID,Shelf),cube(LocationID,Shelf));

   --15. Write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.
   
   select LocationID,sum(quantity)as total_quantity 
   from production.ProductInventory 
   group by grouping sets(locationid,());

   --16. Write a query to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.
   
   select a.city, count(b.addressID) as numberofemployees 
   from person.BusinessEntityAddress as b 
   inner join Person.Address as a on b.AddressID=a.AddressID 
   group by a.city order by a.city;

   --17. Write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.

   select datepart (year,orderdate) as Year,sum(TotalDue) as TotalAmount
   from sales.SalesOrderHeader
   group by datepart (year,orderdate) 
   order by datepart (year,orderdate);

   --18. Write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.
  
   select datepart (year,orderdate) as Year,sum(TotalDue) as TotalAmount
   from sales.SalesOrderHeader   
   group by datepart (year,orderdate) 
   having  datepart(year,orderdate)<= '2016'
   order by datepart (year,orderdate);

   --19. Write a query to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.

   select ContactTypeID,name
   from person.ContactType 
   where name like '%manager%'
   order by name asc;

   --20. Write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.

   select p.businessentityid,firstname,lastname
   from Person.BusinessEntityContact as p
   inner join person.ContactType as pc on p.ContactTypeID=pc.ContactTypeID 
   inner join person.Person as pp on p.ContactTypeID=pp.BusinessEntityID 
   where pc.Name='Purchasing Manager'
   order by LastName, FirstName;

   --21.  Write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
   
   select ROW_NUMBER() over (partition by postalcode order by salesytd desc) as 'ROW NUMBER',Postalcode,lastname,SalesYTD 
   FROM Sales.SalesPerson as ss inner join person.Person as pp on ss.BusinessEntityID=pp.BusinessEntityID 
   inner join Person.Address as pa on pa.AddressID=pp.BusinessEntityID 
   where TerritoryID is NOT NULL  and SalesYTD <> 0 
   order by PostalCode;

   --22. Write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.
   
   select pc.ContactTypeID, name, count(*) as NoContacts 
   from person.BusinessEntityContact as pbe
   inner join Person.ContactType as pc on pc.ContactTypeID=pbe.ContactTypeID
   group by pc.ContactTypeID,name 
   having count(*)>=100 
   order by count(*) desc;

   --23. Write a query to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.

   select cast(ratechangedate as varchar(10)) as fromdate,CONCAT(firstname,' ',middlename,' ',lastname) as fullname, (40*rate) as salaryinweek 
   from person.person as pp 
   inner join HumanResources.EmployeePayHistory as hr on pp.BusinessEntityID=hr.BusinessEntityID
   order by fullname;
   
   --24. Write a query to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.

   select cast(ratechangedate as varchar(10)) as fromdate,CONCAT(firstname,' ',middlename,' ',lastname) as fullname, (40*rate) as salaryinweek
   from person.person as pp inner join HumanResources.EmployeePayHistory as hr on pp.BusinessEntityID=hr.BusinessEntityID  
   WHERE RateChangeDate = (SELECT MAX(RateChangeDate)
                                FROM HumanResources.EmployeePayHistory 
                                WHERE BusinessEntityID = hr.BusinessEntityID) order by fullname;

   --25. Write a query to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.
   
   select SalesOrderID,SalesOrderDetailID,OrderQty,sum(Orderqty) over (partition by salesorderid) as total_quantity,
                                                avg(OrderQty) over (partition by salesorderid) as avg_quantity,
                                                count(orderqty) over (partition by salesorderid) as no_of_orders,
                                                MAX(orderqty) over (partition by salesorderid)as max_qty,
												min(orderqty) over (partition by salesorderid) as min_qty 
	from sales.SalesOrderDetail 
	where SalesOrderID  IN (43659,43644) ;

	--26. Write a query to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

	select SalesOrderID AS OrderNumber, ProductID,
    OrderQty as Quantity,
    sum(OrderQty) over (order by SalesOrderID, ProductID) AS Total,
    avg(OrderQty) over(partition by SalesOrderID ORDER BY SalesOrderID, ProductID) AS Avg,
    count(OrderQty) over(order by SalesOrderID, ProductID ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS Count
    from Sales.SalesOrderDetail
    where SalesOrderID IN(43659,43664) and cast(ProductID AS TEXT) LIKE '71%';

	--27. Write a query to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.

   select SalesOrderID,sum(UnitPrice*OrderQty) as total_cost
      from sales.SalesOrderDetail  
      group by salesorderid 
      having sum(UnitPrice*OrderQty)>100000;

   --28. Write a query to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on product ID column.
 
   select ProductID,Name
     from Production.Product 
     where Name like 'Lock Washer%' 
     order by ProductID;

   --29. Write a query to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product.

   select ProductID,name,Color 
     from Production.Product
     order by ListPrice;

   --30. Write a query to retrieve records of employees. Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.
  
   select BusinessEntityID,JobTitle, HireDate 
   from HumanResources.Employee
   order by year(HireDate);

   --31. Write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.

   select LastName,FirstName  
   from  Person.Person 
   where LastName like 'R%' 
   order by FirstName asc,lastname desc;

   --32. Write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.
 
   select BusinessEntityID,SalariedFlag 
   from HumanResources.Employee 
   order by CASE
        WHEN SalariedFlag = 'true' THEN BusinessEntityID end desc,
		CASE  WHEN SalariedFlag = 'false' THEN BusinessEntityID end;

   --33. Write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.

   select * 
       from Sales.vSalesPerson
	   where TerritoryName is not null	
	   order by case
       when CountryRegionName= 'United State' then TerritoryNam
	   else CountryRegionName end;

   --34. Write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.

     select FirstName,LastName,
	 ROW_NUMBER() OVER(Order by postalcode) as 'ROW NUMBER', 
	 DENSE_RANK() OVER (ORDER BY POSTALCODE) AS 'DENSE RANK',
	 NTILE(4) OVER(ORDER BY POSTALCODE) AS 'QUARTILE'
     from Sales.SalesPerson as ss 
     inner join Person.Person as p on ss.BusinessEntityID=p.BusinessEntityID 
	 inner join Person.Address as pa on pa.AddressID=p.BusinessEntityID
	 where TerritoryID is not null and SalesYTD<>0;

	 --35. Write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.
    
	select * 
	    from HumanResources.Department
		order by DepartmentID offset 10 rows;

	--36. Write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.

    select * 
	   from HumanResources.Department 
	   order by DepartmentID
	   offset 5 rows
	   fetch next 5 rows ONLY;

   --37. Write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice. 

   select name,color,ListPrice 
       from Production.Product 
       where color IN('Red','Blue')
       order by ListPrice;

   --38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column.

      select name,s.SalesOrderID 
	         from Production.Product as p full 
			 outer join Sales.SalesOrderDetail as s on p.ProductID=s.SalesOrderID 
			 order by p.name;

   --39. Write a  query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.

   select name,s.SalesOrderID 
      from Production.Product as p left join Sales.SalesOrderDetail as s on p.ProductID=s.SalesOrderID 
	  order by p.name;

   --40. Write a query to get all product names and sales order IDs. Order the result set on product name column.

   select name,s.SalesOrderID 
      from Production.Product as p full 
	  outer join Sales.SalesOrderDetail as s on p.ProductID=s.SalesOrderID
	  order by p.name; 

   --41. Write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether or not they are assigned a territory.
   
   select BusinessEntityID,name  
      from sales.SalesTerritory as st 
	  right join sales.SalesPerson as sp on sp.TerritoryID=st.TerritoryID;

   --42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname.

   select concat(firstname,' ',lastname),city  
      from person.Person as p left join HumanResources.Employee as hr on p.BusinessEntityID=hr.BusinessEntityID
	  left join person.Address as pa on pa.AddressID=hr.BusinessEntityID 
	  left join person.BusinessEntity as pb on pb.BusinessEntityID=p.BusinessEntityID
	  order by lastname,firstname; 

   --43. Write a query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. 

   select BusinessEntityID,firstname,lastname
      from Person.person 
	  where PersonType = 'IN' and LastName='Adams' 
	  order by firstname;

   --44. Create a query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.
   
   select *
      from Person.Person 
	  where BusinessEntityID<=1500 and LastName like'Al%' and FirstName like 'M%';

   --45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.

   select productid,Name,Color
       from Production.Product
	   where name IN('Blade','Crown Race','AWC Logo cap');

   --46. Create a query to display the total number of sales orders each sales representative receives annually. Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.

   with Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
       as
   (
    select SalesPersonID, SalesOrderID, datepart(year,OrderDate) as SalesYear
    from Sales.SalesOrderHeader
    where SalesPersonID IS NOT NULL
    )
   SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
   from Sales_CTE
   group by SalesYear, SalesPersonID
   order by SalesPersonID, SalesYear;

   --47. Write a query to find the average number of sales orders for all the years of the sales representatives.
  
     WITH Sales_CTE (SalesPersonID, NumberOfOrders)
    AS
    (
       Select SalesPersonID, COUNT(*)
          from Sales.SalesOrderHeader
          where SalesPersonID IS NOT NULL
          group by SalesPersonID
          )
        Select AVG(NumberOfOrders) AS "Average Sales Per Person"
          from Sales_CTE;


   --48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table's columns must all be returned.

   select * 
      FROM Production.ProductPhoto 
	  WHERE LargePhotoFileName LIKE '%greena_%' ESCAPE 'a' ;

   --49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.
   select AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode 
      from Person.Address AS a  
      JOIN Person.StateProvince AS s ON a.StateProvinceID = s.StateProvinceID  
      WHERE CountryRegionCode NOT IN ('US') AND City LIKE 'Pa%' ;

   --50. Write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.
   
   select top 20 JobTitle,HireDate
       from HumanResources.Employee;
