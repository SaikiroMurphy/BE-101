-- Tao bang Customer
CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    points INT
);

-- Thêm 7 khách hàng (1 người không có email)
INSERT INTO Customer (name, email, phone, points) VALUES
('Nguyen Van A', 'nguyenvana@example.com', '0123456789', 100),
('Tran Thi B', 'tranthib@example.com', '0987654321', 150),
('Le Van C', NULL, '0112233445', 200),
('Pham Thi D', 'phamthid@example.com', '0223344556', 120),
('Hoang Van E', 'hoangvane@example.com', '0334455667', 180),
('Vu Thi F', 'vuthif@example.com', '0445566778', 130),
('Do Van G', 'dovang@example.com', '0556677889', 110);

-- Truy vấn danh sách tên khách hàng duy nhất
SELECT DISTINCT name FROM Customer;

-- Tìm các khách hàng chưa có email
SELECT * FROM Customer WHERE email IS NULL;

-- Hiển thị 3 khách hàng có điểm thưởng cao nhất, bỏ qua khách hàng cao điểm nhất
SELECT * FROM Customer
ORDER BY points DESC
LIMIT 3
OFFSET 1;

-- Sắp xếp danh sách khách hàng theo tên giảm dần
SELECT * FROM Customer
ORDER BY name DESC;