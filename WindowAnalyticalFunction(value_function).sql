/*   Window Analytical Function

			LEAD(expr,offset,default)

  1) access a value from the next row within a window


			use TIME SERIES ANALYSIS
		-- THE process of analyzing the data to understand
			patterns,trends,and behaviors over time.

			1) YEAR-OVER-YEAR analysis(YoY) --> Analyze the overall groth
					or decline of the business's performance over time.
			
			2) MONTH-OVER-MONTH (MoM)--> Short time analyze trends and 
					discover patterns in seasonality
*/

--Analyze the month-over-month performance by finding the percentage 
--change in sales between the current and previous month.
SELECT
*,
CurrentMonthSales-PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales-PreviousMonthSales) AS FLOAT)/PreviousMonthSales*100,1)
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