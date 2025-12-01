-- Tạo một database có tên LibraryDB
CREATE DATABASE LibraryDB;

-- Trong database LibraryDB, tạo schema có tên library
CREATE SCHEMA library;

-- Trong schema library, tạo bảng Books
set search_path to library;

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year INT,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    join_date DATE
);
