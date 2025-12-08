-- Tạo bảng OrderInfo
CREATE TABLE OrderInfo (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total NUMERIC(10, 2),
    status VARCHAR(20)
);

-- Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
INSERT INTO OrderInfo (customer_id, order_date, total, status) VALUES
(1, '2024-01-15', 150.75, 'Completed'),
(2, '2024-02-20', 250.00, 'Pending'),
(3, '2024-03-05', 99.99, 'Shipped'),
(4, '2024-04-10', 300.50, 'Completed'),
(5, '2024-05-25', 450.00, 'Cancelled');

-- Truy vấn các đơn hàng có tổng tiền lớn hơn 500.00
SELECT * FROM OrderInfo
WHERE total > 500.00;

-- Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
SELECT * FROM OrderInfo
WHERE order_date >= '2024-10-01' AND order_date < '2024-11-01';

-- Liệt kê các đơn hàng có trạng thái khác “ Completed ”
SELECT * FROM OrderInfo
WHERE status <> 'Completed';

-- Lấy 2 đơn hàng mới nhất
SELECT * FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;