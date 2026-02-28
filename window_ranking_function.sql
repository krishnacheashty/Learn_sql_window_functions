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



