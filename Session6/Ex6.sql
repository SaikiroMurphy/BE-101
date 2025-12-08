-- Tạo bảng Orders
CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2)
);

-- Thêm 10 bản ghi mẫu vào bảng Orders
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2023-01-01', 100.00),
(2, '2023-01-02', 150.50),
(3, '2023-01-03', 200.75),
(4, '2023-01-04', 250.00),
(5, '2023-01-05', 300.25),
(6, '2023-01-06', 350.00),
(7, '2023-01-07', 400.50),
(8, '2023-01-08', 450.00),
(9, '2023-01-09', 500.75),
(10, '2023-01-10', 550.00);

-- Hiển thị tổng doanh thu, số đơn hàng, giá trị trung bình mỗi đơn
SELECT 
    SUM(total_amount) AS total_revenue,
    COUNT(id) AS total_orders,
    AVG(total_amount) AS average_order_value
FROM Orders;

-- Nhóm dữ liệu theo năm đặt hàng, hiển thị doanh thu từng năm
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS yearly_revenue
FROM Orders
GROUP BY order_year
ORDER BY order_year;

-- Chỉ hiển thị các năm có doanh thu trên 50 triệu
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS yearly_revenue
FROM Orders
GROUP BY order_year
HAVING SUM(total_amount) > 50000000
ORDER BY order_year;

-- Hiển thị 5 đơn hàng có giá trị cao nhất
SELECT 
    id,
    customer_id,
    order_date,
    total_amount
FROM Orders
ORDER BY total_amount DESC
LIMIT 5;