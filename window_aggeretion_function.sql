--Find the tiotal number of orders

SELECT 
O.CustomerID,
O.OrderID,
O.Sales,
SUM(O.Sales) OVER() AS TOTALsALES,
COUNT(*) OVER() TOTAL_ORDERS
FROM Sales.Orders AS O
/*		OVERALL ANALYSIS
	Quick summery or snapshot of the entire dataset. */

--Find the total number of orders
--find the total orders for each customers
-- additionally provide details such order id & order date
SELECT 
O.OrderID,
O.CustomerID,
O.OrderDate,
SUM(O.Sales) OVER(PARTITION BY O.OrderID,O.OrderDate ) AS TOTALsALES,
COUNT(*) OVER() TOTAL_ORDERS,
COUNT(1) OVER(PARTITION BY O.CustomerID) AS OrderByCustomerID
FROM Sales.Orders AS O

--Find the total number of customers
--additionally provide all customers details

-- how many null value in a column.
--solution : count(*)-count(column)
SELECT 
*,
COUNT(*) OVER() AS TotalCustomer,
COUNT(c.Country) OVER() AS total_countryNum,
COUNT(c.Score) OVER() AS total_Score,
COUNT(c.FirstName) OVER() AS total_First_name
FROM Sales.Customers AS C


--check whether the table 'order' contains any duplicate row

SELECT
O.OrderID,
COUNT(*) OVER(PARTITION BY O.OrderID) AS checkPK
--PARTITION BY the data by the primary key.
FROM Sales.Orders AS O
--Here on duplicate id present.


--check whether the table 'order' contains any duplicate row
SELECT 
*
FROM(
SELECT
O.OrderID,
COUNT(*) OVER(PARTITION BY O.OrderID) checkPK
FROM Sales.OrdersArchive AS O
)t WHERE checkPK >1;

--find the total sales across all orders
--Find the total sales for each product
--Additionally provide details such order id,order date

SELECT
ProductID,
OrderID,
OrderDate,
Sales,
SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSales
FROM Sales.Orders


--Find the percentage contribution of each prodct's sales to the TOTAL sales

SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales ,
ROUND(CAST(Sales AS float)/SUM(Sales) OVER() *100,2) PERCENTAGEoFtOTAL,
AVG(Sales) OVER() SalesAVG
FROM Sales.Orders
/*Note : dividing two integer columns produces
 an integer,not a decimal 
 To solve use CAST() */

