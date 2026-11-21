
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Customer table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- Seller table
CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    GSTIN VARCHAR(15) UNIQUE
);

-- Product table
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    Seller_ID INT,
    FOREIGN KEY (Seller_ID)
        REFERENCES Seller(Seller_ID)
);

-- Orders table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Customer_ID INT NOT NULL,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);

-- Order items table
CREATE TABLE Order_Item (
    Order_Item_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);

-- Payment table
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Payment_Mode VARCHAR(30),
    Payment_Status VARCHAR(30),
    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);

-- Delivery table
CREATE TABLE Delivery (
    Delivery_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Delivery_Address VARCHAR(255),
    Delivery_Status VARCHAR(30),
    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);

-- Display created tables
SHOW TABLES;
