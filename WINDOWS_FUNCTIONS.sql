--               task-01
--find the number of customers
--FIND the total sales of all orders
--Find total average sales of all orders
--find the highest sales of all orders
--Find the lowest sales of all orders

SELECT 
c.CustomerID,
COUNT(*) AS TOTAL_NU_SALES,
SUM(C.Score) Total_sales,
AVG(C.Score) AS average_sales,
MAX(C.Score) AS max_sales,
MIN(C.Score) AS Min_sales
FROM Sales.Customers AS C
GROUP BY CustomerID;


					/*	WINDOWS FUNCTIONS   */

/*What is windows functions ?

perfrom calculations(e.g aggregation) on a specific subset of data with 
losing the level of details of rows.

*/

--TOTAL SALES FOR EACH PRODUCT

SELECT 
ProductID,
--CustomerID,
--OrderID
SUM(Sales)
FROM Sales.Orders
GROUP BY ProductID

--group by changes the granularity
/* windows functions

aggregate function
1.count()	2.sum()	3.avg()		4.MIN()		5.MIN()

RANK functions 

1.ROW_NUMBER()
2.RANK()
3.DENSE_RANK()
4.CUME_DIST()
5.PERCENT_RANK()
6.NTIIE(n)

VALUE (Analytics) function

1.LEAD(expr,offset,default)
2.LAG(expr,offset,default)
3.FIRST_VALUE(expr)
4.LAST_VALUE(expr)
*/

-- find the total sales across all orders.

SELECT 
SUM(Sales) Total_Sales
FROM Sales.Orders

-- find the total sales across all orders.

SELECT 
SUM(Sales) Total_Sales
FROM Sales.Orders

-- find the total sales for each product.

SELECT 
	ProductID,
	SUM(Sales) Total_Sales
FROM Sales.Orders
GROUP BY ProductID;

/*find the total sales for each product,Additionally provide details
such orderId order date.*/

SELECT 
	ProductID,
	OrderDate,
	SUM(Sales) OVER(PARTITION BY ProductId,OrderDate) Total_Sales
FROM Sales.Orders
