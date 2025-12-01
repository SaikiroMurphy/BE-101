ALTER TABLE books
ADD COLUMN gernre VARCHAR(50);

ALTER TABLE books
RENAME COLUMN available TO is_available;

ALTER TABLE members
DROP COLUMN contact_email;

DROP TABLE order_details;
