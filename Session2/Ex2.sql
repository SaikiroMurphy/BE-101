-- Tạo database UniversityDB
CREATE DATABASE IF NOT EXISTS UniversityDB;

-- Trong database, tạo schema university
CREATE SCHEMA IF NOT EXISTS university;

SET search_path TO university;

-- Tạo bảng Students
CREATE TABLE IF NOT EXISTS Students (
    StudentID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Tạo bảng Courses
CREATE TABLE IF NOT EXISTS Courses (
    CourseID SERIAL PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);

-- Tạo bảng Enrollments
CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,
    StudentID INT REFERENCES Students(StudentID),
    CourseID INT REFERENCES Courses(CourseID),
    EnrollmentDate DATE NOT NULL
);

-- Xem danh sách DATABASE
SELECT datname FROM pg_database;

-- Xem danh sách SCHEMA
SELECT schema_name FROM information_schema.schemata;

-- Xem cấu trúc bảng Students
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'students';

-- Xem cấu trúc bảng Courses
SELECT column_name, data_type, character_maximum_length 
FROM information_schema.columns
WHERE table_name = 'courses';

-- Xem cấu trúc bảng Enrollments
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'enrollments';