
-- EXPERIMENT 10
-- SQL Query Optimization
-- MySQL 8.0+

CREATE DATABASE IF NOT EXISTS optimization_exp10;
USE optimization_exp10;

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Dept_ID INT,
    Salary DECIMAL(10,2),
    Joining_Date DATE
);

INSERT INTO Department VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employee VALUES
(101, 'Aarav', 1, 60000, '2023-01-15'),
(102, 'Priya', 1, 75000, '2024-03-10'),
(103, 'Rohan', 2, 45000, '2022-06-20'),
(104, 'Sneha', 3, 85000, '2023-09-12'),
(105, 'Karan', 4, 50000, '2024-02-05'),
(106, 'Ananya', 1, 90000, '2025-01-18'),
(107, 'Neha', 2, 40000, '2023-07-11'),
(108, 'Rahul', 3, 70000, '2024-08-22');

-- QUERY 1:
-- Search employees by department

-- Before optimization
EXPLAIN
SELECT *
FROM Employee
WHERE Dept_ID = 1;

-- Create index
CREATE INDEX idx_emp_dept
ON Employee(Dept_ID);

-- After optimization
EXPLAIN
SELECT Emp_ID, Emp_Name, Dept_ID
FROM Employee
WHERE Dept_ID = 1;

-- QUERY 2:
-- Search employees earning above 70000

-- Before optimization
EXPLAIN
SELECT *
FROM Employee
WHERE Salary > 70000;

-- Create index
CREATE INDEX idx_emp_salary
ON Employee(Salary);

-- After optimization
EXPLAIN
SELECT Emp_ID, Emp_Name, Salary
FROM Employee
WHERE Salary > 70000;

-- QUERY 3:
-- Filter employees who joined in 2024

-- Before optimization
EXPLAIN
SELECT *
FROM Employee
WHERE YEAR(Joining_Date) = 2024;

-- Create date index
CREATE INDEX idx_joining_date
ON Employee(Joining_Date);

-- Rewrite using date range
EXPLAIN
SELECT *
FROM Employee
WHERE Joining_Date >= '2024-01-01'
  AND Joining_Date < '2025-01-01';

-- QUERY 4:
-- Employee-Department JOIN

-- Before optimization
-- For a fair baseline, run this EXPLAIN
-- before creating idx_emp_dept above.

EXPLAIN
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
JOIN Department d
ON e.Dept_ID = d.Dept_ID;

-- The idx_emp_dept index already exists.
-- Re-run the JOIN EXPLAIN to compare.

EXPLAIN
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
JOIN Department d
ON e.Dept_ID = d.Dept_ID;

-- QUERY 5:
-- Sort employees by salary

-- Baseline should be recorded before
-- creating idx_emp_salary above.

EXPLAIN
SELECT Emp_ID, Emp_Name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Index idx_emp_salary already exists.
-- Examine the plan after indexing.

EXPLAIN
SELECT Emp_ID, Emp_Name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Display available indexes
SHOW INDEX FROM Employee;

-- Final optimized queries

SELECT Emp_ID, Emp_Name, Dept_ID
FROM Employee
WHERE Dept_ID = 1;

SELECT Emp_ID, Emp_Name, Salary
FROM Employee
WHERE Salary > 70000;

SELECT Emp_ID, Emp_Name, Joining_Date
FROM Employee
WHERE Joining_Date >= '2024-01-01'
  AND Joining_Date < '2025-01-01';

SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
JOIN Department d
ON e.Dept_ID = d.Dept_ID;

SELECT Emp_ID, Emp_Name, Salary
FROM Employee
ORDER BY Salary DESC;
