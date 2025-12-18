-- Bảng customers
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_limit NUMERIC(12, 2) NOT NULL
);
-- Bảng orders
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_amount NUMERIC(12, 2) NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Sample Data:
INSERT INTO customers (name, credit_limit) VALUES
('Alice', 1000.00),
('Bob', 1000.00),
('Charlie', 2000.00),
('Diana', 1500.00),
('Eve', 500.00);

INSERT INTO orders (customer_id, order_amount) VALUES
(1, 200.00),
(1, 300.00),
(2, 600.00),
(3, 1500.00),
(4, 1000.00),
(5, 400.00);

-- Create a trigger to enforce credit limit on orders table:
CREATE OR REPLACE FUNCTION check_credit_limit()
RETURNS TRIGGER AS $$
BEGIN
    DECLARE
        total_orders NUMERIC(12, 2);
        customer_limit NUMERIC(12, 2);
    BEGIN
        -- Tính tổng số tiền đơn hàng hiện tại của khách hàng
        SELECT SUM(order_amount) INTO total_orders
        FROM orders
        WHERE customer_id = NEW.customer_id
        GROUP BY customer_id;

        -- Lấy hạn mức tín dụng của khách hàng
        SELECT credit_limit INTO customer_limit
        FROM customers
        WHERE id = NEW.customer_id;

        -- Kiểm tra nếu tổng số tiền đơn hàng vượt quá hạn mức tín dụng
        IF (total_orders + NEW.order_amount) > customer_limit THEN
            RAISE EXCEPTION 'Order exceeds credit limit for customer ID %', NEW.customer_id;
        END IF;

        RETURN NEW;
    END;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_credit_limit
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

-- This should raise an exception
INSERT INTO orders (customer_id, order_amount) VALUES (2, 500.00);
-- Test the trigger with a valid insert
INSERT INTO orders (customer_id, order_amount) VALUES (1, 400.00);
