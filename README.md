### Key Concepts and Definitions

- **SQL Window Functions** allow performing calculations such as aggregations on subsets of data **without losing the row-level details**. Unlike GROUP BY, they preserve the granularity of the original dataset.
- **GROUP BY** aggregates data by grouping rows and collapsing multiple rows into one per group, hence losing detail.
- **Window functions** return the aggregation result for each row in the original dataset, maintaining the same number of rows.

---

### Comparison: GROUP BY vs Window Functions

| Feature                | GROUP BY                    | Window Functions                  |
|------------------------|----------------------------|---------------------------------|
| Row-level detail       | Lost (rows are aggregated) | Preserved (same number of rows) |
| Aggregation scope      | Entire group/window         | Window (partition) defined per row |
| Functions supported    | Aggregate functions only (SUM, COUNT, AVG, MAX, MIN) | Aggregate + Ranking + Analytic functions (LEAD, LAG, FIRST_VALUE, etc.) |
| Use case complexity    | Simple aggregations         | Advanced analytics, multi-level aggregation |
| Output granularity     | Changed by grouping columns | Same as input row granularity   |

---

### Practical Examples Demonstrated

- **Total sales across all orders**: Using `SUM(sales)` without GROUP BY returns a single aggregated value.
- **Total sales per product**: Using GROUP BY on `product_id` returns one row per product with aggregated sales.
- **Adding order-level details alongside total sales per product**:
  - Using GROUP BY with additional columns (e.g., `order_id`, `order_date`) causes errors or incorrect aggregation.
  - Using window functions with `SUM(sales) OVER (PARTITION BY product_id)` preserves detail and adds aggregated totals per product on each row.
- **Multiple levels of aggregation**: The tutorial shows adding total sales across all orders and total sales per product in the same query using multiple window functions.

---

### SQL Window Function Syntax Components

| Component               | Description                                                                                   |
|-------------------------|-----------------------------------------------------------------------------------------------|
| Window function         | The aggregation, ranking, or analytic function (e.g., `SUM()`, `RANK()`, `LEAD()`)            |
| Expression              | Argument passed to the function (e.g., column name, number, or complex expression)             |
| `OVER` clause           | Defines the window for the function                                                           |
| `PARTITION BY`          | Divides data into subsets (windows/partitions), similar to GROUP BY                           |
| `ORDER BY` (within OVER)| Sorts rows inside each partition; mandatory for ranking and analytic functions                |
| Frame specification     | Defines subset of rows within a window used for calculation (e.g., rows between current row and next two rows) |

---

### Groups of Window Functions

1. **Aggregate Functions** (COUNT, SUM, AVG, MAX, MIN): Same as used in GROUP BY.
2. **Ranking Functions** (ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE()): Assign ranks/order values within partitions.
3. **Value/Analytic Functions** (LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()): Access specific rows relative to the current row.

---

### Window Frame (Frame Clause)

- Defines the subset of rows within each window partition that participate in the calculation.
- Syntax examples:
  - `ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING`: Includes current row and next two rows.
  - `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`: Includes all rows from the start of the partition up to the current row.
- The **frame** slides as the query processes each row, allowing dynamic aggregation scopes.
- **Order By** clause is mandatory for using frame boundaries.
- Default frame if none specified: `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` (when ORDER BY is used).

---

### Rules and Limitations of SQL Window Functions

- **Allowed only in SELECT and ORDER BY clauses**; cannot be used in WHERE or GROUP BY clauses.
- **Window functions cannot be nested inside each other.**
- Window functions are **applied after filtering (WHERE clause)**.
- Can be combined with GROUP BY in the same query **only if the window function references columns included in the GROUP BY**.
- Ensure window function expressions align with grouped columns to avoid errors.

---

### Practical Use Case: Ranking Customers by Total Sales

- Use GROUP BY to aggregate total sales per customer.
- Use a window function `RANK() OVER (ORDER BY total_sales DESC)` to rank customers based on aggregated sales.
- This combination is possible only if the window function’s columns are part of the GROUP BY output.

---

### Summary of Best Practices

- Use **GROUP BY** for simple aggregations where detailed rows are not needed.
- Use **window functions** for advanced analytics requiring aggregations plus detailed row-level data.
- Combine both **GROUP BY and window functions** carefully following the rule that window functions operate on grouped results.
- Thoroughly understand **`PARTITION BY`**, **`ORDER BY`**, and **frame clauses** to master complex analytical queries.
- Respect the **usage limitations** of window functions to avoid SQL errors.

---

### Conclusion

**SQL window functions are a powerful extension beyond GROUP BY, enabling detailed, flexible, 
and complex analyses without losing row-level granularity.** They support advanced use cases including ranking,
lead-lag computations, and dynamic aggregation windows. Mastery of their syntax—especially the OVER clause 
and frame specification—is essential for sophisticated data analysis in SQL.

