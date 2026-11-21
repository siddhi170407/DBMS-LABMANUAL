# Experiment 6: Stored Procedures and Triggers

## Aim
To create a stored procedure named transfer_employee and implement triggers for salary validation and audit logging.

## Objectives
- Understand stored procedures.
- Create and execute a stored procedure.
- Transfer employees between departments.
- Implement triggers for salary validation.
- Maintain audit logs for salary changes.

## Theory

### 1. Stored Procedure
A stored procedure is a collection of SQL statements stored in the database and executed using the CALL statement.

Stored procedures support code reuse, business logic and centralized database operations.

### 2. Trigger
A trigger is a database object that automatically executes when an INSERT, UPDATE or DELETE event occurs on a table.

### 3. Types of Triggers
- BEFORE INSERT
- AFTER INSERT
- BEFORE UPDATE
- AFTER UPDATE
- BEFORE DELETE
- AFTER DELETE

### 4. Salary Validation
A BEFORE INSERT or BEFORE UPDATE trigger can reject invalid salary values before they are stored.

### 5. Audit Logging
Audit logging maintains records of changes made to database tables.

An audit table may store the employee ID, old salary, new salary and timestamp of modification.

## Procedure
1. Create Department and Employee tables.
2. Create a Salary_Audit table.
3. Insert sample records.
4. Create a stored procedure named transfer_employee.
5. Execute the procedure to change an employee's department.
6. Create triggers to validate salary values.
7. Create an audit trigger for salary updates.
8. Test valid and invalid salary operations.
9. Display the audit records.

## Expected Output
The stored procedure transfers an employee to another department.

Salary validation triggers reject negative salary values.

The audit trigger records old and new salary values whenever an employee's salary changes.

## Result
The transfer_employee stored procedure and salary validation and audit logging triggers were implemented successfully.

## Conclusion
Stored procedures simplify repeated database operations, while triggers enforce business rules and automatically maintain audit records.
