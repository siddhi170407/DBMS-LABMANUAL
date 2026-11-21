# Experiment 4: SQL Joins, Correlated Subqueries, EXISTS and EXPLAIN

## Aim
To write SQL queries using joins, correlated subqueries and EXISTS, and compare their execution plans using EXPLAIN.

## Objectives
- Understand different types of SQL joins.
- Retrieve data from related tables.
- Implement correlated subqueries.
- Use EXISTS and NOT EXISTS operators.
- Analyze query execution plans using EXPLAIN.

## Theory

### 1. SQL Joins
Joins combine rows from two or more tables based on related columns.

- INNER JOIN returns only matching records.
- LEFT JOIN returns all records from the left table and matching records from the right table.
- RIGHT JOIN returns all records from the right table and matching records from the left table.

### 2. Correlated Subquery
A correlated subquery is a nested query that refers to columns from the outer query. It is logically evaluated in relation to each outer row, although the database optimizer may transform its execution.

### 3. EXISTS
EXISTS checks whether a subquery returns at least one row.

### 4. NOT EXISTS
NOT EXISTS checks whether a subquery returns no rows.

### 5. EXPLAIN
EXPLAIN displays information about how MySQL plans to execute a query.

Important EXPLAIN columns include:
- type — Access method used.
- possible_keys — Indexes that may be used.
- key — Index selected by the optimizer.
- rows — Estimated number of rows examined.
- Extra — Additional execution details.

## Procedure
1. Create Department and Employee tables.
2. Insert sample records.
3. Execute INNER, LEFT and RIGHT JOIN queries.
4. Write correlated subqueries.
5. Execute EXISTS and NOT EXISTS queries.
6. Use EXPLAIN to inspect query execution plans.
7. Compare the access methods and estimated row counts.

## Expected Output
The queries display employee and department information, employees earning above departmental averages, and departments with or without employees.

EXPLAIN displays execution plans for the selected queries.

## Result
SQL joins, correlated subqueries and EXISTS operators were implemented, and query execution plans were examined using EXPLAIN.

## Conclusion
Joins and subqueries provide different ways to retrieve related data. EXPLAIN helps understand how the database optimizer processes queries.
