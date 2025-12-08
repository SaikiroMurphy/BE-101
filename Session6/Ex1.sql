-- Tạo bảng product_name
CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

-- Thêm 5 sản phẩm vào bảng bằng lệnh INSERT
INSERT INTO Product (name, category, price, stock) VALUES
('Laptop', 'Electronics', 1200.00, 10),
('Smartphone', 'Electronics', 800.00, 20),
('Desk Chair', 'Furniture', 150.00, 15),
('Coffee Maker', 'Appliances', 100.00, 25),
('Book', 'Stationery', 20.00, 50);

-- Hiển thị danh sách toàn bộ sản phẩm
SELECT * FROM Product;

-- Hiển thị 3 sản phẩm có giá cao nhất
SELECT * FROM Product
ORDER BY price DESC
LIMIT 3;

-- Hiển thị các sản phẩm thuộc danh mục “Điện tử” có giá nhỏ hơn 10,000,000
SELECT * FROM Product
WHERE category = 'Electronics' AND price < 10000000;

-- Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
SELECT * FROM Product
ORDER BY stock ASC;