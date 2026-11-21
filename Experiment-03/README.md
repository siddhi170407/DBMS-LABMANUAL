# Experiment 3: Employee–Department–Project Schema Using Aggregate Functions

## Aim
To create an Employee–Department–Project relational database schema and execute SQL queries using aggregate functions, GROUP BY and HAVING clauses.

## Objectives
- Create related Employee, Department and Project tables.
- Implement primary and foreign keys.
- Perform calculations using aggregate functions.
- Group records based on departments and projects.
- Filter grouped records using HAVING.

## Theory

**Aggregate Functions:** Aggregate functions perform calculations on multiple rows and return a single result.

Common aggregate functions include:

1. COUNT() — Counts the number of records.
2. SUM() — Calculates the total of numeric values.
3. AVG() — Calculates the average value.
4. MAX() — Returns the highest value.
5. MIN() — Returns the lowest value.

**GROUP BY:** Groups rows having similar values into summary groups.

**HAVING:** Filters groups based on aggregate conditions.

**Difference between WHERE and HAVING:**
- WHERE filters individual rows before grouping.
- HAVING filters groups after aggregation.

## Database Schema

| Table | Description |
|---|---|
| Department | Stores department information |
| Employee | Stores employee details and salaries |
| Project | Stores project information |
| Employee_Project | Maps employees to projects |

## Procedure
1. Create a database named company_exp3.
2. Create the Department, Employee, Project and Employee_Project tables.
3. Define primary and foreign keys.
4. Insert sample employee and project records.
5. Execute queries using COUNT, SUM, AVG, MAX and MIN.
6. Group employee records using GROUP BY.
7. Apply HAVING conditions to filter grouped results.

## Expected Output
The queries display employee counts, department-wise salary totals, average salaries, maximum and minimum salaries, and departments satisfying aggregate conditions.

## Result
The Employee–Department–Project schema was created, and SQL aggregate functions, GROUP BY and HAVING were implemented successfully.

## Conclusion
Aggregate functions and grouping clauses help summarize and analyze relational data efficiently.
