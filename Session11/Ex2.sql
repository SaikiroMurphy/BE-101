CREATE TABLE accounts (
    account_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    balance NUMERIC(12, 2)
);

INSERT INTO accounts (account_id, customer_name, balance)
VALUES ('A', 'Nguyen Van A', 1000.00),
    ('B', 'Tran Van B', 500.00);
    
DO $$ BEGIN BEGIN
UPDATE accounts
SET balance = balance - 100.00
WHERE account_id = 'A';
IF NOT FOUND THEN RAISE EXCEPTION 'Sender account does not exist';
END IF;
IF (
    SELECT balance
    FROM accounts
    WHERE account_id = 'A'
) < 0 THEN RAISE EXCEPTION 'Insufficient balance';
END IF;
UPDATE accounts
SET balance = balance + 100.00
WHERE account_id = 'C';
IF NOT FOUND THEN RAISE EXCEPTION 'Receiver account does not exist';
END IF;
COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK;
RAISE NOTICE 'Transaction failed. Rollback executed.';
END;
END $$;
SELECT *
FROM accounts;