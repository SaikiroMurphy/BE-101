-- Tạo bảng nhân viên và chèn dữ liệu mẫu:
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    job_level INT,
    salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary)
VALUES ('Nguyễn Văn A', 1, 8000000),
    ('Trần Thị B', 1, 8200000),
    ('Lê Văn C', 2, 12000000),
    ('Phạm Thị D', 2, 13000000),
    ('Hoàng Văn E', 3, 18000000),
    ('Võ Thị F', 3, 19500000),
    ('Đỗ Văn G', 1, 7500000),
    ('Huỳnh Thị H', 2, 12500000),
    ('Mai Văn I', 3, 21000000),
    ('Phan Thị K', 1, 9000000);

-- Tạo thủ tục lưu trữ để điều chỉnh lương dựa trên cấp bậc công việc:
CREATE OR REPLACE PROCEDURE adjust_salary(IN p_emp_id INT, OUT p_new_salary NUMERIC) LANGUAGE plpgsql AS $$
DECLARE
    v_job_level INT;
BEGIN
    SELECT job_level INTO v_job_level FROM employees WHERE emp_id = p_emp_id;
    IF v_job_level = 1 THEN
        UPDATE employees SET salary = salary * 1.05 WHERE emp_id = p_emp_id RETURNING salary INTO p_new_salary;
    ELSIF v_job_level = 2 THEN
        UPDATE employees SET salary = salary * 1.10 WHERE emp_id = p_emp_id RETURNING salary INTO p_new_salary;
    ELSIF v_job_level = 3 THEN
        UPDATE employees SET salary = salary * 1.15 WHERE emp_id = p_emp_id RETURNING salary INTO p_new_salary;
    ELSE
        RAISE EXCEPTION 'Invalid job level for employee ID %', p_emp_id;
    END IF;
END;
$$;

-- Ví dụ gọi thủ tục để điều chỉnh lương cho nhân viên có emp_id = 10:
CALL adjust_salary(10, null);
