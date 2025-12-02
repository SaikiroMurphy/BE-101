-- Thêm dữ liệu mẫu vào bảng Customers, Products và Orders
INSERT INTO Customers (FullName, Email, Phone, City, JoinDate) VALUES
('Nguyễn Văn A', 'nguyen.van.a@email.com', '0912345678', 'Hà Nội', CURRENT_TIMESTAMP),
('Trần Thị B', 'tran.thi.b@email.com', '0923456789', 'TP. Hồ Chí Minh', CURRENT_TIMESTAMP),
('Phạm Minh C', 'pham.minh.c@email.com', '0934567890', 'Đà Nẵng', CURRENT_TIMESTAMP),
('Hoàng Quốc D', 'hoang.quoc.d@email.com', '0945678901', 'Hà Nội', CURRENT_TIMESTAMP),
('Võ Thị E', 'vo.thi.e@email.com', '0956789012', 'TP. Hồ Chí Minh', CURRENT_TIMESTAMP),
('Dương Văn F', 'duong.van.f@email.com', '0967890123', 'Cần Thơ', CURRENT_TIMESTAMP),
('Lý Thị G', 'ly.thi.g@email.com', '0978901234', 'Hải Phòng', CURRENT_TIMESTAMP),
('Bùi Anh H', 'bui.anh.h@email.com', '0989012345', 'Huế', CURRENT_TIMESTAMP),
('Đặng Minh I', 'dang.minh.i@email.com', '0990123456', 'Nha Trang', CURRENT_TIMESTAMP),
('Tạ Văn J', 'ta.van.j@email.com', '0901234567', 'Quảng Ninh', CURRENT_TIMESTAMP);

INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Laptop Dell Inspiron', 'Electronics', 15000000, 20),
('Smartphone Samsung Galaxy', 'Electronics', 12000000, 35),
('Tai nghe Bluetooth Sony', 'Electronics', 1500000, 50),
('Máy in Canon LBP', 'Electronics', 3500000, 15),
('Bàn phím cơ Logitech', 'Electronics', 1200000, 40),
('Áo thun nam', 'Clothing', 250000, 100),
('Quần jeans nữ', 'Clothing', 450000, 80),
('Giày thể thao Adidas', 'Clothing', 1800000, 60),
('Áo khoác gió', 'Clothing', 600000, 70),
('Mũ lưỡi trai', 'Clothing', 120000, 90),
('Bàn học sinh', 'Furniture', 900000, 25),
('Ghế xoay văn phòng', 'Furniture', 750000, 30),
('Tủ sách gỗ', 'Furniture', 2200000, 10),
('Giường ngủ đơn', 'Furniture', 3500000, 8),
('Kệ để giày dép', 'Furniture', 400000, 20);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, CURRENT_TIMESTAMP, 3000000, 'Completed'),
(2, CURRENT_TIMESTAMP, 1500000, 'Pending'),
(3, CURRENT_TIMESTAMP, 4500000, 'Shipped'),
(4, CURRENT_TIMESTAMP, 2000000, 'Completed'),
(5, CURRENT_TIMESTAMP, 1200000, 'Cancelled'),
(6, CURRENT_TIMESTAMP, 3500000, 'Pending'),
(7, CURRENT_TIMESTAMP, 2800000, 'Shipped'),
(8, CURRENT_TIMESTAMP, 2200000, 'Shipped');

-- Cập nhật giá sản phẩm thuộc category 'Electronics' tăng 10%
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

-- Cập nhật số điện thoại cho khách hàng có email cụ thể
UPDATE Customers
SET Phone = '0987654321'
WHERE Email = 'nguyen.van.a@email.com';

-- Cập nhật trạng thái đơn hàng từ 'PENDING' sang 'CONFIRMED'
UPDATE Orders
SET Status = 'Confirmed'
WHERE Status = 'Pending';

-- Xóa các sản phẩm có số lượng tồn kho = 0
DELETE FROM Products
WHERE StockQuantity = 0;

-- Xóa khách hàng không có đơn hàng nào
DELETE FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);
