-- SCENARIO-1 PL/SQL block:

BEGIN
    FOR cust IN (
        SELECT CustomerID,
               FLOOR(MONTHS_BETWEEN(SYSDATE,DOB)/12) Age
        FROM Customers
    )
    LOOP
        IF cust.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Interest rates updated successfully.');
END;
/

-- Verification Query:

SELECT * FROM Loans;

-- SCENARIO-2 PL/SQL block:

BEGIN
    FOR cust IN (
        SELECT CustomerID, Balance
        FROM Customers
    )
    LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('VIP customers updated.');
END;
/

-- Verification Query:

SELECT CustomerID, Name, Balance, IsVIP
FROM Customers;

-- SCENARIO-3 PL/SQL block:

SET SERVEROUTPUT ON;

BEGIN
    FOR loan_rec IN (
        SELECT c.Name,
               l.LoanID,
               l.EndDate
        FROM Customers c
        JOIN Loans l
        ON c.CustomerID = l.CustomerID
        WHERE l.EndDate <= SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder -> ' ||
            loan_rec.Name ||
            ' Loan ID: ' ||
            loan_rec.LoanID ||
            ' Due Date: ' ||
            TO_CHAR(loan_rec.EndDate,'DD-MON-YYYY')
        );
    END LOOP;
END;
/