-- Tạo bảng order_detail và chèn dữ liệu mẫu
CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES (1, 'Laptop Dell XPS 13', 1, 25000000),
    (1, 'Chuột Logitech M90', 2, 150000),
    (2, 'Bàn phím cơ Razer', 1, 2200000),
    (2, 'Tai nghe Sony WH-1000XM4', 1, 6500000),
    (3, 'iPhone 14 Pro Max', 1, 32000000),
    (3, 'Ốp lưng iPhone 14', 1, 200000),
    (4, 'Macbook Air M2', 1, 28000000),
    (4, 'Magic Mouse 2', 1, 2300000),
    (5, 'Màn hình Samsung 27 inch', 2, 4500000),
    (5, 'Cáp HDMI Ugreen', 1, 180000),
    (6, 'Chuột không dây Rapoo', 1, 220000),
    (6, 'USB SanDisk 64GB', 2, 250000),
    (7, 'Router WiFi TP-Link AX55', 1, 1850000),
    (7, 'Ổ cứng SSD Samsung 1TB', 1, 2900000),
    (8, 'Bàn phím cơ AKKO 3068', 1, 1600000),
    (8, 'Mouse Pad SteelSeries', 1, 400000),
    (9, 'Máy in Canon LBP2900', 1, 3500000),
    (9, 'Giấy in Double A', 5, 65000),
    (10, 'Camera An ninh Xiaomi', 2, 900000),
    (10, 'Thẻ nhớ 128GB Kingston', 1, 350000);

-- Tạo thủ tục lưu trữ để tính tổng giá trị đơn hàng dựa trên order_id
CREATE OR REPLACE PROCEDURE calculate_order_total(order_id_input INT) LANGUAGE plpgsql AS $$
DECLARE total NUMERIC;
BEGIN
    SELECT SUM(quantity * unit_price) INTO total
    FROM order_detail
    WHERE order_id = order_id_input;
    RAISE NOTICE 'Calculated total for order %: %', order_id_input, total;
END;
$$;

-- Gọi thủ tục để tính tổng giá trị đơn hàng cho order_id = 7
CALL calculate_order_total(7);