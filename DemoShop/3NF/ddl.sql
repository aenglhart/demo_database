/*
 * This script is used to set up the basic database structure.
 * It includes the table structure in 3NF and can be used to get started with the basics.
 */

CREATE TABLE CUSTOMERS(
         CUSTOMER_ID            INTEGER
        ,CUSTOMERNAME           VARCHAR(50)
        ,CONTACTNAME            VARCHAR(50)
        ,CONTACTFIRSTNAME       VARCHAR(50)
        ,PHONE                  VARCHAR(50)
        ,ADDRESSLINE1           VARCHAR(100)
        ,ADDRESSLINE2           VARCHAR(100)
        ,CITY                   VARCHAR(50)
        ,STATE                  VARCHAR(50)
        ,ZIPCODE                VARCHAR(10)
        ,COUNTRY                VARCHAR(50)
        ,SALESEMPLOYEE_ID	VARCHAR(50)
        ,CREDITLIMIT            DECIMAL(10,2)
 ); 
 

CREATE TABLE EMPLOYEES (
         EMPLOYEE_ID    INTEGER
        ,LASTNAME       VARCHAR(50)
        ,FIRSTNAME      VARCHAR(50)
        ,EXTENSION      VARCHAR(10)
        ,EMAIL          VARCHAR(100)
        ,OFFICECODE     VARCHAR(10)
        ,REPORTSTO      NUMERIC(11)
        ,JOBTITLE       VARCHAR(50)
);


CREATE TABLE OFFICES(
         OFFICECODE     VARCHAR(10)
        ,CITY           VARCHAR(50)
        ,PHONE          VARCHAR(50)
        ,ADDRESSLINE1   VARCHAR(50)
        ,ADDRESSLINE2   VARCHAR(50)
        ,STATE          VARCHAR(50)
        ,COUNTRY        VARCHAR(50)
        ,ZIPCODE        VARCHAR(10)
        ,TERRITORY      VARCHAR(10)
);


CREATE TABLE ORDERDETAILS(
         ORDERNUMBER            INTEGER
        ,PRODUCT_CODE           VARCHAR(15)
        ,ORDERED_QUANTITY       NUMERIC(11)
        ,SINGLEPRICE            DECIMAL(10,2)
        ,ORDERLINE_NUMBER       NUMERIC(6)
);   

CREATE TABLE ORDERS(
         ORDERNUMBER            INTEGER
        ,ORDERDATE              DATE
        ,REQUIRED_DATE          DATE    
        ,SHIPPE_DATE            DATE
        ,STATUS                 VARCHAR(20)
        ,COMMENTS               VARCHAR(500)
        ,CUSTOMER_ID	        NUMERIC(11)
);


CREATE TABLE PAYMENTS (
         CUSTOMER_ID	        INTEGER
        ,INVOICE_NUMBER         VARCHAR(20)
        ,PAYMENT_DATE           DATE
        ,AMOUNT                 DECIMAL(10,2)
);

CREATE TABLE PRDODUCTLINES(
         PRODUCT_LINE           VARCHAR(50)
        ,PRODUCT_DESCRIPTION    VARCHAR(4000)
);


CREATE TABLE PRODUCTS(
         PRODUCT_CODE           VARCHAR(15)
        ,PRODUCT_NAME           VARCHAR(100)
        ,PRODUCT_LINE           VARCHAR(50)
        ,PRODUCT_SCALE          VARCHAR(10)
        ,VENDOR                 VARCHAR(100)
        ,PRODUCT_DESCRIPTION    VARCHAR(4000)
        ,QUANTITY_IN_STOCK      INTEGER
        ,BUY_PRICE              DECIMAL(10,2)
        ,MSRP                   DECIMAL(10,2)
);