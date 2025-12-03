-- Tạo cơ sở dữ liệu và bảng, chèn dữ liệu mẫu vào bảng.
CREATE DATABASE product_db;

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price INT,
    stock INT,
    manufacturer VARCHAR(50)
);

INSERT INTO products (id, name, category, price, stock, manufacturer)
VALUES (1, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
       (2, 'Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
       (3, 'Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
       (4, 'Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
       (5, 'iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
       (6, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
       (7, 'Tai nghe AirPods 3', 'Phụ kiện', 4500000, NULL, 'Apple');

-- Thêm sản phẩm “Chuột không dây Logitech M170”, loại Phụ kiện, giá 300000, tồn kho 20, hãng Logitech
INSERT INTO products (id, name, category, price, stock, manufacturer)
VALUES (8, 'Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- Tăng giá tất cả sản phẩm của Apple thêm 10%
UPDATE products
SET price = price * 1.1
WHERE manufacturer = 'Apple';

-- Xóa sản phẩm có stock = 0
DELETE FROM products
WHERE stock = 0;

-- Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
SELECT * FROM products
WHERE price BETWEEN 1000000 AND 30000000;

-- Hiển thị sản phẩm có stock IS NULL
SELECT * FROM products
WHERE stock IS NULL;

-- Liệt kê danh sách hãng sản xuất duy nhất
SELECT DISTINCT manufacturer FROM products;

-- Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
SELECT * FROM products
ORDER BY price DESC, name ASC;

-- Tìm sản phẩm có tên chứa từ “laptop” (không phân biệt hoa thường)
SELECT * FROM products
WHERE name ILIKE '%laptop%';

-- Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp
SELECT * FROM products
ORDER BY id
LIMIT 2;