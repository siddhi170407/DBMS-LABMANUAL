
CREATE DATABASE IF NOT EXISTS company_exp4;
USE company_exp4;

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID)
        REFERENCES Department(Dept_ID)
);

INSERT INTO Department VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employee VALUES
(101, 'Aarav', 60000, 1),
(102, 'Priya', 55000, 1),
(103, 'Rohan', 40000, 2),
(104, 'Sneha', 50000, 2),
(105, 'Ananya', 75000, 3);

-- 1. INNER JOIN
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID;

-- 2. LEFT JOIN
SELECT d.Dept_Name, e.Emp_Name
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID;

-- 3. RIGHT JOIN
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
RIGHT JOIN Department d
ON e.Dept_ID = d.Dept_ID;

-- 4. Correlated subquery:
-- Employees earning more than department average
SELECT e.Emp_Name, e.Salary, e.Dept_ID
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.Dept_ID = e.Dept_ID
);

-- 5. EXISTS:
-- Departments having employees
SELECT d.Dept_Name
FROM Department d
WHERE EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.Dept_ID = d.Dept_ID
);

-- 6. NOT EXISTS:
-- Departments without employees
SELECT d.Dept_Name
FROM Department d
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.Dept_ID = d.Dept_ID
);

-- 7. EXPLAIN on JOIN
EXPLAIN
SELECT e.Emp_Name, d.Dept_Name
FROM Employee e
JOIN Department d
ON e.Dept_ID = d.Dept_ID;

-- 8. EXPLAIN on correlated subquery
EXPLAIN
SELECT e.Emp_Name
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.Dept_ID = e.Dept_ID
);

-- 9. EXPLAIN on EXISTS
EXPLAIN
SELECT d.Dept_Name
FROM Department d
WHERE EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.Dept_ID = d.Dept_ID
);
