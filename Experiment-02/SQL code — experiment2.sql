
-- EXPERIMENT 2
-- Relational Schema and Referential Integrity
-- MySQL 8.0+

CREATE DATABASE IF NOT EXISTS ecommerce_exp2;
USE ecommerce_exp2;

-- 1. CUSTOMER TABLE
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- 2. SELLER TABLE
CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    GSTIN VARCHAR(15) UNIQUE
);

-- 3. PRODUCT TABLE
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    Seller_ID INT NOT NULL,

    CHECK (Price > 0),
    CHECK (Stock >= 0),

    FOREIGN KEY (Seller_ID)
        REFERENCES Seller(Seller_ID)
);

-- 4. ORDERS TABLE
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Customer_ID INT NOT NULL,
    Total_Amount DECIMAL(10,2) DEFAULT 0,

    CHECK (Total_Amount >= 0),

    FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);

-- 5. ORDER ITEM TABLE
CREATE TABLE Order_Item (
    Order_Item_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,

    CHECK (Quantity > 0),
    CHECK (Unit_Price >= 0),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);

-- 6. PAYMENT TABLE
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Payment_Mode VARCHAR(30),
    Payment_Status VARCHAR(30)
        DEFAULT 'Pending',

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);

-- 7. DELIVERY TABLE
CREATE TABLE Delivery (
    Delivery_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Delivery_Address VARCHAR(255),
    Delivery_Status VARCHAR(30)
        DEFAULT 'Processing',

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);

-- INSERT VALID RECORDS

INSERT INTO Customer VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com',
 '9876543210', 'Delhi'),
(2, 'Priya Singh', 'priya@gmail.com',
 '9876501234', 'Lucknow');

INSERT INTO Seller VALUES
(101, 'Tech India', 'GSTIN123456789A'),
(102, 'Fashion Hub', 'GSTIN987654321B');

INSERT INTO Product
(Product_ID, Product_Name, Price, Stock, Seller_ID)
VALUES
(201, 'Laptop', 55000, 10, 101),
(202, 'Kurti', 1200, 25, 102);

INSERT INTO Orders VALUES
(301, '2026-11-21', 1, 55000),
(302, '2026-11-21', 2, 1200);

INSERT INTO Order_Item VALUES
(401, 301, 201, 1, 55000),
(402, 302, 202, 1, 1200);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Mode)
VALUES
(501, 301, 'UPI'),
(502, 302, 'Card');

INSERT INTO Delivery
(Delivery_ID, Order_ID, Delivery_Address)
VALUES
(601, 301, 'Delhi'),
(602, 302, 'Lucknow');

-- DISPLAY RECORDS

SELECT * FROM Customer;
SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Order_Item;
SELECT * FROM Payment;
SELECT * FROM Delivery;

-- REFERENTIAL INTEGRITY VIOLATIONS
-- Run each statement separately.
-- They are intentionally invalid and
-- should generate MySQL errors.

-- VIOLATION 1:
-- Customer_ID 999 does not exist.

-- INSERT INTO Orders VALUES
-- (303, '2026-11-21', 999, 2000);

-- VIOLATION 2:
-- Seller_ID 999 does not exist.

-- INSERT INTO Product
-- (Product_ID, Product_Name, Price, Stock, Seller_ID)
-- VALUES
-- (203, 'Headphones', 1500, 5, 999);

-- VIOLATION 3:
-- Customer 1 has an existing order.
-- Deletion should be rejected.

-- DELETE FROM Customer
-- WHERE Customer_ID = 1;

-- VERIFY DATA REMAINS UNCHANGED

SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM Product;

SHOW TABLES;
