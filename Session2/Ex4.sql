-- Tạo database có tên ElearningDB
CREATE DATABASE IF NOT EXISTS ElearningDB;

-- Tạo schema có tên elearning trong database ElearningDB
CREATE SCHEMA IF NOT EXISTS elearning;

SET search_path TO elearning;

-- Tạo bảng Students trong schema elearning
CREATE TABLE IF NOT EXISTS Students (
    StudentID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Tạo bảng Instructors trong schema elearning
CREATE TABLE IF NOT EXISTS Instructors (
    InstructorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Tạo bảng Courses trong schema elearning
CREATE TABLE IF NOT EXISTS Courses (
    CourseID SERIAL PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    InstructorID INT REFERENCES Instructors(InstructorID)
);

-- Tạo bảng Enrollments trong schema elearning
CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,
    StudentID INT REFERENCES Students(StudentID),
    CourseID INT REFERENCES Courses(CourseID),
    EnrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tạo bảng Assignments trong schema elearning
CREATE TABLE IF NOT EXISTS Assignments (
    AssignmentID SERIAL PRIMARY KEY,
    CourseID INT REFERENCES Courses(CourseID),
    Title VARCHAR(100) NOT NULL,
    DueDate DATE NOT NULL
);

-- Tạo bảng Submissions trong schema elearning
CREATE TABLE IF NOT EXISTS Submissions (
    SubmissionID SERIAL PRIMARY KEY,
    AssignmentID INT REFERENCES Assignments(AssignmentID),
    StudentID INT REFERENCES Students(StudentID),
    SubmissionDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Grade FLOAT CHECK (Grade >= 0 AND Grade <= 100)
);
