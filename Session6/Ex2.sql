-- Tạo bảng SQL với tên "Employee"
CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10, 2),
    hire_date DATE
);

-- Thêm 6 nhân viên mới
INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
('Nguyen Van A', 'IT', 5000.00, '2020-01-15'),
('Tran Thi B', 'HR', 4500.00, '2019-03-22'),
('Le Van C', 'Finance', 6000.00, '2018-07-30'),
('Pham Thi D', 'IT', 5200.00, '2021-05-10'),
('Hoang Van E', 'Marketing', 4800.00, '2020-11-05'),
('Vu Thi F', 'Sales', 5500.00, '2019-09-18');

-- Cập nhật mức lương tăng 10 % cho nhân viên thuộc phòng IT
UPDATE Employee
SET salary = salary * 1.10
WHERE department = 'IT';

-- Xóa nhân viên có mức lương dưới 6,000.00
DELETE FROM Employee
WHERE salary < 6000.00;

-- Liệt kê các nhân viên có tên chứa chữ “ An ” (không phân biệt hoa thường)
SELECT *
FROM Employee
WHERE full_name ILIKE '% an %';

-- Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
SELECT *
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';