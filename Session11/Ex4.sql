CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    balance NUMERIC(12, 2)
);

CREATE TABLE transactions (
    trans_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    amount NUMERIC(12, 2),
    trans_type VARCHAR(20),
    -- 'WITHDRAW' hoặc 'DEPOSIT'
    created_at TIMESTAMP DEFAULT NOW()
);

DO $$
DECLARE v_balance NUMERIC(12, 2);
BEGIN BEGIN
SELECT balance INTO v_balance
FROM accounts
WHERE account_id = 1 FOR
UPDATE;
IF NOT FOUND THEN RAISE EXCEPTION 'Account not found';
END IF;
IF v_balance < 500.00 THEN RAISE EXCEPTION 'Insufficient balance';
END IF;
UPDATE accounts
SET balance = balance - 500.00
WHERE account_id = 1;
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (999, 500.00, 'WITHDRAW');
COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK;
RAISE NOTICE 'Withdraw failed → Rollback executed';
END;
END $$;

SELECT a.account_id,
    a.balance,
    COUNT(t.trans_id) AS total_transactions
FROM accounts a
    LEFT JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.account_id,
    a.balance;