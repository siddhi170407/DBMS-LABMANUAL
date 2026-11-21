
CREATE DATABASE IF NOT EXISTS company_exp6;
USE company_exp6;

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID)
        REFERENCES Department(Dept_ID)
);

CREATE TABLE Salary_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Emp_ID INT,
    Old_Salary DECIMAL(10,2),
    New_Salary DECIMAL(10,2),
    Changed_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Department VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee VALUES
(101, 'Aarav', 60000, 1),
(102, 'Priya', 50000, 2),
(103, 'Rohan', 70000, 3);

-- Create stored procedure
DELIMITER $$

CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Employee
        WHERE Emp_ID = p_emp_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee not found';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Department
        WHERE Dept_ID = p_new_dept_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department not found';
    END IF;

    UPDATE Employee
    SET Dept_ID = p_new_dept_id
    WHERE Emp_ID = p_emp_id;
END$$

DELIMITER ;

-- Execute stored procedure
CALL transfer_employee(101, 2);

SELECT * FROM Employee;

-- Trigger 1: Validate salary before insertion
DELIMITER $$

CREATE TRIGGER validate_salary_insert
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END$$

DELIMITER ;

-- Trigger 2: Validate salary before update
DELIMITER $$

CREATE TRIGGER validate_salary_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END$$

DELIMITER ;

-- Trigger 3: Audit salary changes
DELIMITER $$

CREATE TRIGGER salary_audit_trigger
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NOT (OLD.Salary <=> NEW.Salary) THEN
        INSERT INTO Salary_Audit
        (Emp_ID, Old_Salary, New_Salary)
        VALUES
        (OLD.Emp_ID, OLD.Salary, NEW.Salary);
    END IF;
END$$

DELIMITER ;

-- Valid salary update
UPDATE Employee
SET Salary = 65000
WHERE Emp_ID = 101;

-- View audit records
SELECT * FROM Salary_Audit;

-- Invalid salary update
-- Uncomment to test expected error
-- UPDATE Employee
-- SET Salary = -5000
-- WHERE Emp_ID = 102;

-- Invalid salary insertion
-- Uncomment to test expected error
-- INSERT INTO Employee VALUES
-- (104, 'Neha', -1000, 1);

-- Final records
SELECT * FROM Employee;
SELECT * FROM Salary_Audit;
