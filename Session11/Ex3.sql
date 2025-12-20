CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    stock INT,
    price NUMERIC(10, 2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    total_amount NUMERIC(10, 2),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    subtotal NUMERIC(10, 2)
);

DO $$
DECLARE v_order_id INT;
v_stock INT;
v_price NUMERIC(10, 2);
v_total NUMERIC(10, 2) := 0;
BEGIN BEGIN
SELECT stock,
    price INTO v_stock,
    v_price
FROM products
WHERE product_id = 1 FOR
UPDATE;
IF NOT FOUND THEN RAISE EXCEPTION 'Product 1 not found';
END IF;
IF v_stock < 2 THEN RAISE EXCEPTION 'Not enough stock for product 1';
END IF;
UPDATE products
SET stock = stock - 2
WHERE product_id = 1;
v_total := v_total + (v_price * 2);
SELECT stock,
    price INTO v_stock,
    v_price
FROM products
WHERE product_id = 2 FOR
UPDATE;
IF NOT FOUND THEN RAISE EXCEPTION 'Product 2 not found';
END IF;
IF v_stock < 1 THEN RAISE EXCEPTION 'Not enough stock for product 2';
END IF;
UPDATE products
SET stock = stock - 1
WHERE product_id = 2;
v_total := v_total + (v_price * 1);
INSERT INTO orders (customer_name, total_amount)
VALUES ('Nguyen Van A', 0)
RETURNING order_id INTO v_order_id;
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (
        v_order_id,
        1,
        2,
        (
            SELECT price
            FROM products
            WHERE product_id = 1
        ) * 2
    ),
    (
        v_order_id,
        2,
        1,
        (
            SELECT price
            FROM products
            WHERE product_id = 2
        ) * 1
    );
UPDATE orders
SET total_amount = v_total
WHERE order_id = v_order_id;
COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK;
RAISE NOTICE 'Order failed → Rollback executed';
END;
END $$;

DO $$
DECLARE v_order_id INT;
v_price_1 NUMERIC;
v_price_2 NUMERIC;
v_stock INT;
v_total NUMERIC := 0;
BEGIN BEGIN
SELECT stock,
    price INTO v_stock,
    v_price_1
FROM products
WHERE product_id = 1 FOR
UPDATE;
IF NOT FOUND THEN RAISE EXCEPTION 'Product 1 does not exist';
END IF;
IF v_stock < 2 THEN RAISE EXCEPTION 'Not enough stock for product 1';
END IF;
UPDATE products
SET stock = stock - 2
WHERE product_id = 1;
v_total := v_total + v_price_1 * 2;
SELECT stock,
    price INTO v_stock,
    v_price_2
FROM products
WHERE product_id = 2 FOR
UPDATE;
IF NOT FOUND THEN RAISE EXCEPTION 'Product 2 does not exist';
END IF;
IF v_stock < 1 THEN RAISE EXCEPTION 'Not enough stock for product 2';
END IF;
UPDATE products
SET stock = stock - 1
WHERE product_id = 2;
v_total := v_total + v_price_2 * 1;
INSERT INTO orders (customer_name, order_date, total_amount)
VALUES ('Nguyen Van A', CURRENT_TIMESTAMP, 0)
RETURNING order_id INTO v_order_id;
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (v_order_id, 1, 2, v_price_1),
    (v_order_id, 2, 1, v_price_2);
UPDATE orders
SET total_amount = v_total
WHERE order_id = v_order_id;
COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK;
RAISE NOTICE 'Order failed → Rollback executed';
END;
END $$;