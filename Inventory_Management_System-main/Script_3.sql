-- Run this script as IMS_ADMIN
SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE CUSTOMER_ROLE';
EXCEPTION
WHEN OTHERS THEN
    IF SQLCODE = -1924 THEN
     DBMS_OUTPUT.PUT_LINE('CREATING ROLE CUSTOMER_ROLE');
    END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SUPPLIER_ROLE';
EXCEPTION
WHEN OTHERS THEN
    IF SQLCODE = -1924 THEN
     DBMS_OUTPUT.PUT_LINE('CREATING ROLE SUPPLIER_ROLE');
    END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE LOGISTICS_ROLE';
EXCEPTION
WHEN OTHERS THEN
    IF SQLCODE = -1924 THEN
     DBMS_OUTPUT.PUT_LINE('CREATING ROLE LOGISCTIC_ROLE');
    END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE MANAGER_ROLE';
EXCEPTION
WHEN OTHERS THEN
    IF SQLCODE = -1924 THEN
     DBMS_OUTPUT.PUT_LINE('CREATING ROLE MANAGER_ROLE');
    END IF;
END;
/

-- Creating and Granting privileges to Customer Role --
CREATE ROLE CUSTOMER_ROLE;
GRANT EXECUTE ON INSERT_ORDER TO CUSTOMER_ROLE;
GRANT EXECUTE ON INSERTPRODUCTORDER TO CUSTOMER_ROLE;
GRANT EXECUTE ON UPDATE_PRODUCT_QUANTITY TO CUSTOMER_ROLE;
GRANT EXECUTE ON ADD_CUSTOMERS TO CUSTOMER_ROLE;
GRANT EXECUTE ON UPDATE_CUSTOMER TO CUSTOMER_ROLE;
GRANT EXECUTE ON GET_CUSTOMER_ORDER_HISTORY_VIEW TO CUSTOMER_ROLE;
GRANT SELECT ON CUSTOMER_ORDER_HISTORY_VIEW TO CUSTOMER_ROLE;
GRANT SELECT ON customer_product_view TO CUSTOMER_ROLE;

-- Creating and Granting privileges to Supplier Role --
CREATE ROLE SUPPLIER_ROLE;
GRANT EXECUTE ON ADD_SUPPLIERS TO SUPPLIER_ROLE;
GRANT EXECUTE ON UPDATE_SUPPLIER TO SUPPLIER_ROLE;
GRANT EXECUTE ON GET_SUPPLIER_ORDER_REQ_USING_PRODNAME TO SUPPLIER_ROLE;
GRANT EXECUTE ON get_supplier_product_performance_view TO SUPPLIER_ROLE;
GRANT SELECT ON supplier_product_performance_view TO SUPPLIER_ROLE;

-- Creating and Granting privileges to Logistics Role --
CREATE ROLE LOGISTICS_ROLE;
GRANT EXECUTE ON TOGGLE_SHIP_STATUS_UP TO LOGISTICS_ROLE;
GRANT EXECUTE ON TOGGLE_SHIP_STATUS_DOWN TO LOGISTICS_ROLE;
GRANT SELECT ON logistic_admin_order_status TO LOGISTICS_ROLE;


-- Creating and Granting privileges to Manager Role --
CREATE ROLE MANAGER_ROLE;
GRANT EXECUTE ON ADD_PRODUCT TO MANAGER_ROLE;
GRANT EXECUTE ON UPDATE_PRODUCT_INFO TO MANAGER_ROLE;
GRANT EXECUTE ON ADD_DISCOUNT TO MANAGER_ROLE;
GRANT EXECUTE ON ADD_CATEGORY TO MANAGER_ROLE;
GRANT EXECUTE ON UPDATE_AVAIL_STATUS TO MANAGER_ROLE;
GRANT EXECUTE ON UPDATE_PROD_DISC TO MANAGER_ROLE;
GRANT EXECUTE ON REFIL_QTY TO MANAGER_ROLE;
GRANT SELECT ON Stock_Report TO MANAGER_ROLE;
GRANT SELECT ON Sales_Report TO MANAGER_ROLE;
GRANT SELECT ON Suppliers_Comparison_View TO MANAGER_ROLE;
GRANT SELECT ON ORDER_VIEW TO MANAGER_ROLE;
GRANT SELECT ON PRODORDER_VIEW TO MANAGER_ROLE;

DECLARE
    v_sid NUMBER;      
    v_serial NUMBER;   
    v_user VARCHAR2(100);
BEGIN
    
    FOR I IN (
    SELECT SID, SERIAL#
    FROM V$SESSION
    WHERE USERNAME IN ('SUPPLIER', 'CUSTOMER','LOGISTIC_ADMIN','IMS_MANAGER')
    )
    LOOP
     DBMS_OUTPUT.PUT_LINE('ALTER SYSTEM KILL SESSION ' || '''' || I.SID  || ',' || I.SERIAL# || '''');
     EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ' || '''' || I.SID  || ',' || I.SERIAL# || '''';
     DBMS_LOCK.SLEEP(2);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CONTACT ADMIN WITH ERROR CODE : ' || SQLCODE);
END;
/
                          
-- Delete the users if already present --
DECLARE
    V_USER VARCHAR(100);
    V_DROP_SQL VARCHAR(500);
BEGIN
    FOR I IN (
    WITH DESIRED_USERS AS (
    SELECT 'CUSTOMER' USERNAME FROM DUAL
    UNION ALL
    SELECT 'SUPPLIER' FROM DUAL
    UNION ALL
    SELECT 'LOGISTIC_ADMIN' FROM DUAL
    UNION ALL
    SELECT 'IMS_MANAGER' FROM DUAL
    )
SELECT DU.USERNAME FROM DESIRED_USERS DU JOIN ALL_USERS AU ON DU.USERNAME = AU.USERNAME
)
LOOP
    EXECUTE IMMEDIATE 'DROP USER ' || I.USERNAME || ' CASCADE';
END LOOP;
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG. CONTACT ADMIN');
END;
/

-- Create and Grant privileges to Customer, Supplier, Logistics_Admin and IMS_Manager users --
CREATE USER CUSTOMER IDENTIFIED BY "TeamRelationalNinjas2023#";
GRANT CONNECT, RESOURCE, CUSTOMER_ROLE TO CUSTOMER;

CREATE USER SUPPLIER IDENTIFIED BY "TeamRelationalNinjas2023#";
GRANT CONNECT, RESOURCE, SUPPLIER_ROLE TO SUPPLIER;

CREATE USER LOGISTIC_ADMIN IDENTIFIED BY "TeamRelationalNinjas2023#";
GRANT CONNECT, RESOURCE, LOGISTICS_ROLE TO LOGISTIC_ADMIN;

CREATE USER IMS_MANAGER IDENTIFIED BY "TeamRelationalNinjas2023#";
GRANT CONNECT, RESOURCE, MANAGER_ROLE TO IMS_MANAGER;

