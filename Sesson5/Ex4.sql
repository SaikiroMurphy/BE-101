-- Tạo cơ sở dữ liệu quản lý đơn hàng với các bảng cho khách hàng, đơn hàng và chi tiết đơn hàng. Chèn dữ liệu mẫu vào các bảng này.
CREATE DATABASE order_db;
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10, 2)
);
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10, 2)
);
INSERT INTO customers (customer_name, city)
VALUES ('Nguyễn Văn A', 'Hà Nội'),
    ('Trần Thị B', 'Đà Nẵng'),
    ('Lê Văn C', 'Hồ Chí Minh'),
    ('Phạm Thị D', 'Hà Nội'),
    ('Võ Quốc E', 'Cần Thơ');
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, '2025-01-05', 1500000),
    (2, '2025-01-06', 3200000),
    (3, '2025-01-07', 450000),
    (1, '2025-01-08', 780000),
    (4, '2025-01-09', 2200000),
    (5, '2025-01-10', 540000),
    (3, '2025-01-11', 990000);
INSERT INTO order_items (order_id, product_name, quantity, price)
VALUES (1, 'Chuột Logitech', 2, 250000),
    (1, 'Bàn phím cơ', 1, 1000000),
    (2, 'Laptop Dell', 1, 3200000),
    (3, 'Tai nghe Bluetooth', 1, 450000),
    (4, 'Sạc dự phòng', 2, 390000),
    (5, 'Ipad Gen 9', 1, 2200000),
    (6, 'Ốp điện thoại', 3, 120000),
    (7, 'Router WiFi', 1, 600000),
    (7, 'Cáp HDMI', 2, 195000);
-- Hiển thị danh sách tất cả các đơn hàng
SELECT c.customer_name,
    o.order_date,
    o.total_amount
FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id;

-- Tính các thông tin tổng hợp
SELECT SUM(total_amount),
    AVG(total_amount),
    MAX(total_amount),
    MIN(total_amount),
    COUNT(order_id)
FROM orders;

-- Tính tổng doanh thu theo từng thành phố
SELECT c.city,
    SUM(o.total_amount) AS total_revenue
FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city;

-- hiển thị những thành phố có tổng doanh thu lớn hơn 1.000.000
SELECT c.city,
    SUM(o.total_amount) AS total_revenue
FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 1000000;

-- Liệt kê tất cả các sản phẩm đã bán
SELECT oi.product_name,  c.customer_name, o.order_date, oi.quantity, oi.price FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN customers c ON o.customer_id = c.customer_id;

-- Tìm tên khách hàng có tổng doanh thu cao nhất.
SELECT ct.customer_name,
    ct.total_revenue AS highest_revenue
FROM (
        SELECT c.customer_name,
            SUM(o.total_amount) AS total_revenue
        FROM orders o
            JOIN customers c ON o.customer_id = c.customer_id
        GROUP BY c.customer_name
    ) ct
GROUP BY ct.customer_name, ct.total_revenue
HAVING ct.total_revenue >= (
    SELECT MAX(total_revenue)
    FROM (
            SELECT c.customer_name,
            SUM(o.total_amount) AS total_revenue
            FROM orders o
                JOIN customers c ON o.customer_id = c.customer_id
            GROUP BY c.customer_name
        )
);

-- hiển thị danh sách tất cả thành phố có khách hàng hoặc có đơn hàng
SELECT DISTINCT city
FROM customers
UNION
SELECT DISTINCT c.city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;