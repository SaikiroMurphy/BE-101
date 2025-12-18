-- Create TABLE products
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create FUNCTION to update last_modified timestamp
CREATE OR REPLACE FUNCTION update_last_modified ()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_modified = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create TRIGGER to call the function before updating a product
CREATE TRIGGER trg_update_last_modified
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_last_modified();

-- Sample data
INSERT INTO products (product_name, price) VALUES
('Laptop', 999.99),
('Smartphone', 499.49),
('Tablet', 299.99),
('Headphones', 89.99),
('Smartwatch', 199.99);

-- Update the price of the Smartphone by 10%
UPDATE products
SET price = price * 1.10
WHERE product_id = 2; -- Update price of Smartphone by 10%