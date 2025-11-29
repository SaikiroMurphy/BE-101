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
    price FLOAT
);

-- Xem tất cả các database
SELECT datname  FROM pg_database;

-- Xem tất cả các schema trong database hiện tại
SELECT schema_name FROM information_schema.schemata;

-- Xem cấu trúc bảng Books
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'library'
  AND table_name = 'books';