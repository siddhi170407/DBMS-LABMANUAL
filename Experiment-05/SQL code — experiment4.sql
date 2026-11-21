
CREATE DATABASE IF NOT EXISTS company_exp5;
USE company_exp5;

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50) NOT NULL,
    Dept_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Manager_ID INT NULL,
    FOREIGN KEY (Manager_ID)
        REFERENCES Employee(Emp_ID)
);

INSERT INTO Employee VALUES
(101, 'Aarav', 'Management', 100000, NULL),
(102, 'Priya', 'IT', 75000, 101),
(103, 'Rohan', 'HR', 65000, 101),
(104, 'Sneha', 'IT', 50000, 102),
(105, 'Karan', 'IT', 45000, 102),
(106, 'Ananya', 'HR', 40000, 103);

-- 1. Create a simple view
CREATE VIEW Employee_View AS
SELECT Emp_ID, Emp_Name, Dept_Name, Salary
FROM Employee;

-- Display the view
SELECT * FROM Employee_View;

-- 2. Update through the simple view
UPDATE Employee_View
SET Salary = 55000
WHERE Emp_ID = 104;

-- Verify update in original table
SELECT * FROM Employee
WHERE Emp_ID = 104;

-- 3. Create a complex view
CREATE VIEW Department_Salary_View AS
SELECT Dept_Name,
       COUNT(*) AS Total_Employees,
       AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Dept_Name;

SELECT * FROM Department_Salary_View;

-- 4. Test non-updatable view
-- Expected to fail: aggregate view
-- UPDATE Department_Salary_View
-- SET Average_Salary = 60000
-- WHERE Dept_Name = 'IT';

-- 5. Recursive CTE for reporting hierarchy
WITH RECURSIVE Employee_Hierarchy AS (
    -- Anchor: top-level manager
    SELECT Emp_ID, Emp_Name,
           Manager_ID, 1 AS Level
    FROM Employee
    WHERE Manager_ID IS NULL

    UNION ALL

    -- Recursive: employees under managers
    SELECT e.Emp_ID, e.Emp_Name,
           e.Manager_ID, h.Level + 1
    FROM Employee e
    JOIN Employee_Hierarchy h
    ON e.Manager_ID = h.Emp_ID
)
SELECT *
FROM Employee_Hierarchy
ORDER BY Level, Emp_ID;

-- 6. Show reporting chain from CEO
WITH RECURSIVE Reporting_Chain AS (
    SELECT Emp_ID, Emp_Name,
           Manager_ID,
           CAST(Emp_Name AS CHAR(500)) AS Path
    FROM Employee
    WHERE Manager_ID IS NULL

    UNION ALL

    SELECT e.Emp_ID, e.Emp_Name,
           e.Manager_ID,
           CONCAT(r.Path, ' -> ', e.Emp_Name)
    FROM Employee e
    JOIN Reporting_Chain r
    ON e.Manager_ID = r.Emp_ID
)
SELECT Emp_Name, Path
FROM Reporting_Chain;
