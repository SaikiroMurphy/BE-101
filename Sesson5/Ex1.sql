-- Tạo DB và bảng với dữ liệu mẫu
CREATE DATABASE ex1_ss5_db;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, category)
VALUES (1, 'Laptop Dell', 'Electronics'),
    (2, 'IPhone 15', 'Electronics'),
    (3, 'Bàn học gỗ', 'Furniture'),
    (4, 'Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES (101, 1, 2, 2200),
    (102, 2, 3, 3300),
    (103, 3, 5, 2500),
    (104, 4, 4, 1600),
    (105, 1, 1, 1100);

-- Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
SELECT p.category, SUM(o.total_price) AS total_sales, SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

-- Chỉ hiển thị những đơn hàng có tổng doanh thu lớn hơn 2000
SELECT o.order_id, p.product_name, p.category, o.quantity, o.total_price
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.total_price > 2000;

-- Sắp xếp kết quả theo tổng doanh thu giảm dần
SELECT p.category, SUM(o.total_price) AS total_sales, SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;