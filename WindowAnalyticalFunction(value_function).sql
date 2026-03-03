/*   Window Analytical Function

			LEAD(expr,offset,default)

  1) access a value from the next row within a window


			use TIME SERIES ANALYSIS
		-- THE process of analyzing the data to understand
			patterns,trends,and behaviors over time.

			1) YEAR-OVER-YEAR analysis(YoY) --> Analyze the overall 
			
			groth or decline of the business's performance over time.
			
			2) MONTH-OVER-MONTH (MoM)--> Short time analyze trends and 
					discover patterns in seasonality
*/

--Analyze the month-over-month performance by finding the percentage 
--change in sales between the current and previous month.

SELECT
*,
CurrentMonthSales-PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales-PreviousMonthSales) AS FLOAT)/PreviousMonthSales*100,2) MoM
--ROUND(CAST((CurrentMonthSales-PreviousMonthSales) AS FLOAT)/PreviousMonthSales*100,1)
FROM(
SELECT 
	MONTH(OrderDate) OrderMonth,
	SUM(Sales) CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY 
MONTH(OrderDate)
)t



 --			LEAD(expr,offset,default)

 -- access a value from the next row within a window
 /*
 customer retention analysis
 Measure customer's behavior and loyalty to help businesses build 
 strong relationships with customers.
 */

 -- In order to analyze customer loyalty,
 -- rank customes based on the avarage days bewteen their order.
 SELECT
 CustomerID,
 AVG(DiffDays) avgDay,
 RANK() OVER(ORDER BY COALESCE(AVG(DiffDays),9999)) RankInCustomer
 FROM(
	 SELECT 
	 O.OrderID,
	 O.CustomerID,
	 O.OrderDate CurrentDay,
	 LEAD(O.OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) nextOrderDay,
	 DATEDIFF(day,O.OrderDate,LEAD(O.OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DiffDays
	 FROM Sales.Orders AS O
	 )t
	 GROUP BY CustomerID


	 --FIRST_VALUE()->Access a value from the firdt row within a window.
	 --syntex--> FIRST_VALUE() OVE(ORDER BY)


							-- TASK -3
		--Find lowest and highest fro each product
		-- Finf the difference in sales between the current and the lowest sales
SELECT
		O.OrderID,
		O.ProductID,
		O.Sales,
		FIRST_VALUE(O.Sales) OVER(PARTITION BY ProductID ORDER BY O.Sales) LowestValue,
		LAST_VALUE(O.Sales) OVER(PARTITION BY ProductID ORDER BY O.Sales 
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighistValue,
		O.Sales - FIRST_VALUE(O.Sales) OVER(PARTITION BY ProductID ORDER BY O.Sales) SalesDeffirent
		--FIRST_VALUE(O.Sales) OVER(PARTITION BY ProductID ORDER BY O.Sales DESC) HighistValue2
FROM Sales.Orders AS O

--This is a compare analysis