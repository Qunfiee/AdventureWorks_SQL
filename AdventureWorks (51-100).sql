----SQL Queries: AdventureWorks (51-100)

   --51. Write a query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100.
   --Return all the columns from the tables.

   select * 
     from Sales.SalesOrderHeader as SH 
	 inner join sales.SalesOrderDetail as SD on SH.SalesOrderID=SD.SalesOrderID
	 where TotalDue>100 and (OrderQty >5 or UnitPriceDiscount<1000);

   --52. Write a query that searches for the word 'red' in the name column. Return name, and color columns from the table.

   select name,Color
      from production.Product
      where color like'red';

   --53. Write a query to find all the products with a price of $80.99 that contain the word Mountain. Return name, and listprice columns from the table.

   select name,ListPrice from
      Production.Product
	  where name like '%Mountain%' and listprice= 80.99;

   --54. Write a querY to retrieve all the products that contain either the phrase Mountain or Road. Return name, and color columns.

   select  name, Color 
      from production.Product 
	  where name like '%Mountain%' or name like '%Road%';

   --55. Write a query to search for name which contains both the word 'Mountain' and the word 'Black'. Return Name and color.
   
   select name,Color 
      from production.Product
	  where name like '%Mountain%' and name like '%Black%' ;

   --56. Write a query to return all the product names with at least one word starting with the prefix CHAIN in the Name column.

   select name, color 
      from Production.product
	  where name ='Chain' or name like 'Chain %';

   --57. Write a query to return all category descriptions containing strings with prefixes of either CHAIN or FULL.

   select name, color
      from Production.product
	  where name ='Chain' or name like 'Chain %' or name like 'Full%' or name='Full';

   --58. Write a SQL query to output an employee's name and email address, separated by a new line character.

   select concat(firstname,lastname,' ',char(13),emailaddress)
      from Person.person as pp 
	  inner join Person.EmailAddress as pe on pp.BusinessEntityID=pe.BusinessEntityID 
	  where pp.BusinessEntityID=1;

   --59. Write a query to locate the position of the string "yellow" where it appears in the product name.

   --60. Write a query to concatenate the name, color, and productnumber columns.

   select CONCAT(name,' ','color:-',color,' ','product number:', productnumber) as result,color
      from Production.Product;

   --61. Write a query that concatenate the columns name, productnumber, colour, and a new line character from the following table, each separated by a specified character.
  
   select  concat_ws(',',name,productnumber,color,char(13)) as result
      from Production.Product;

   --62. Write a query in SQL to return the five leftmost characters of each product name.

   select left(name,5) as left_product 
     from Production.Product;

   --63. Write a query in SQL to select the number of characters and the data in FirstName for people located in Australia.

   select LEN(firstname)as length,FirstName
      from sales.vIndividualCustomer
	  where CountryRegionName='Australia';

   --64. Write a query to return the number of characters in the column FirstName and the first and last name of contacts located in Australia
   
   select distinct LEN(firstname)as length,FirstName,LastName 
      from sales.vIndividualCustomer as vi
	  inner join Sales.vStoreWithAddresses as vs on vs.BusinessEntityID=vi.BusinessEntityID 
	  where vi.CountryRegionName='Australia';

   --65. Write a query to select product names that have prices between $1000.00 and $1220.00. Return product name as Lower, Upper, and also LowerUpper.

   select LOWER(name) as lower,UPPER(name) as Upper,lower(upper(name)) as lowerUpper 
      from Production.Product
	  where StandardCost between 1000 and 1220;

   --66. Write a query in SQL to remove the spaces from the beginning of a string.

   select '    five space then the text' as 'original text', ltrim('    five space then the text') as 'Trimmed';

   --67. write a query in SQL to remove the substring 'HN' from the start of the column productnumber. 
   --Filter the results to only show those productnumbers that start with "HN". Return original productnumber column and 'TrimmedProductnumber'.
   
   select ProductNumber,Ltrim (productnumber,'HN')as trimmed
     from production.Product 
	 where ProductNumber like 'HN%';

   --68. Write a query to repeat a 0 character four times in front of a production line for production line 'T'.

   select name, concat(replicate(0,4),ProductLine) as NEWL
      from Production.product where ProductLine = 'T' 
	  order by name;

   --69. Write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6.

   select firstname, REVERSE(FirstName) 
      from person.Person
	  where businessentityid < 6;

   --70. Write a query in SQL to return the eight rightmost characters of each name of the product. Also return name, productnumber column. 
   --Sort the result set in ascending order on productnumber.

   select Name, ProductNumber,right(name,8) as productname 
      from Production.product 
	  order by ProductID;

   --71. Write a query in SQL to remove the spaces at the end of a string.

   select '    five space then the text' as 'original text', rtrim('    five space then the text') as 'Trimmed';

   --72. Write a query to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. Return productnumber and name.

   select ProductNumber, Name 
     from Production.Product 
	  where Name like '%[SLM]';

   --73. Write a query to replace null values with 'N/A' and return the names separated by commas in a single row.

   select STRING_AGG(coalesce(firstname,'N/A'),',') as new
      from person.person;

   --74. Write a query to return the names and modified date separated by commas in a single row.
   
   select STRING_AGG(concat(firstname,' ',ModifiedDate),',') as new
      from person.person;

   --75. Write a query to find the email addresses of employees and groups them by city. Return top ten rows.

   select top 10 city, STRING_AGG(CONVERT(nvarchar(max),[EmailAddress]),';') 
      from person.BusinessEntityAddress as bea 
	  inner join person.Address as pa on  bea.BusinessEntityID=pa.AddressID
	  inner join person.EmailAddress as pea on bea.BusinessEntityID=pea.BusinessEntityID
	  group by City ;

   --76. Write a query to create a new job title called "Production Assistant" in place of "Production Supervisor".
   
   select jobtitle,REPLACE(jobtitle,'production supervisor','production assistant') as new_job_title
      from HumanResources.Employee;

   --77. Write a query to retrieve all the employees whose job titles begin with "Sales". Return firstname, middlename, lastname and jobtitle column.
   
   select FirstName,MiddleName,LastName
     from person.person as pp 
	 left join HumanResources.Employee as hr on pp.BusinessEntityID=hr.BusinessEntityID 
	 where JobTitle like 'sales%';

   --78. Write a query in SQL to return the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.

   select CONCAT(upper(rtrim(lastname)),',',' ',' ',FirstName) 
      from person.Person;

   --79. Write a query in SQL to show a resulting expression that is too small to display. Return FirstName, LastName, Title, and SickLeaveHours.
   --The SickLeaveHours will be shown as a small expression in text format.

   select top 5 FirstName,LastName,Title,convert( char(1), [SickLeaveHours]) as sick_leave 
      from HumanResources.Employee as hr 
	  right join person.Person as pp on hr.BusinessEntityID=pp.BusinessEntityID;

   --80. Write a query in SQL to retrieve the name of the products. Product, that have 33 as the first two digits of listprice.
  
   select name, ListPrice 
      from Production.Product 
	  where ListPrice like '33%';

   --81. Write a query to calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT).
   --Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.

   select SalesYTD,CommissionPct,cast(ROUND((salesytd/commissionpct),0) as  int) as computed 
      from sales.SalesPerson 
	  where CommissionPct!=0;

   --82. Write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. 
   --Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID.

   select FirstName,LastName,SalesYTD,p.BusinessEntityID 
      from person.Person as p left join Sales.SalesPerson as ss on p.BusinessEntityID=ss.BusinessEntityID   
	  where cast(cast(ss.salesytd as int) as char(20)) like'2%';

   --83. Write a query to convert the Name column to a char(16) column. 
   --Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.

   select convert(  char(16), [name]),ListPrice 
      from Production.product
	  where name like 'Long-Sleeve Logo Jersey%';

   --84. Write a SQL query to determine the discount price for the salesorderid 46672. Calculate only those orders with discounts of more than.02 percent. 
   --Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).

   select ProductID,UnitPrice,UnitPriceDiscount,round((UnitPrice*UnitPriceDiscount),0) as DiscountPrice
      from sales.SalesOrderDetail
	  where SalesOrderID=46672 and UnitPriceDiscount>0.02;

   --85. Write a query to calculate the average vacation hours, and the sum of sick leave hours, that the vice presidents have used.

   select AVG(vacationhours) as avg_vacation_hours, sum(SickLeaveHours) as 'total sick leave'
      from HumanResources.Employee 
	  where JobTitle like 'Vice President%';

   --86. Write a query to calculate the average bonus received and the sum of year-to-date sales for each territory. Return territoryid, Average bonus, and YTD sales.

   select TerritoryID,AVG(bonus) as 'avg bonus',sum(SalesYTD) as 'total sales'
     from Sales.SalesPerson 
	  group by TerritoryID;

   --87. Write a query to return the average list price of products. Consider the calculation only on unique values.

   select (avg(distinct listprice)) as average
     from production.Product;

   --88. Write a query in SQL to return a moving average of yearly sales for each territory. 
   --Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

   select BusinessEntityID, TerritoryID, year(ModifiedDate) AS SalesYear ,
     cast(SalesYTD as VARCHAR(20)) AS  SalesYTD  ,
     AVG(SalesYTD) OVER (PARTITION BY TerritoryID ORDER BY year(ModifiedDate)) AS MovingAvg   ,
     SUM(SalesYTD) OVER (PARTITION BY TerritoryID ORDER BY year(ModifiedDate)) AS CumulativeTotal 
     FROM Sales.SalesPerson 
	 WHERE TerritoryID IS NULL OR TerritoryID < 5 
	 ORDER BY TerritoryID,SalesYear;

   --89.write a query to return a moving average of sales, by year, for all sales territories.
   --Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

   select BusinessEntityID, TerritoryID, year(ModifiedDate) AS SalesYear   ,
   cast(SalesYTD as VARCHAR(20)) AS  SalesYTD  ,
   AVG(SalesYTD) OVER (PARTITION BY TerritoryID ORDER BY year(ModifiedDate)) AS MovingAvg ,
   SUM(SalesYTD) OVER (PARTITION BY TerritoryID ORDER BY year(ModifiedDate)) AS CumulativeTotal 
   FROM Sales.SalesPerson  
   WHERE TerritoryID IS NULL OR TerritoryID < 5  
   ORDER BY TerritoryID,SalesYear;

   --90. Write a query in SQL to return the number of different titles that employees can hold.

   select count(distinct JobTitle) as ' No of Employees' 
      from HumanResources.employee;

   --91. Write a query in SQL to find the total number of employees.
   
   select count(distinct NationalIDNumber) as ' No of Employees' 
      from HumanResources.employee;

   --92. Write a query in SQL to find the average bonus for the salespersons who achieved the sales quota above 25000. Return number of salespersons, and average bonus.

   select count(BusinessEntityID) as nos,avg(Bonus) 
      from sales.SalesPerson 
	  where SalesQuota>25000;

   --93. Write a query to return aggregated values for each department. Return name, minimum salary, maximum salary, average salary, and number of employees in each department.

   select DISTINCT Name, 
      MIN(Rate) OVER (PARTITION BY edh.DepartmentID) AS MinSalary ,
      MAX(Rate) OVER (PARTITION BY edh.DepartmentID) AS MaxSalary , 
      AVG(Rate) OVER (PARTITION BY edh.DepartmentID) AS AvgSalary ,
      COUNT(edh.BusinessEntityID) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept  
      from HumanResources.EmployeePayHistory AS eph 
      JOIN HumanResources.EmployeeDepartmentHistory AS edh ON eph.BusinessEntityID = edh.BusinessEntityID
      JOIN HumanResources.Department AS d  ON d.DepartmentID = edh.DepartmentID 
      WHERE edh.EndDate IS NULL
      ORDER BY Name;

   --94. Write a SQL query to return the departments of a company that each have more than 15 employees.

   select JobTitle,count(NationalIDNumber) 
      from HumanResources.Employee  
      group by JobTitle 
      having count(NationalIDNumber)>15;

   --95. Write a query in SQL to find the number of products that ordered in each of the specified sales orders.	  

   select SalesOrderID,sum(OrderQty) as orders 
      from sales.SalesOrderDetail
	  group by SalesOrderID;

   --96. Write a query in SQL to compute the statistical variance of the sales quota values for each quarter in a calendar year for a sales person.
   --Return year, quarter, salesquota and variance of salesquota.


   --97. Write a query in SQL to populate the variance of all unique values as well as all values, including any duplicates values of SalesQuota column.

   select VAR(SalesQuota) as dup,var(distinct SalesQuota) as dis 
      from sales.SalesPersonQuotaHistory;

   --98. write a query in SQL to return the total ListPrice and StandardCost of products for each color. Products that name starts with 'Mountain' and ListPrice is more than zero. 
   --Return Color, total list price, total standardcode. Sort the result set on color in ascending order.

   select color,sum(ListPrice) as total,sum(StandardCost) 
      from Production.Product 
	  where name like 'Mountain%' and ListPrice>0
	  group by Color 
	  order by color;

   --99. Write a query to find the TotalSalesYTD of each SalesQuota.
   --Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.
   select SalesQuota, SUM(SalesYTD) as "TotalSalesYTD" , 
     GROUPING(SalesQuota) as "Grouping" 
      from Sales.SalesPerson  
       GROUP BY rollup(SalesQuota);

   --100. Write a query in SQL to calculate the sum of the ListPrice and StandardCost for each color. Return color, sum of ListPrice.
   select color,sum(ListPrice) as total,sum(StandardCost) 
      from Production.Product
	  group by Color;