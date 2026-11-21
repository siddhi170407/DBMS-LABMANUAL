
CREATE DATABASE IF NOT EXISTS sales_exp7;
USE sales_exp7;

-- UNF example (conceptual):
-- Order 1 has products "Laptop, Mouse"
-- stored together in one field.
-- Such repeating values violate 1NF.

-- 1NF: Atomic values in each row
CREATE TABLE Sales_1NF (
    Order_ID INT,
    Product_ID INT,
    Order_Date DATE,
    Customer_ID INT,
    Customer_Name VARCHAR(50),
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2),
    Quantity INT,
    PRIMARY KEY (Order_ID, Product_ID)
);

INSERT INTO Sales_1NF VALUES
(1, 101, '2026-11-21', 1,
 'Aarav', 'Laptop', 55000, 1),
(1, 102, '2026-11-21', 1,
 'Aarav', 'Mouse', 500, 2),
(2, 101, '2026-11-22', 2,
 'Priya', 'Laptop', 55000, 1);

SELECT * FROM Sales_1NF;

-- 2NF: Remove partial dependencies
-- Customer_Name remains in Orders_2NF,
-- so a transitive dependency still exists.

CREATE TABLE Orders_2NF (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE,
    Customer_ID INT,
    Customer_Name VARCHAR(50)
);

CREATE TABLE Product_2NF (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Order_Item_2NF (
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID)
        REFERENCES Orders_2NF(Order_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES Product_2NF(Product_ID)
);

INSERT INTO Orders_2NF VALUES
(1, '2026-11-21', 1, 'Aarav'),
(2, '2026-11-22', 2, 'Priya');

INSERT INTO Product_2NF VALUES
(101, 'Laptop', 55000),
(102, 'Mouse', 500);

INSERT INTO Order_Item_2NF VALUES
(1, 101, 1),
(1, 102, 2),
(2, 101, 1);

-- 3NF AND BCNF:
-- Remove transitive dependency by
-- separating Customer from Orders.

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE,
    Customer_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Order_Item (
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);

INSERT INTO Customer VALUES
(1, 'Aarav'),
(2, 'Priya');

INSERT INTO Orders VALUES
(1, '2026-11-21', 1),
(2, '2026-11-22', 2);

INSERT INTO Product VALUES
(101, 'Laptop', 55000),
(102, 'Mouse', 500);

INSERT INTO Order_Item VALUES
(1, 101, 1),
(1, 102, 2),
(2, 101, 1);

-- Reconstruct sales data using JOIN
SELECT
    o.Order_ID,
    o.Order_Date,
    c.Customer_Name,
    p.Product_Name,
    p.Price,
    oi.Quantity,
    p.Price * oi.Quantity AS Total
FROM Orders o
JOIN Customer c
    ON o.Customer_ID = c.Customer_ID
JOIN Order_Item oi
    ON o.Order_ID = oi.Order_ID
JOIN Product p
    ON oi.Product_ID = p.Product_ID
ORDER BY o.Order_ID, p.Product_ID;

-- Display normalized tables
SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM Product;
SELECT * FROM Order_Item;
