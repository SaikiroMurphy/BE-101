-- Tạo bảng customers
CREATE TABLE customers (
    c_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Chèn dữ liệu mẫu vào bảng customers
INSERT INTO customers (name)
VALUES ('Nguyễn Văn A'),
    ('Trần Thị B'),
    ('Lê Văn C'),
    ('Phạm Thị D'),
    ('Hoàng Văn E'),
    ('Vũ Thị F'),
    ('Đặng Văn G'),
    ('Bùi Thị H'),
    ('Phan Văn I'),
    ('Đỗ Thị J');

-- Tạo liên kết giữa bảng orders và bảng customers
ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES customers(c_id);

-- Hiển thị tên khách hàng và tổng tiền đã mua, sắp xếp theo tổng tiền giảm dần
SELECT c.name AS customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.c_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Tìm khách hàng có tổng chi tiêu cao nhất
SELECT c.name AS customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.c_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

-- Liệt kê khách hàng chưa từng mua hàng
SELECT c.name AS customer_name
FROM customers c
LEFT JOIN orders o ON c.c_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Hiển thị khách hàng có tổng chi tiêu > trung bình của toàn bộ khách hàng
SELECT c.name AS customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.c_id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(o2.total_amount) AS total_spent
        FROM customers c2
        JOIN orders o2 ON c2.c_id = o2.customer_id
        GROUP BY c2.name
    ) AS subquery
);