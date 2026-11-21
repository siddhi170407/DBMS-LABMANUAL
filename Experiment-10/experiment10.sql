# Experiment 10: SQL Query Analysis and Optimization

## Aim
To analyze and optimize five slow SQL queries using EXPLAIN, indexing and query rewriting.

## Objectives
- Understand SQL query optimization.
- Identify inefficient query patterns.
- Analyze execution plans using EXPLAIN.
- Create indexes to improve query performance.
- Rewrite queries for better efficiency.
- Compare query execution plans before and after optimization.

## Theory

### 1. Query Optimization
Query optimization is the process of improving SQL queries to reduce execution time and resource consumption while preserving the intended results.

### 2. EXPLAIN
EXPLAIN displays the execution plan chosen by the MySQL query optimizer.

It helps identify:
- Full table scans.
- Index usage.
- Join methods.
- Estimated rows examined.
- Additional operations such as sorting.

### 3. Indexing
Indexes provide efficient access paths to database records.

Indexes are especially useful for selective WHERE conditions and certain JOIN, ORDER BY and GROUP BY operations.

### 4. Query Rewriting
Query rewriting involves modifying the structure of a SQL query while preserving its meaning.

Examples include:
- Replacing unnecessary SELECT * with required columns.
- Avoiding functions on indexed columns in WHERE conditions.
- Rewriting expressions to make index usage possible.
- Replacing inefficient filtering patterns with selective conditions.

### 5. Five Optimization Cases

**Query 1: Employee Search by Department**

Problem: Searching employees by department without a suitable secondary index.

Optimization: Create an index on Dept_ID.

**Query 2: Employee Search by Salary**

Problem: Filtering a large employee table without an index on Salary.

Optimization: Create an index on Salary.

**Query 3: Filtering by YEAR()**

Problem: Applying YEAR() to a date column may prevent efficient use of a conventional index.

Optimization: Rewrite the condition using a date range and create an index on Joining_Date.

**Query 4: Employee–Department JOIN**

Problem: Joining tables without an efficient access path for employee department references.

Optimization: Create an index on Employee.Dept_ID.

**Query 5: Sorting Employees by Salary**

Problem: Sorting records may require additional processing when no suitable index is available.

Optimization: Create an index on Salary and examine whether the optimizer can use it for ORDER BY.

## Procedure
1. Create Employee and Department tables.
2. Insert sample records.
3. Execute five queries and inspect their execution plans.
4. Identify inefficient access methods.
5. Create appropriate indexes.
6. Rewrite applicable queries.
7. Execute the optimized queries.
8. Compare the execution plans and timings.
9. Record observations.

## Expected Output
The optimized queries may use more efficient index-based access methods.

The actual performance improvement depends on data volume, query selectivity and MySQL optimizer decisions.

## Result
Five SQL query patterns were analyzed using EXPLAIN and optimized through indexing and query rewriting.

## Conclusion
SQL query optimization helps improve database performance by reducing unnecessary scanning, sorting and processing. Execution plans should be measured to verify the effectiveness of each optimization.
