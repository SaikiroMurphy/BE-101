CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE OR REPLACE FUNCTION fn_update_product_stock() RETURNS TRIGGER LANGUAGE plpgsql AS $$ BEGIN -- Khi tạo đơn hàng mới
    IF TG_OP = 'INSERT' THEN
UPDATE products
SET stock = stock - NEW.quantity
WHERE id = NEW.product_id;
RETURN NEW;
-- Khi cập nhật đơn hàng
ELSIF TG_OP = 'UPDATE' THEN
UPDATE products
SET stock = stock + OLD.quantity - NEW.quantity
WHERE id = NEW.product_id;
RETURN NEW;
-- Khi xóa đơn hàng
ELSIF TG_OP = 'DELETE' THEN
UPDATE products
SET stock = stock + OLD.quantity
WHERE id = OLD.product_id;
RETURN OLD;
END IF;
RETURN NULL;
END;
$$;

CREATE TRIGGER trg_update_stock
AFTER
INSERT
    OR
UPDATE
    OR
DELETE ON orders FOR EACH ROW EXECUTE FUNCTION fn_update_product_stock();

INSERT INTO products (name, stock)
VALUES ('Laptop Dell', 10);

INSERT INTO orders (product_id, quantity)
VALUES (1, 3);

UPDATE orders
SET quantity = 5
WHERE id = 1;

DELETE FROM orders
WHERE id = 1;