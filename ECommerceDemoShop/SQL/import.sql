SET search_path TO core;

/*
*  Import data from csv files
* 
*  IMPORTANT in some cases it can happen that your local SQL client has no rights to access the data. 
*  	best practice: copy the files to your Download folder and try loading them there.
*
*   Replace <yourPCName> either with your PC name or replace the full path depending on where you 
*   stored the downloaded CSV files from the repository.
*/

COPY CORE.CUSTOMERS  (id, firstname, surname, gender, street, zip, city)
FROM 'C:\Users\<yourPCName>\Downloads\import_core_customers.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.RETAILER  (retailer_id, retailer_name, retailer_type, retailer_level, retailer_address, zip, city)
FROM 'C:\Users\<yourPCName>\Downloads\import_core_retailer.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.ORDERS  (order_id, basket_id, order_date, due_date, shippment_date, product_id, quantity, unit_price)
FROM 'C:\Users\<yourPCName>\Downloads\import_core_orders.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.PRODUCTS (product_id, product_title, category, rating, reviews, price)
FROM 'C:\Users\<yourPCName>\Downloads\import_core_products.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.RETAILER_PRODUCT (product_id, retailer_id)
FROM 'C:\Users\AENGLHAR\Downloads\import_core_retailer_product.csv'
DELIMITER ','
CSV HEADER;