
-- EXPERIMENT 9
-- Railway Booking Index Benchmark
-- MySQL 8.0.18+

CREATE DATABASE IF NOT EXISTS railway_exp9;
USE railway_exp9;

CREATE TABLE Railway_Booking (
    Booking_ID INT PRIMARY KEY,
    Passenger_Name VARCHAR(100),
    Train_No INT NOT NULL,
    Journey_Date DATE NOT NULL,
    Source_Station VARCHAR(50),
    Destination_Station VARCHAR(50),
    Fare DECIMAL(10,2),
    Booking_Status VARCHAR(20)
);

-- Generate 20,000 sample bookings
-- using a recursive CTE.

INSERT INTO Railway_Booking (
    Booking_ID,
    Passenger_Name,
    Train_No,
    Journey_Date,
    Source_Station,
    Destination_Station,
    Fare,
    Booking_Status
)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 20000
)
SELECT
    n,
    CONCAT('Passenger_', n),
    12000 + MOD(n, 100),
    DATE_ADD(
        '2026-01-01',
        INTERVAL MOD(n, 365) DAY
    ),
    'Delhi',
    'Lucknow',
    500 + MOD(n, 2000),
    CASE
        WHEN MOD(n, 5) = 0
        THEN 'Waiting'
        ELSE 'Confirmed'
    END
FROM numbers;

-- Increase recursion limit for this statement.
-- Execute the INSERT above with this hint
-- if the default limit is exceeded:
-- Add /*+ SET_VAR(cte_max_recursion_depth=20000) */
-- immediately after SELECT in the outer query.

-- Check number of records
SELECT COUNT(*) AS Total_Bookings
FROM Railway_Booking;

-- BEFORE INDEXING

-- Query 1: Search by train number
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Train_No = 12025;

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Train_No = 12025;

-- Query 2: Search by journey date
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Journey_Date = '2026-06-15';

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Journey_Date = '2026-06-15';

-- CREATE INDEXES

CREATE INDEX idx_train_no
ON Railway_Booking(Train_No);

CREATE INDEX idx_journey_date
ON Railway_Booking(Journey_Date);

-- AFTER INDEXING

EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Train_No = 12025;

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Train_No = 12025;

EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Journey_Date = '2026-06-15';

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Journey_Date = '2026-06-15';

-- Display indexes
SHOW INDEX FROM Railway_Booking;
