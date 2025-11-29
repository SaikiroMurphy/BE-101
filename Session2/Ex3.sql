-- Tạo database có tên SalesDB
CREATE DATABASE IF NOT EXISTS SalesDB;

-- Trong database SalesDB, tạo schema có tên sales
CREATE SCHEMA IF NOT EXISTS sales;

-- Trong schema sales, tạo bảng Customers
SET search_path TO sales;

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone CHAR(10)
);

-- Trong schema sales, tạo bảng Products
CREATE TABLE IF NOT EXISTS Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price FLOAT NOT NULL,
    Stock INT NOT NULL
);

-- Trong schema sales, tạo bảng Orders
CREATE TABLE IF NOT EXISTS Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trong schema sales, tạo bảng OrderItems
CREATE TABLE IF NOT EXISTS OrderItems (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT NOT NULL CHECK (Quantity > 0)
);
