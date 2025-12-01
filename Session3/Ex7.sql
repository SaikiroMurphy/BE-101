-- Tạo một database có tên LibraryDB
CREATE DATABASE LibraryDB;

-- Trong database LibraryDB, tạo schema có tên sales
CREATE SCHEMA sales;

-- Trong schema sales, tạo bảng Products
set search_path to sales;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    order_date DATE
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL
);
