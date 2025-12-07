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

-- Tìm sản phẩm có doanh thu cao nhất trong bảng orders
SELECT p.product_name, e.total_revenue
FROM (
    SELECT o.product_id, SUM(o.total_price) AS total_revenue
    FROM orders o
    GROUP BY o.product_id
) e
JOIN products p ON e.product_id = p.product_id
WHERE e.total_revenue = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT SUM(o.total_price) AS total_revenue
        FROM orders o
        GROUP BY o.product_id
    ) AS revenue_subquery
);

-- Hiển thị tổng doanh thu theo từng nhóm category
SELECT p.category, SUM(o.total_price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

-- Tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
SELECT DISTINCT p.category
FROM products p
WHERE p.category IN (
    SELECT p2.category
    FROM orders o
    JOIN products p2 ON o.product_id = p2.product_id
    GROUP BY p2.category
    HAVING SUM(o.total_price) > 3000
)
AND p.product_id IN (
    SELECT e.product_id
    FROM (
        SELECT o.product_id, SUM(o.total_price) AS total_revenue
        FROM orders o
        GROUP BY o.product_id
    ) e
    WHERE e.total_revenue = (
        SELECT MAX(total_revenue)
        FROM (
            SELECT SUM(o.total_price) AS total_revenue
            FROM orders o
            GROUP BY o.product_id
        ) AS revenue_subquery
    )
);
