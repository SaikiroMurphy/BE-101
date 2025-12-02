-- Tạo một cơ sở dữ liệu mới có tên là StudentDB.
CREATE DATABASE StudentDB;

CREATE SCHEMA StudentSchema;

SET SEARCH_PATH TO StudentSchema;

-- Tạo bảng Students trong cơ sở dữ liệu StudentDB.
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    major VARCHAR(50),
    gpa DECIMAL(3,2)
);

-- Chèn dữ liệu mẫu vào bảng Students.
INSERT INTO students (name, age, major, gpa) VALUES
    ('An', 20, 'CNTT', 3.5),
    ('Bình', 21, 'Toán', 3.2),
    ('Cường', 22, 'CNTT', 3.8),
    ('Dương', 20, 'Vật lý', 3.0),
    ('Em', 21, 'CNTT', 2.9);

-- Thêm dòng dữ liệu mới cho sinh viên tên "Hùng".
INSERT INTO students (name, age, major, gpa) VALUES
    ('Hùng', 23, 'Hóa học', 3.4);

-- Câp nhật điểm GPA của sinh viên tên "Bình" thành 3.6.
UPDATE students SET gpa = 3.6 WHERE name ='Bình';

-- Xóa tất cả các sinh viên có điểm GPA dưới 3.0.
DELETE FROM students WHERE gpa < 3.0;

-- Hiển thị tên và chuyên ngành của tất cả sinh viên, sắp xếp theo điểm GPA từ cao đến thấp.
SELECT name, major FROM students ORDER BY gpa DESC;

-- Hiển thị tên của tất cả sinh viên chuyên ngành CNTT.
SELECT DISTINCT name FROM students WHERE major = 'CNTT';

-- Hiển thị tất cả thông tin của sinh viên có điểm GPA từ 3.0 đến 3.6.
SELECT * FROM students WHERE gpa BETWEEN 3.0 AND 3.6;

-- Hiển thị tất cả thông tin của sinh viên có tên bắt đầu bằng chữ "C".
SELECT * FROM students WHERE name ILIKE 'C%';

-- Hiển thị thông tin của 3 sinh viên có tên theo thứ tự bảng chữ cái.
SELECT * FROM students ORDER BY name ASC LIMIT 3;
