-- Tạo cơ sở dữ liệu và bảng. Chèn dữ liệu mẫu vào các bảng này.
CREATE DATABASE product_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_price DECIMAL(10, 2)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO customers (customer_id, customer_name, city)
VALUES (1, 'Nguyễn Văn A', 'Hà Nội'),
    (2, 'Trần Thị B', 'Đà Nẵng'),
    (3, 'Lê Văn C', 'Hồ Chí Minh'),
    (4, 'Phạm Thị D', 'Hà Nội');

INSERT INTO orders (order_id, customer_id, order_date, total_price)
VALUES (101, 1, '2024-12-20', 3000),
    (102, 2, '2025-01-05', 1500),
    (103, 1, '2025-02-10', 2500),
    (104, 3, '2025-02-15', 4000),
    (105, 4, '2025-03-01', 800);

INSERT INTO order_items (item_id, order_id, product_id, quantity, price)
VALUES (1, 101, 1, 2, 1500),
    (2, 102, 2, 1, 1500),
    (3, 103, 3, 5, 500),
    (4, 104, 2, 4, 1000);

-- Hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng
SELECT c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_price) > 2000
ORDER BY total_revenue DESC;

-- Hiển thị những khách hàng có doanh thu lớn hơn doanh thu trung bình của tất cả khách hàng
SELECT c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_price) > (
    SELECT SUM(total_price)
    FROM orders
) / (
    SELECT COUNT(DISTINCT customer_id)
    FROM orders
);

-- lọc ra thành phố có tổng doanh thu cao nhất
SELECT c.city,
    SUM(o.total_price) AS total_revenue
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 1;

-- hiển thị chi tiết: Tên khách hàng, tên thành phố, tổng sản phẩm đã mua, tổng chi tiêu
SELECT c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(o.total_price) AS total_spent
FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name, c.city;