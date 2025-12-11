-- Tạo bảng inventory và chèn dữ liệu mẫu
CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT
);

INSERT INTO inventory (product_name, quantity)
VALUES ('Laptop Dell XPS 13', 15),
    ('Chuột Logitech M90', 120),
    ('Bàn phím cơ Razer', 35),
    ('Tai nghe Sony WH-1000XM4', 20),
    ('iPhone 14 Pro Max', 10),
    ('Ốp lưng iPhone 14', 150),
    ('Macbook Air M2', 12),
    ('Magic Mouse 2', 40),
    ('Màn hình Samsung 27 inch', 25),
    ('Cáp HDMI Ugreen', 200),
    ('Chuột không dây Rapoo', 80),
    ('USB SanDisk 64GB', 160),
    ('Router WiFi TP-Link AX55', 30),
    ('Ổ cứng SSD Samsung 1TB', 18),
    ('Bàn phím cơ AKKO 3068', 22),
    ('Mouse Pad SteelSeries', 75),
    ('Máy in Canon LBP2900', 8),
    ('Giấy in Double A', 500),
    ('Camera An ninh Xiaomi', 28),
    ('Thẻ nhớ 128GB Kingston', 140);

-- Tạo thủ tục kiểm tra tồn kho
CREATE OR REPLACE PROCEDURE check_stock(p_id INT, p_qty INT) LANGUAGE plpgsql AS $$
DECLARE
    current_qty INT;
BEGIN
    SELECT quantity INTO current_qty FROM inventory WHERE product_id = p_id;
    IF current_qty IS NULL THEN
        RAISE EXCEPTION 'Product with ID % does not exist.', p_id;
    ELSIF current_qty < p_qty THEN
        RAISE EXCEPTION 'Insufficient stock for product ID %. Available: %, Requested: %', p_id, current_qty, p_qty;
    ELSE
        RAISE NOTICE 'Sufficient stock for product ID %. Available: %, Requested: %', p_id, current_qty, p_qty;
    END IF;
END;
$$;

-- Gọi thủ tục để kiểm tra tồn kho
CALL check_stock(1, 10);  -- Còn đủ hàng
CALL check_stock(2, 150); -- Không đủ hàng
