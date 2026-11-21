
CREATE DATABASE IF NOT EXISTS company_exp3;
USE company_exp3;

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID)
        REFERENCES Department(Dept_ID)
);

CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID)
        REFERENCES Department(Dept_ID)
);

CREATE TABLE Employee_Project (
    Emp_ID INT,
    Project_ID INT,
    PRIMARY KEY (Emp_ID, Project_ID),
    FOREIGN KEY (Emp_ID)
        REFERENCES Employee(Emp_ID),
    FOREIGN KEY (Project_ID)
        REFERENCES Project(Project_ID)
);

INSERT INTO Department VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee VALUES
(101, 'Aarav', 60000, 1),
(102, 'Priya', 55000, 1),
(103, 'Rohan', 45000, 2),
(104, 'Sneha', 50000, 2),
(105, 'Ananya', 70000, 3),
(106, 'Karan', 65000, 3);

INSERT INTO Project VALUES
(201, 'Website Development', 1),
(202, 'Recruitment System', 2),
(203, 'Financial Analytics', 3);

INSERT INTO Employee_Project VALUES
(101, 201),
(102, 201),
(103, 202),
(104, 202),
(105, 203),
(106, 203);

-- 1. Total employees
SELECT COUNT(*) AS Total_Employees
FROM Employee;

-- 2. Average salary
SELECT AVG(Salary) AS Average_Salary
FROM Employee;

-- 3. Maximum and minimum salary
SELECT MAX(Salary) AS Highest_Salary,
       MIN(Salary) AS Lowest_Salary
FROM Employee;

-- 4. Department-wise employee count
SELECT d.Dept_Name,
       COUNT(e.Emp_ID) AS Employee_Count
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name;

-- 5. Department-wise total salary
SELECT d.Dept_Name,
       SUM(e.Salary) AS Total_Salary
FROM Department d
JOIN Employee e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name;

-- 6. Departments with average salary > 50000
SELECT d.Dept_Name,
       AVG(e.Salary) AS Average_Salary
FROM Department d
JOIN Employee e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
HAVING AVG(e.Salary) > 50000;

-- 7. Departments having at least 2 employees
SELECT Dept_ID,
       COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Dept_ID
HAVING COUNT(*) >= 2;

-- 8. Project-wise employee count
SELECT p.Project_Name,
       COUNT(ep.Emp_ID) AS Assigned_Employees
FROM Project p
LEFT JOIN Employee_Project ep
ON p.Project_ID = ep.Project_ID
GROUP BY p.Project_ID, p.Project_Name;
