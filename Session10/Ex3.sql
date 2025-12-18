CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary NUMERIC(12, 2) NOT NULL
);

CREATE TYPE operation_type AS ENUM ('INSERT', 'UPDATE', 'DELETE');

CREATE TABLE employees_log (
    log_id SERIAL PRIMARY KEY,
    employees_id INT,
    operation operation_type NOT NULL,
    old_data JSONB,
    new_data JSONB,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION fn_employees_audit() RETURNS TRIGGER LANGUAGE plpgsql AS $$ BEGIN IF TG_OP = 'INSERT' THEN
INSERT INTO employees_log (
        employees_id,
        operation,
        old_data,
        new_data
    )
VALUES (
        NEW.id,
        'INSERT',
        NULL,
        to_jsonb(NEW)
    );
RETURN NEW;
ELSIF TG_OP = 'UPDATE' THEN
INSERT INTO employees_log (
        employees_id,
        operation,
        old_data,
        new_data
    )
VALUES (
        NEW.id,
        'UPDATE',
        to_jsonb(OLD),
        to_jsonb(NEW)
    );
RETURN NEW;
ELSIF TG_OP = 'DELETE' THEN
INSERT INTO employees_log (
        employees_id,
        operation,
        old_data,
        new_data
    )
VALUES (
        OLD.id,
        'DELETE',
        to_jsonb(OLD),
        NULL
    );
RETURN OLD;
END IF;
RETURN NULL;
END;
$$;

CREATE TRIGGER trg_employees_audit
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW EXECUTE FUNCTION fn_employees_audit();

INSERT INTO employees (name, position, salary)
VALUES ('Nguyễn Văn A', 'Developer', 20000000);

UPDATE employees
SET salary = 22000000
WHERE name = 'Nguyễn Văn A';

DELETE FROM employees
WHERE name = 'Nguyễn Văn A';

SELECT * FROM employees_log;