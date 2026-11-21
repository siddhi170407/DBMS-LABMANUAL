
CREATE DATABASE IF NOT EXISTS banking_exp8;
USE banking_exp8;

CREATE TABLE Bank_Account (
    Account_ID INT PRIMARY KEY,
    Holder_Name VARCHAR(50) NOT NULL,
    Balance DECIMAL(12,2) NOT NULL,
    CHECK (Balance >= 0)
) ENGINE = InnoDB;

INSERT INTO Bank_Account VALUES
(101, 'Aarav', 50000),
(102, 'Priya', 30000),
(103, 'Rohan', 20000);

SELECT * FROM Bank_Account;

-- 1. COMMIT
-- Transfer Rs. 5000 from 101 to 102

START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance - 5000
WHERE Account_ID = 101
  AND Balance >= 5000;

UPDATE Bank_Account
SET Balance = Balance + 5000
WHERE Account_ID = 102;

COMMIT;

SELECT * FROM Bank_Account;

-- 2. ROLLBACK
-- Attempt a transfer, then cancel it

START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance - 2000
WHERE Account_ID = 102;

UPDATE Bank_Account
SET Balance = Balance + 2000
WHERE Account_ID = 103;

-- Cancel both updates
ROLLBACK;

SELECT * FROM Bank_Account;

-- 3. SAVEPOINT
START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance - 1000
WHERE Account_ID = 101;

SAVEPOINT sp1;

UPDATE Bank_Account
SET Balance = Balance + 1000
WHERE Account_ID = 103;

-- Undo the credit after sp1
ROLLBACK TO SAVEPOINT sp1;

-- Undo the earlier debit as well,
-- so no money is lost.
ROLLBACK;

SELECT * FROM Bank_Account;

-- 4. Isolation level demonstration
-- Run the following in TWO MySQL sessions.

-- SESSION A:
-- SET TRANSACTION ISOLATION LEVEL
-- READ COMMITTED;
-- START TRANSACTION;
-- SELECT Balance FROM Bank_Account
-- WHERE Account_ID = 101;
-- Wait for Session B to commit.
-- SELECT Balance FROM Bank_Account
-- WHERE Account_ID = 101;
-- COMMIT;

-- SESSION B:
-- START TRANSACTION;
-- UPDATE Bank_Account
-- SET Balance = Balance + 1000
-- WHERE Account_ID = 101;
-- COMMIT;

-- In READ COMMITTED, Session A's
-- second SELECT can see the new balance.

-- 5. REPEATABLE READ demonstration
-- Reset the test or use fresh balances.

-- SESSION A:
-- SET TRANSACTION ISOLATION LEVEL
-- REPEATABLE READ;
-- START TRANSACTION;
-- SELECT Balance FROM Bank_Account
-- WHERE Account_ID = 101;
-- Wait for Session B to commit.
-- SELECT Balance FROM Bank_Account
-- WHERE Account_ID = 101;
-- COMMIT;

-- SESSION B:
-- START TRANSACTION;
-- UPDATE Bank_Account
-- SET Balance = Balance + 1000
-- WHERE Account_ID = 101;
-- COMMIT;

-- In REPEATABLE READ, Session A's
-- ordinary consistent SELECT sees
-- the same snapshot within the transaction.

-- Other supported isolation levels:
-- READ UNCOMMITTED
-- SERIALIZABLE

SELECT * FROM Bank_Account;
