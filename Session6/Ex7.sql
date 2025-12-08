-- Tạo bảng Department và Employee, sau đó chèn dữ liệu mẫu vào cả hai bảng.
CREATE TABLE Department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department_id INT,
    salary NUMERIC(10,2)
);

INSERT INTO Department (name) VALUES
('Sales'),
('HR'),
('IT');

INSERT INTO Employee (full_name, department_id, salary) VALUES
('Nguyễn Văn A', 1, 8000.00),
('Trần Thị B', 1, 7500.50),
('Lê Văn C', 1, 9000.00),

('Phạm Thị D', 2, 7000.00),
('Hoàng Văn E', 2, 6800.00),
('Vũ Thị F', 2, 7200.75),

('Đỗ Văn G', 3, 10000.00),
('Ngô Thị H', 3, 11000.50),
('Bùi Văn I', 3, 10500.25);

-- Liệt kê danh sách nhân viên cùng tên phòng ban của họ.
SELECT e.full_name, d.name AS department_name
FROM Employee e
INNER JOIN Department d ON e.department_id = d.id;

-- Tính lương trung bình của từng phòng ban.
SELECT d.name AS department_name, AVG(e.salary) AS average_salary
FROM Employee e
INNER JOIN Department d ON e.department_id = d.id
GROUP BY d.name;

-- Hiển thị các phòng ban có lương trung bình > 10 triệu.
SELECT d.name AS department_name, AVG(e.salary) AS average_salary
FROM Employee e
INNER JOIN Department d ON e.department_id = d.id
GROUP BY d.name
HAVING AVG(e.salary) > 10000;

-- Liệt kê phòng ban không có nhân viên nào.
SELECT d.name AS department_name
FROM Department d
LEFT JOIN Employee e ON d.id = e.department_id
WHERE e.id IS NULL;