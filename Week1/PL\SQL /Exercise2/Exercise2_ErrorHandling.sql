-- SCENARIO-1 PL/SQL block:

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_FromAccount IN NUMBER,
    p_ToAccount IN NUMBER,
    p_Amount IN NUMBER
)
AS
    v_Balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_Balance
    FROM Accounts
    WHERE AccountID = p_FromAccount;

    IF v_Balance < p_Amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient Funds');
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_Amount
    WHERE AccountID = p_FromAccount;

    UPDATE Accounts
    SET Balance = Balance + p_Amount
    WHERE AccountID = p_ToAccount;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Verification:

SELECT * FROM Accounts;

-- SCENARIO-2 PL/SQL block:

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_EmployeeID IN NUMBER,
    p_Percentage IN NUMBER
)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_Percentage / 100)
    WHERE EmployeeID = p_EmployeeID;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee ID not found');
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- verification cmd:
SELECT * FROM Employees;


-- SCENARIO-3 PL/SQL:

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_CustomerID IN NUMBER,
    p_Name IN VARCHAR2,
    p_DOB IN DATE,
    p_Balance IN NUMBER
)
AS
BEGIN
    INSERT INTO Customers
    VALUES (
        p_CustomerID,
        p_Name,
        p_DOB,
        p_Balance,
        SYSDATE,
        NULL
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Customer added successfully.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID already exists.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- verification cmd:
SELECT * FROM Customers;