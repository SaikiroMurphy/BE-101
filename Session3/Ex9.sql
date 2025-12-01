-- Tạo database và schema
CREATE DATABASE SchoolDB;

CREATE SCHEMA school;

-- Tạo bảng trong schema school
SET search_path TO school;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    major VARCHAR(50),
    dob DATE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);

CREATE TYPE grade_enum AS ENUM ('A', 'B', 'C', 'D', 'F');

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    grade grade_enum
);
