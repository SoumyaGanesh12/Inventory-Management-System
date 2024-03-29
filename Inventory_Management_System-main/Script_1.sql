-- Run as db administrator --

SET SERVEROUTPUT ON;

DECLARE
    v_sid NUMBER;
    v_serial NUMBER;
    v_sql VARCHAR2(100);
BEGIN
    -- Obtaining SID and SERIAL# values --
    SELECT SID, SERIAL# INTO v_sid, v_serial
    FROM V$SESSION
    WHERE USERNAME = 'IMS_ADMIN' AND ROWNUM = 1;
    
    -- Kill the session for IMS_ADMIN if session is already present --
    v_sql := 'ALTER SYSTEM KILL SESSION ' || '''' || v_sid  || ',' || v_serial || '''';
  
    EXECUTE IMMEDIATE v_sql;
    DBMS_OUTPUT.PUT_LINE('SESSION ALTERED IF EXISTED');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No active session found for IMS_ADMIN.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    FOR I IN (
    WITH DESIRED_USER AS (SELECT 'IMS_ADMIN' USERNAME FROM DUAL)
    SELECT DU.USERNAME FROM DESIRED_USER DU JOIN ALL_USERS AU ON DU.USERNAME = AU.USERNAME
    )
LOOP
    DBMS_OUTPUT.PUT_LINE('USER IMS_ADMIN EXIST -> DROPPING USER AND CREATING IT BACK.');
    EXECUTE IMMEDIATE 'DROP USER ' || I.USERNAME || ' CASCADE';
END LOOP;
EXCEPTION 
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG ' || SQLERRM);
END;
/
 
CREATE USER IMS_ADMIN IDENTIFIED BY "TeamRelationalNinjas2023#";
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE USER, DROP USER, CREATE ROLE, DROP ANY ROLE TO IMS_ADMIN WITH ADMIN OPTION;
GRANT SELECT ON V$SESSION TO IMS_ADMIN;
GRANT ALTER USER TO IMS_ADMIN;
GRANT ALTER SYSTEM TO IMS_ADMIN;
GRANT execute ON DBMS_LOCK TO IMS_ADMIN;
ALTER USER IMS_ADMIN QUOTA UNLIMITED ON DATA;
