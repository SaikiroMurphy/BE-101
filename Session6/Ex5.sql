-- Tạo bảng Course
CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    instructor VARCHAR(50),
    price NUMERIC(10, 2),
    duration INT
);

-- Thêm ít nhất 6 khóa học vào bảng
INSERT INTO Course (title, instructor, price, duration) VALUES
('Python Programming', 'John Doe', 199.99, 40),
('Web Development', 'Jane Smith', 299.99, 50),
('Data Science', 'Alice Johnson', 399.99, 60),
('Machine Learning', 'Bob Brown', 499.99, 70),
('Database Management', 'Carol White', 149.99, 30),
('Cloud Computing', 'David Green', 349.99, 55);

-- Cập nhật giá tăng 15 % cho các khóa học có thời lượng trên 30 giờ
UPDATE Course
SET price = price * 1.15
WHERE duration > 30;

-- Xóa khóa học có tên chứa từ khóa “ Demo ”
DELETE FROM Course
WHERE title ILIKE '%Demo%';

-- Hiển thị các khóa học có tên chứa từ “ SQL ” (không phân biệt hoa thường)
SELECT * FROM Course
WHERE title ILIKE '%SQL%';

-- Lấy 3 khóa học có giá nằm giữa 500.00 và 2,000.00, sắp xếp theo giá giảm dần
SELECT * FROM Course
WHERE price BETWEEN 500.00 AND 2000.00
ORDER BY price DESC
LIMIT 3;