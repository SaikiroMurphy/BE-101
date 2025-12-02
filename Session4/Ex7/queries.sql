-- Tìm kiếm tất cả khách hàng có tên chứa chuỗi "Văn" (không phân biệt chữ hoa chữ thường).
SELECT * FROM Customers WHERE fullname ILIKE '%Văn%';

-- Lọc sản phẩm có giá từ 500.000 đến 1.000.000.
SELECT * FROM Products WHERE price BETWEEN 500000 AND 1000000;

-- Tìm khách hàng không có số điện thoại.
SELECT * FROM Customers WHERE phone IS NULL;

-- Hiển thị 5 sản phẩm có giá cao nhất.
SELECT * FROM Products ORDER BY price DESC LIMIT 5;

-- Hiển thị sản phẩm từ vị trí thứ 6 đến vị trí thứ 10.
SELECT * FROM Products LIMIT 5 OFFSET 5;

-- Đếm số lượng khách hàng theo từng thành phố.
SELECT city, COUNT(CustomerID) AS customer_count
FROM Customers GROUP BY city;

-- Tìm đơn hàng trong khoảng ngày từ '2025-01-01' đến '2025-12-31'.
SELECT * FROM Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31';
