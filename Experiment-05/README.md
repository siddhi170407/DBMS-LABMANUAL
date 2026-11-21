# Experiment 5: SQL Views and Recursive CTE

## Aim
To create SQL views, test their updatability, and implement a recursive Common Table Expression (CTE) for reporting chains.

## Objectives
- Create and retrieve data using SQL views.
- Understand simple and complex views.
- Test the updatability of views.
- Implement a recursive CTE.
- Display employee reporting hierarchies.

## Theory

### 1. SQL View
A view is a virtual table created using a SELECT query. It presents data from one or more underlying tables without normally storing a separate copy of the data.

### 2. Types of Views
- **Simple View:** Created from a single table without grouping or aggregate functions.
- **Complex View:** May contain joins, aggregate functions or grouping.

### 3. Updatable View
An updatable view allows INSERT, UPDATE or DELETE operations that modify the underlying table, subject to MySQL's updatability rules.

Simple views are often updatable, whereas views containing GROUP BY or aggregate functions are generally not updatable.

### 4. Common Table Expression (CTE)
A CTE is a temporary named result set defined using the WITH clause.

### 5. Recursive CTE
A recursive CTE repeatedly processes hierarchical data, such as employee-manager relationships.

It consists of:
- Anchor query — Selects the starting records.
- Recursive query — Finds related records in subsequent levels.
- Termination condition — Stops when no further rows are produced.

## Procedure
1. Create an Employee table with a Manager_ID column.
2. Insert employee and manager records.
3. Create a simple view.
4. Update a record through the view.
5. Create a grouped view.
6. Test whether the grouped view is updatable.
7. Implement a recursive CTE to display the employee hierarchy.

## Expected Output
The simple view displays employee information and allows valid updates.

The grouped view displays department-wise salary summaries but does not permit direct updates to its aggregate results.

The recursive CTE displays the reporting hierarchy with corresponding levels.

## Result
SQL views were created, their updatability was tested, and employee reporting chains were retrieved using a recursive CTE.

## Conclusion
Views simplify data access, while recursive CTEs are useful for querying hierarchical relationships in relational databases.
