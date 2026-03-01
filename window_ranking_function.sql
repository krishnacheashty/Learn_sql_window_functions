SELECT 
*
FROM Sales.Orders

--					RANKING WINDOW FUNCTION
/*  1) ROW_NUMBER()--Assign a unique number to each in a window.
				syntax-- ROW_NUMBER () OVER(ORDER BY _____)
	2) RANK() -- Assign a rank to each row in a window,with gaps.
				syntax-- RANK () OVER(ORDER BY _____)
	3) DENSE_RANK() --Assign a rank to each row in a window, without gaps.
				syntax-- DENSE_RAMK () OVER(ORDER BY _____)
	4)CUME_DIST()-- calculates the cumulative distribution of a value
					within a set of values.
				syntax-- CUME_DIST () OVER(ORDER BY _____)
	5)PERCENT_RANK () --Returns the percentile ranking number of 
						approximately equal group.
				syntax-- PERSENT_RANK () OVER(ORDER BY _____)
	6)NTILE ()--Divides the rows into a specified number of approximately
				equal group.
				syntax-- NTILE (n) OVER(ORDER BY _____)

				here n is 1,2,3,4,5.....
				*/


--RANK the orders based on their sales from highest to lowest


SELECT 
O.OrderID,
O.ProductID,
O.Sales,
ROW_NUMBER() OVER(ORDER BY O.Sales DESC) RANK_SALES 
FROM Sales.Orders AS O

--Ranking is unique.Do not shear any row .


					-- RANK () --
--ASSIGN A RANK TO EACH ROW.
-- IT HANDELES TIES.
--IT LEAVES GAPS IN RANKING.


--RANK the orders based on their sales from highest to lowest
--and find where are rank be shearing. 
SELECT
*
FROM(

	SELECT 
	O.OrderID,
	O.ProductID,
	O.Sales,
	ROW_NUMBER() OVER(ORDER BY O.Sales DESC) RANK_SALES ,
	RANK() OVER(ORDER BY O.Sales DESC) Rank_sales_shearingRow 
	FROM Sales.Orders AS O
)t WHERE RANK_SALES != Rank_sales_shearingRow;



					-- DENSE_RANK()
--ASSIGN A RANK TO EACH ROW.
-- IT HANDELES TIES.
--IT DOSEN'T LEAVES GAPS IN RANKING.

SELECT 
	O.OrderID,
	O.ProductID,
	O.Sales,
	ROW_NUMBER() OVER(ORDER BY O.Sales DESC) RANK_SALES ,
	RANK() OVER(ORDER BY O.Sales DESC) Rank_sales_shearingRow ,
	DENSE_RANK() OVER(ORDER BY O.Sales DESC) Rank_sales_shearingRow 
FROM Sales.Orders AS O;


					-- TASK 1
--FIND the top highest sales for each product.
SELECT
*
FROM(
	SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) rank_sales
FROM Sales.Orders
)t where rank_sales =1;


--			BOTTOM-N Analysis
--HELP ANALYSIS THE UNDERPERFORMANCE TO MANAGE RISKS AND TO DO OPTIMIZATION



--					TASK -02

--Find the lowest 2 customers based on total sales.
SELECT
*
FROM(
SELECT 
CustomerID,
SUM(SALES) TotalSales,
ROW_NUMBER() OVER(ORDER BY SUM(SALES)) rankSalesUnique
FROM Sales.Orders
GROUP BY CustomerID
)t WHERE rankSalesUnique <=2;


--							TASK 04

-- ASSING UNIQUE idS TO THE ROWS OF THE "ORDERS ARCHIVE" TABLE

SELECT
ROW_NUMBER() OVER(ORDER BY ORDERID,OrderDate) UniqueID,
*
FROM Sales.OrdersArchive O

-- find duplicates
--indefy and remove duplicates rows to improve data quality


-- ASSING UNIQUE idS TO THE ROWS OF THE "ORDERS ARCHIVE" TABLE
-- and return without any duplicates
SELECT
*
FROM(

	SELECT
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) UniqueID,
	*
FROM Sales.OrdersArchive O
)t WHERE  UniqueID =1;



-- If you want to find which are duplicate then
SELECT
*
FROM(

	SELECT
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) UniqueID,
	*
FROM Sales.OrdersArchive O
)t WHERE  UniqueID > 1;

SELECT

*,
CONCAT(DISTRANK*100, '%') Distrank
FROM(
SELECT
	P.Product,
	P.ProductID,
	P.Price,
	CUME_DIST() OVER(ORDER BY Price DESC) DISTRANK
FROM Sales.Products AS P
)t WHERE DISTRANK <= .4


				-- NTILL ()
SELECT
O.CustomerID,
O.OrderID,
O.Sales,
NTILE(1) OVER(ORDER BY Sales DESC) oneBucket,
NTILE(2) OVER(ORDER BY Sales DESC) twoBucket,
NTILE(3) OVER(ORDER BY Sales DESC) threeBucket,
NTILE(4) OVER(ORDER BY Sales DESC) threeBucket,
NTILE(5) OVER(ORDER BY Sales DESC) threeBucket
FROM Sales.Orders AS O


--					task 05
--Segment all orders into 3 categories : high ,medium and low sales
SELECT
*,
CASE BUCKETS
	WHEN 1 THEN 'HIGH'
	WHEN 2 THEN 'MEDIUM'
	ELSE 'LOW'
	END

FROM(   
	SELECT
	O.CustomerID,
	O.OrderID,
	O.Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) BUCKETS
FROM Sales.Orders AS O
) t 



--find ther products that fall within the highest 40% of prices
