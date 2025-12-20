CREATE TABLE flights (
    flight_id VARCHAR(10) PRIMARY KEY,
    origin VARCHAR(50),
    destination VARCHAR(50),
    available_seats INT
);
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    flight_id VARCHAR(10),
    customer_name VARCHAR(100),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);
INSERT INTO flights (flight_id, origin, destination, available_seats)
VALUES ('VN123', 'Hà Nội', 'TP HCM', 100);

BEGIN
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_id = 'VN123';
INSERT INTO bookings (flight_id, customer_name)
VALUES ('VN123', 'Nguyen Van A');
COMMIT;

DO $$ 
BEGIN  
BEGIN 
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_id = 'VN123';

IF NOT FOUND THEN RAISE EXCEPTION 'Flight VN123 does not exist';
END IF;

INSERT INTO bookings (flight_id, customer_name)
VALUES ('VN999', 'Nguyen Van A');
COMMIT;
EXCEPTION
WHEN OTHERS THEN 
ROLLBACK;
RAISE NOTICE 'Transaction failed. Rollback executed.';
END;
END $$;

SELECT *
FROM flights
WHERE flight_id = 'VN123';
SELECT *
FROM bookings;