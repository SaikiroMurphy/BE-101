-- Tạo bảng sản phẩm và chèn dữ liệu mẫu
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    discount_percent INT
);

INSERT INTO products (name, price, discount_percent)
VALUES ('Laptop Dell XPS 13', 25000000, 10),
    ('iPhone 14 Pro', 32000000, 5),
    ('Chuột Logitech M90', 150000, 0),
    ('Bàn phím cơ Keychron K6', 2200000, 15),
    ('Màn hình LG UltraWide 29"', 6500000, 20);

-- Tạo thủ tục lưu trữ để tính giá cuối cùng sau khi áp dụng chiết khấu
CREATE OR REPLACE PROCEDURE calculate_discount(p_id INT, OUT p_final_price NUMERIC) LANGUAGE plpgsql AS $$
    DECLARE
        v_price NUMERIC;
        v_discount_percent INT;
    BEGIN
        SELECT price, discount_percent INTO v_price, v_discount_percent FROM products WHERE id = p_id;
        
        IF v_discount_percent IS NOT NULL THEN
            IF v_discount_percent > 50 THEN
                p_final_price := v_price - (v_price * 50 / 100);
            ELSE
                p_final_price := v_price - (v_price * v_discount_percent / 100);
            END IF;
        ELSE
            p_final_price := v_price;
        END IF;

        UPDATE products SET price = p_final_price WHERE id = p_id;
    END;
$$;

-- Thử nghiệm thủ tục lưu trữ
CALL calculate_discount(2, NULL);