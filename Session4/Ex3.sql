-- Tạo cơ sở dữ liệu và bảng sinh viên, sau đó chèn một số dữ liệu mẫu vào bảng.
CREATE DATABASE students_db;

CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3, 1)
);

INSERT INTO students (id, full_name, gender, birth_year, major, gpa)
VALUES 
    (1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
    (2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
    (3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
    (4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
    (5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
    (6, 'Lưu Đức Tài', 2004, 2004, 'Cơ khí', NULL),
    (7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8
INSERT INTO students (id, full_name, gender, birth_year, major, gpa)
VALUES (8, 'Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- Sinh viên “Lê Quốc Cường” cập nhật gpa = 3.4
UPDATE students
SET gpa = 3.4
WHERE full_name = 'Lê Quốc Cường';

-- Xóa tất cả sinh viên có gpa IS NULL
DELETE FROM students
WHERE gpa IS NULL;

-- Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
SELECT * FROM students
WHERE major = 'CNTT' AND gpa >= 3.0
LIMIT 3;

-- Liệt kê danh sách ngành học duy nhất
SELECT DISTINCT major FROM students;

-- Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
SELECT * FROM students
WHERE major = 'CNTT'
ORDER BY gpa DESC, full_name ASC;

-- Tìm sinh viên có tên bắt đầu bằng “ Nguyễn ”
SELECT * FROM students
WHERE full_name LIKE 'Nguyễn%';

-- Tìm sinh viên có năm sinh từ 2001 đến 2003
SELECT * FROM students
WHERE birth_year BETWEEN 2001 AND 2003;