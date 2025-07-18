/*         Database: ECommerceShop            */

-- DROP DATABASE IF EXISTS "ECommerceShop";

CREATE DATABASE "ECommerceShop"
WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'German_Germany.1252'
    LC_CTYPE = 'German_Germany.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- Create database schema
CREATE SCHEMA CORE;
CREATE SCHEMA LAKE;



/* Create core tables */

create table CORE.CUSTOMERS (
     ID				INTEGER PRIMARY KEY
    ,FIRSTNAME		VARCHAR(50)
    ,SURNAME		VARCHAR(50)
    ,GENDER			VARCHAR(5)
    ,STREET			VARCHAR(100)
    ,ZIP			VARCHAR(10)
    ,CITY			VARCHAR(100)
);


create table CORE.RETAILER (
     RETAILER_ID		INTEGER primary key
    ,RETAILER_NAME		VARCHAR(100)
    ,RESELLER_TYPE		VARCHAR(100)
    ,RESELLER_LEVEL		VARCHAR(10)
    ,RESELLER_ADDRESS	VARCHAR(100)
    ,ZIP				VARCHAR(10)
    ,CITY 				VARCHAR(100)
);


create table CORE.ORDERS (
     ORDER_ID			VARCHAR(50) primary key
    ,BASKET_ID			VARCHAR(50)
    ,ORDER_DATE			DATE
    ,DUE_DATE			DATE
    ,SHIPPMENT_DATE 	DATE
    ,PRODUCT_ID 		INTEGER
    ,QUANTITY			INTEGER
    ,UNIT_PRICE			NUMERIC(8,2)
);


create table CORE.PRODUCTS (
     PRODUCT_ID			INTEGER primary key
    ,PRODUCT_TITLE      VARCHAR(100)
    ,CATEGORY           VARCHAR(100)
    ,RATING             NUMERIC(4,2)
    ,REVIEWS            INTEGER
    ,PRICE              NUMERIC(8,2)
);


create table CORE.RETAILER_PRODUCT (
     PRODUCT_ID        INTEGER
    ,RETAILER_ID      INTEGER
);

create table CORE.CUSTOMERS_BASKET (
     CUSTOMER_ID 	 INTEGER
    ,BASKET_ID 		 VARCHAR(50)
);



/* Create flat tables */

CREATE TABLE LAKE.RETAILER_AD_CAMPAIGN_DL (
     RT_AD_H_SK      VARCHAR(100)
    ,RETAILER_ID    INTEGER
    ,RETAILER_NAME  VARCHAR(100)
    ,CAMPAIGN_ID    INTEGER
    ,CAMPAIGN_NAME  VARCHAR(500)
    ,CAMPAIGN_BUDGET    DECIMAL(18,2)
    ,START_DATE     DATE
    ,END_DATE       DATE
    ,PRODUCT_ID     INTEGER
    ,PRODUCT_TITLE  VARCHAR(100)
    ,CATEGORY       VARCHAR(100)
    ,MAX_CPC_BID    DECIMAL(18,2)
);


create table LAKE.TRACKING_CAMPAIGN_DL (
     TRACKING_AD_H_SK        VARCHAR(100)
    ,SESSION_ID             VARCHAR(100)
    ,VISITOR_ID             VARCHAR(100)
    ,EVENT_TIMESTAMP_CET    TIMESTAMP
    ,"FORMAT"               VARCHAR(100)
    ,PAGE                   VARCHAR(100)
    ,CAMPAIGN_ID            INTEGER
    ,PRODUCT_ID             INTEGER
    ,IMPRESSION_ID          VARCHAR(100)
    ,AD_POSITION            VARCHAR(5)
    ,AD_MESSAGE_TYPE        VARCHAR(100)
    ,WINNING_BID            DECIMAL(18,2)
    ,BOT                    BOOLEAN
);




/* Data Import */

/*
*  Import data from csv files
*
*  IMPORTANT in some cases it can happen that your local SQL client has no rights to access the data.
*  	best practice: copy the files to your Download folder and try loading them there.
*
*/

SET search_path TO CORE;

COPY CORE.CUSTOMERS  (id, firstname, surname, gender, street, zip, city)
FROM 'C:\Users\<userName>\Downloads\csv\import_core_customers.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.RETAILER  (retailer_id, retailer_name, reseller_type, reseller_level, reseller_address, zip, city)
FROM 'C:\Users\<userName>\Downloads\csv\import_core_retailer.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.ORDERS  (order_id, basket_id, order_date, due_date, shippment_date, product_id, quantity, unit_price)
FROM 'C:\Users\<userName>\Downloads\csv\import_core_orders.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.PRODUCTS (product_id, product_title, category, rating, reviews, price)
FROM 'C:\Users\<userName>\Downloads\csv\import_core_products.csv'
DELIMITER ','
CSV HEADER;

COPY CORE.RETAILER_PRODUCT (product_id, retailer_id)
FROM 'C:\Users\<userName>\Downloads\csv\import_core_retailer_product.csv'
DELIMITER ','
CSV HEADER;



/*
*   create a VIEW CORE.RESELLER_LEVEL which returns a table of retailers and their RESELLER_LEVEL
* 	
* 	The reseller levels are defined within the following  boundaries:
*	- A+:	total_order_amount >= 1000000
*	- A:	total_order_amount > 500000 & total_order_amount < 1000000
*	- B:	total_order_amount > 100000 & total_order_amount <= 500000 
* 	- C:	total_order_amount > 14000  & total_order_amount <= 100000 
* 	- D:	total_order_amount <= 14000 
*/



/*
* Import data for lake tables
*/

SET search_path to LAKE;

INSERT INTO lake.retailer_ad_campaign_dl (rt_ad_h_sk,retailer_id,retailer_name,campaign_id,campaign_name,campaign_budget,start_date,end_date,product_id,product_title,category,max_cpc_bid) VALUES
('luWCghvKdZ',1000,'WERNER',1020,'Summer_Pet_AD_Campaign_KW',4500.00,'2022-12-31','2023-08-31',542,'Laxapet 50g','Pet Supplies',0.89),
('bLwWhX5Wv6',1000,'WERNER',1020,'Summer_AD_Pet_Campaign_KW',4500.00,'2022-12-31','2023-08-31',2507,'Komodo Sand Scoop','Pet Supplies',0.50),
('YSapJpb2Il',1000,'WERNER',1020,'Summer_AD_Pet_Campaign_KW',4500.00,'2022-12-31','2023-08-31',1786,'Aubiose Pet Bedding','Pet Supplies',0.89),
('uq4YFJimfA',1000,'WERNER',1020,'Summer_AD_Pet_Campaign_KW',4500.00,'2022-12-31','2023-08-31',5794,'Equine America Uk','Pet Supplies',0.20),
('rfjFtKvgrs',1000,'WERNER',1020,'Summer_AD_Pet_Campaign_KW',4500.00,'2022-12-31','2023-08-31',954,'Xeno 50 Mini Spot On','Pet Supplies',0.38),
('k5CssqEGrq',1000,'WERNER',1081,'Special_Gaming_Sale',4000.00,'2022-12-31','2023-05-31',7399,'Ubisoft+','PC & Video Games',1.78),
('PuxiyGQmCw',1000,'WERNER',1081,'Special_Gaming_Sale',4000.00,'2022-12-31','2023-05-31',8500,'Elden Ring (PS5)','PC & Video Games',0.70),
('19awJDZ3JI',1000,'WERNER',1081,'Special_Gaming_Sale',4000.00,'2022-12-31','2023-05-31',982,'Swivel Fan Wand','PC & Video Games',0.70),
('ASvIOV3FXE',1000,'WERNER',1081,'Special_Gaming_Sale',4000.00,'2022-12-31','2023-05-31',1781,'Minecraft (Xbox 360)','PC & Video Games',0.50),
('S5OC3X0guf',1000,'WERNER',1081,'Special_Gaming_Sale',4000.00,'2022-12-31','2023-05-31',10163,'No Mans Sky (Switch)','PC & Video Games',0.50),
('1CFps7aDBM',4016,'Junction',1025,'Campaign_Test_Various_Sale',1000.00,'2022-12-31','2023-08-31',3513,'Onzie Girls Pants','Sports & Outdoors',0.89),
('0FlUPlMIar',4016,'Junction',1025,'Campaign_Test_Various_Sale',1000.00,'2022-12-31','2023-08-31',3529,'PGA TOUR Mens Short','Sports & Outdoors',0.89),
('8hMz7qmoyz',4016,'Junction',1025,'Campaign_Test_Various_Sale',1000.00,'2022-12-31','2023-08-31',3543,'Peak Mountain','Sports & Outdoors',0.89),
('7fGTu61PAg',4016,'Junction',1036,'C-1036_ECoShop_Basketball',2500.00,'2022-12-31','2023-06-30',8469,'Jordan Mens Air','Basketball Footwear',2.60),
('P8yidKI6ae',4016,'Junction',1036,'C-1036_ECoShop_Basketball',2500.00,'2022-12-31','2023-06-30',10434,'adidas mens Modern','Basketball Footwear',0.60),
('W3h6PWHm5L',4016,'Junction',1036,'C-1036_ECoShop_Basketball',2500.00,'2022-12-31','2023-06-30',4088,'adidas Ultraboost M','Basketball Footwear',0.60);


INSERT INTO lake.tracking_campaign_dl (tracking_ad_h_sk,session_id,visitor_id,event_timestamp_cet,"FORMAT",page,campaign_id,product_id,impression_id,ad_position,ad_message_type,winning_bid,bot) VALUES
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1020,542,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.11,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1020,542,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.50,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1020,542,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.50,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1020,542,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.71,false),
('37147','734099e92245746d73c56664364557c4','173f8c7104343af877d5610b52d98fae','2022-12-10 07:00:45.254','www.ecoShop.de','Produktliste',1020,542,'2d78e11d752a53e32330016709e023ff','2','page impression',0.59,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1020,542,'477908cab1e2ab9710556034022c0008','3','page impression',0.61,false),
('14818','6b3a85fabd4a569458c6e3d803f32ff8','ddbc05f91c2728d64853fca9ae4bd286','2022-12-10 12:57:34.294','android','Suchergebnisseite',1020,542,'5b2dde6adca168d8ea63274088c99ea2','1','page impression',0.89,false),
('1355','520c1bc4feefd53b6dc3ccdf66be7115','1a2549f621b9968cd00b37e08ff797c6','2022-12-10 10:53:19.991','android','Produktliste',1020,542,'eb1a11b13085436db57631d495490b64','1','page impression',0.45,false),
('1291','32f9d41569bf61e75dd2fc0bf9b5095f','12513fba4ba68b5e0c6b2b6478310843','2022-12-10 12:47:20.618','android','Suchergebnisseite',1020,542,'d043104dc308c0105f103253e981b785','2','page impression',0.54,false),
('25363','63aafa342e3bf62fb74ee8b24cf4640f','3ec7756822dd3abf84fb3a51319c7e5c','2022-12-10 11:22:19.763','www.ecoShop.de','Produktliste',1020,542,'b12a599793d50fbec4be246ddd9e0a7b','1','page impression',0.15,false),
('37154','fbe09be3d1033785e9e61514a812d856','a0ffd6b3534ac515767c4ef420b8cf4e','2022-12-10 12:58:50.258','android','Suchergebnisseite',1020,542,'9787c4fde1cc2d25153bd046ff4b29cb','2','page impression',0.69,false),
('30782','6c4d672de03505d88da43db1ea3d632b','2d0bbf0e1906f97e6663db3b49476ae9','2022-12-10 13:22:23.272','www.ecoShop.de','Produktliste',1020,542,'d6742cef59f19ef3ad27731cd356994a','1','page impression',0.68,false),
('27879','c2161293933d58e5e8085d4a70640fea','3459ac476f02e322a0e5d6096d4da6bd','2022-12-10 17:02:56.887','www.ecoShop.de','Suchergebnisseite',1020,542,'74d3ea6e005a7e5a907f6e3b32a562f0','1','page impression',0.87,false),
('6868','e2162c129ef41318d6254976e4720d43','5ed4742a15a08290bdf04ed103337bbf','2022-12-10 12:17:28.318','android','Suchergebnisseite',1020,542,'c7c8b63e204d2ba58252747ce48aca18','2','page impression',0.12,false),
('30043','835752c3d20cd6e9a99f2f3935751655','b84732c9195d6d6882616e4376625998','2022-12-10 16:05:04.608','www.ecoShop.de','Produktliste',1020,542,'8d8f117f743ffb915659e11fd625a985','1','page impression',0.77,false),
('35808','559d518461badea276ba79a61c1bb08a','220b1cddff7879f52bb9e52fe573dc33','2022-12-10 17:08:44.582','www.ecoShop.de','Suchergebnisseite',1020,542,'6fdf9092fd3d2f8158f1aae3cb3a02f4','1','page impression',0.58,false),
('28384','f0343bc3a73547fe09fee55a00e448e8','ad73df216eebfe4290a8b92b8913ddcb','2022-12-10 07:11:38.511','www.ecoShop.de','Suchergebnisseite',1020,542,'7a8ad3b7a0877fea3032ff4f4220384b','3','page impression',0.14,false),
('12302','f7315927c74dd4b2fee125d6fb450484','bca84e13303f4b0bd0d978d9ec4ab37d','2022-12-10 12:15:43.085','android','Suchergebnisseite',1020,542,'da60f7b21d24638dfe030e3473cccac2','1','page impression',0.73,false),
('29830','947aeaf0f7171c28ed96a87d0363436d','24c3e9a0bbd5dff6eabf8c16038a364a','2022-12-10 11:03:35.699','www.ecoShop.de','Produktliste',1020,542,'9ab41e879aebf062a95c9744208eb900','1','page impression',0.52,false),
('35207','178543ece99770ab3284d4aa68590ebe','84222c1244b560dcbbd131e8a2cc0fd0','2022-12-10 09:28:59.170','android','Produktliste',1020,542,'80be8a31f70741f52e7616dca2d8c6f3','2','page impression',0.19,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1020,2507,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.65,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1020,2507,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.11,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1020,2507,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.15,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1020,2507,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.81,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1020,2507,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.60,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1020,2507,'477908cab1e2ab9710556034022c0008','3','page impression',0.10,false),
('14818','6b3a85fabd4a569458c6e3d803f32ff8','ddbc05f91c2728d64853fca9ae4bd286','2022-12-10 12:57:34.294','android','Suchergebnisseite',1020,2507,'5b2dde6adca168d8ea63274088c99ea2','1','page impression',0.70,false),
('1355','520c1bc4feefd53b6dc3ccdf66be7115','1a2549f621b9968cd00b37e08ff797c6','2022-12-10 10:53:19.991','android','Produktliste',1020,2507,'eb1a11b13085436db57631d495490b64','1','page impression',0.51,false),
('1291','32f9d41569bf61e75dd2fc0bf9b5095f','12513fba4ba68b5e0c6b2b6478310843','2022-12-10 12:47:20.618','android','Suchergebnisseite',1020,2507,'d043104dc308c0105f103253e981b785','2','page impression',0.54,false),
('25363','63aafa342e3bf62fb74ee8b24cf4640f','3ec7756822dd3abf84fb3a51319c7e5c','2022-12-10 11:22:19.763','www.ecoShop.de','Produktliste',1020,2507,'b12a599793d50fbec4be246ddd9e0a7b','1','page impression',0.30,false),
('37154','fbe09be3d1033785e9e61514a812d856','a0ffd6b3534ac515767c4ef420b8cf4e','2022-12-10 12:58:50.258','android','Suchergebnisseite',1020,2507,'9787c4fde1cc2d25153bd046ff4b29cb','2','page impression',0.58,false),
('12588','6afbd102b8216e0b47b92e8236ba9c48','44c77c1db038fe961ad83818fdf110eb','2022-12-10 10:06:58.698','ios','Suchergebnisseite',1020,2507,'c476ee932efdfbe35ca92feb8287d8b6','2','page impression',0.39,false),
('27879','c2161293933d58e5e8085d4a70640fea','3459ac476f02e322a0e5d6096d4da6bd','2022-12-10 17:02:56.887','www.ecoShop.de','Suchergebnisseite',1020,2507,'74d3ea6e005a7e5a907f6e3b32a562f0','1','page impression',0.76,false),
('6868','e2162c129ef41318d6254976e4720d43','5ed4742a15a08290bdf04ed103337bbf','2022-12-10 12:17:28.318','android','Suchergebnisseite',1020,2507,'c7c8b63e204d2ba58252747ce48aca18','2','page impression',0.52,false),
('30043','835752c3d20cd6e9a99f2f3935751655','b84732c9195d6d6882616e4376625998','2022-12-10 16:05:04.608','www.ecoShop.de','Produktliste',1020,2507,'8d8f117f743ffb915659e11fd625a985','1','page impression',0.54,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1020,1786,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.65,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1020,1786,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.13,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1020,1786,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.21,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1020,1786,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.74,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1020,5794,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.23,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1020,5794,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.36,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1020,5794,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.84,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1020,5794,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.83,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1020,5794,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.77,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1020,5794,'477908cab1e2ab9710556034022c0008','3','page impression',0.66,false),
('14818','6b3a85fabd4a569458c6e3d803f32ff8','ddbc05f91c2728d64853fca9ae4bd286','2022-12-10 12:57:34.294','android','Suchergebnisseite',1020,5794,'5b2dde6adca168d8ea63274088c99ea2','1','page impression',0.53,false),
('1355','520c1bc4feefd53b6dc3ccdf66be7115','1a2549f621b9968cd00b37e08ff797c6','2022-12-10 10:53:19.991','android','Produktliste',1020,5794,'eb1a11b13085436db57631d495490b64','1','page impression',0.18,false),
('1291','32f9d41569bf61e75dd2fc0bf9b5095f','12513fba4ba68b5e0c6b2b6478310843','2022-12-10 12:47:20.618','android','Suchergebnisseite',1020,5794,'d043104dc308c0105f103253e981b785','2','page impression',0.43,false),
('25363','63aafa342e3bf62fb74ee8b24cf4640f','3ec7756822dd3abf84fb3a51319c7e5c','2022-12-10 11:22:19.763','www.ecoShop.de','Produktliste',1020,5794,'b12a599793d50fbec4be246ddd9e0a7b','1','page impression',0.46,false),
('37154','fbe09be3d1033785e9e61514a812d856','a0ffd6b3534ac515767c4ef420b8cf4e','2022-12-10 12:58:50.258','android','Suchergebnisseite',1020,5794,'9787c4fde1cc2d25153bd046ff4b29cb','2','page impression',0.82,false),
('12588','6afbd102b8216e0b47b92e8236ba9c48','44c77c1db038fe961ad83818fdf110eb','2022-12-10 10:06:58.698','ios','Suchergebnisseite',1020,5794,'c476ee932efdfbe35ca92feb8287d8b6','2','page impression',0.47,false),
('27879','c2161293933d58e5e8085d4a70640fea','3459ac476f02e322a0e5d6096d4da6bd','2022-12-10 17:02:56.887','www.ecoShop.de','Suchergebnisseite',1020,5794,'74d3ea6e005a7e5a907f6e3b32a562f0','1','page impression',0.46,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1081,7399,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.83,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1081,7399,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.64,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1081,7399,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.34,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1081,7399,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.20,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1081,7399,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.68,false),
('28343','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:28:05.961','www.ecoShop.de','Suchergebnisseite',1081,7399,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.75,false),
('14818','6b3a85fabd4a569458c6e3d803f32ff8','ddbc05f91c2728d64853fca9ae4bd286','2022-12-10 12:57:34.294','android','Suchergebnisseite',1081,7399,'5b2dde6adca168d8ea63274088c99ea2','1','page impression',0.54,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1081,8500,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.16,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1081,8500,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.61,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1081,8500,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.88,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1081,8500,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.18,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1081,8500,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.59,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1081,8500,'477908cab1e2ab9710556034022c0008','3','page impression',0.28,false),
('14818','6b3a85fabd4a569458c6e3d803f32ff8','ddbc05f91c2728d64853fca9ae4bd286','2022-12-10 12:57:34.294','android','Suchergebnisseite',1081,8500,'5b2dde6adca168d8ea63274088c99ea2','1','page impression',0.74,false),
('1355','520c1bc4feefd53b6dc3ccdf66be7115','1a2549f621b9968cd00b37e08ff797c6','2022-12-10 10:53:19.991','android','Produktliste',1081,8500,'eb1a11b13085436db57631d495490b64','1','page impression',0.25,false),
('1291','32f9d41569bf61e75dd2fc0bf9b5095f','12513fba4ba68b5e0c6b2b6478310843','2022-12-10 12:47:20.618','android','Suchergebnisseite',1081,8500,'d043104dc308c0105f103253e981b785','2','page impression',0.38,false),
('25363','63aafa342e3bf62fb74ee8b24cf4640f','3ec7756822dd3abf84fb3a51319c7e5c','2022-12-10 11:22:19.763','www.ecoShop.de','Produktliste',1081,8500,'b12a599793d50fbec4be246ddd9e0a7b','1','page impression',0.35,false),
('37154','fbe09be3d1033785e9e61514a812d856','a0ffd6b3534ac515767c4ef420b8cf4e','2022-12-10 12:58:50.258','android','Suchergebnisseite',1081,8500,'9787c4fde1cc2d25153bd046ff4b29cb','2','page impression',0.61,false),
('12588','6afbd102b8216e0b47b92e8236ba9c48','44c77c1db038fe961ad83818fdf110eb','2022-12-10 10:06:58.698','ios','Suchergebnisseite',1081,8500,'c476ee932efdfbe35ca92feb8287d8b6','2','page impression',0.35,false),
('27879','c2161293933d58e5e8085d4a70640fea','3459ac476f02e322a0e5d6096d4da6bd','2022-12-10 17:02:56.887','www.ecoShop.de','Suchergebnisseite',1081,8500,'74d3ea6e005a7e5a907f6e3b32a562f0','1','page impression',0.81,false),
('6868','e2162c129ef41318d6254976e4720d43','5ed4742a15a08290bdf04ed103337bbf','2022-12-10 12:17:28.318','android','Suchergebnisseite',1081,8500,'c7c8b63e204d2ba58252747ce48aca18','2','page impression',0.37,false),
('30043','835752c3d20cd6e9a99f2f3935751655','b84732c9195d6d6882616e4376625998','2022-12-10 16:05:04.608','www.ecoShop.de','Produktliste',1081,8500,'8d8f117f743ffb915659e11fd625a985','1','page impression',0.51,false),
('35808','559d518461badea276ba79a61c1bb08a','220b1cddff7879f52bb9e52fe573dc33','2022-12-10 17:08:44.582','www.ecoShop.de','Suchergebnisseite',1081,8500,'6fdf9092fd3d2f8158f1aae3cb3a02f4','1','page impression',0.15,false),
('28384','f0343bc3a73547fe09fee55a00e448e8','ad73df216eebfe4290a8b92b8913ddcb','2022-12-10 07:11:38.511','www.ecoShop.de','Suchergebnisseite',1081,8500,'7a8ad3b7a0877fea3032ff4f4220384b','3','page impression',0.35,false),
('12302','f7315927c74dd4b2fee125d6fb450484','bca84e13303f4b0bd0d978d9ec4ab37d','2022-12-10 12:15:43.085','android','Suchergebnisseite',1081,8500,'da60f7b21d24638dfe030e3473cccac2','1','page impression',0.65,false),
('32347','f49fb19cfbfc5ec6788eaa14d191a80a','754e831ee86a22f92b3c044ebaeaa1b7','2022-12-10 16:57:47.535','www.ecoShop.de','Produktliste',1081,8500,'2302463b9d757681c0a81fa9e4050307','1','page impression',0.66,false),
('35207','178543ece99770ab3284d4aa68590ebe','84222c1244b560dcbbd131e8a2cc0fd0','2022-12-10 09:28:59.170','android','Produktliste',1081,8500,'80be8a31f70741f52e7616dca2d8c6f3','2','page impression',0.72,false),
('15207','196472b8edb6613fdda73e045b13fbbb','3aa953e47dcc16dd81fe7979953b0376','2022-12-10 07:13:09.279','www.ecoShop.de','Suchergebnisseite',1081,8500,'93bcb517a97af054159e25334e2aee61','2','page impression',0.37,false),
('25088','ed33c6849eb13fa4de5b2659eb26b99e','3b649028a5d0479a28a360be5f3fd2da','2022-12-10 16:04:11.650','ios','Suchergebnisseite',1081,8500,'4ad3f995dd7590b82697e9ad26f93ade','2','page impression',0.62,false),
('7699','24c81b26fce39289f85ed73294b1cfc7','f61cee1e0ef9c60264f585fe8e00ba1b','2022-12-10 13:46:49.641','ios','Suchergebnisseite',1081,8500,'a9d8512cd4f63ac1f3c2807f056012c1','1','page impression',0.37,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1081,982,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.77,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1081,982,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.54,false),
('2702','deef7f2b266fafc236d837c7686f82cf','b6336eb8cc2c41886620ae5ea658677c','2022-12-10 06:36:17.992','www.ecoShop.de','Suchergebnisseite',1081,982,'b5506dc2177a9d63738f458e7f330394','1','page impression',0.24,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1081,982,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.34,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1081,982,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.81,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1081,982,'477908cab1e2ab9710556034022c0008','3','page impression',0.88,false),
('14818','6b3a85fabd4a569458c6e3d803f32ff8','ddbc05f91c2728d64853fca9ae4bd286','2022-12-10 12:57:34.294','android','Suchergebnisseite',1081,982,'5b2dde6adca168d8ea63274088c99ea2','1','page impression',0.41,false),
('1355','520c1bc4feefd53b6dc3ccdf66be7115','1a2549f621b9968cd00b37e08ff797c6','2022-12-10 10:53:19.991','android','Produktliste',1081,982,'eb1a11b13085436db57631d495490b64','1','page impression',0.73,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1081,1781,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.71,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1081,1781,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.50,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1081,1781,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.11,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1081,1781,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.55,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1081,1781,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.47,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1081,1781,'477908cab1e2ab9710556034022c0008','3','page impression',0.44,false),
('30497','084a7d210650e32bc4cc7aba42268922','475d54602bdf6ca4d8ef3538b9e3f1b3','2022-12-10 10:23:14.242','android','Produktliste',1081,10163,'1b12c09ad8ac938e219cceafa96d4781','1','page impression',0.79,false),
('33175','cb6da4f154d53968228f4bbfcaf9325c','c01acd69b773ca557ddb8878d62ac5c3','2022-12-10 08:18:24.695','ios','Suchergebnisseite',1081,10163,'3a526dbc9b01b30f7f20b0ec0ba153ff','1','page impression',0.29,false),
('27019','f2ad2e60dcb436c9551b7021db2a4cdd','d61ad82070a233ee6e334588b60418c0','2022-12-10 04:39:54.727','ios','Produktliste',1081,10163,'0c35123b14a1ba901c9426431dfa723e','2','page impression',0.58,false),
('705','643f618aa1692b6f5cb1be3c2a849874','5924a99d2b79634bf25d4e3b1a3db75f','2022-12-10 05:09:03.957','android','Suchergebnisseite',1081,10163,'5d5f5a768adb985e6ee10d7f8e4da517','1','page impression',0.58,false),
('4060','a9eb284c4db6e58a937deab2f680640f','f67dbad5618610106685ef44f6423385','2022-12-10 14:26:30.651','www.ecoShop.de','Suchergebnisseite',1081,10163,'0cfa45493500de995cba1ad4c91013c5','2','page impression',0.19,false),
('5621','5501c7f290d76f807bea98c927b48a1c','ab4e4908552568b950adf1200f514efc','2022-12-10 13:48:50.812','android','Suchergebnisseite',1081,10163,'477908cab1e2ab9710556034022c0008','3','page impression',0.53,false),
('1124','475a2109a881fe808f5deeb9785dda29','40bf6fcce7689ed1127f9a3d55c03be0','2022-12-11 07:18:39.597','ios','Suchergebnisseite',1025,3513,'fd210775c7a2eb49d5d6843c41771a59','1','page impression',0.56,false),
('1155','f2fc48933f1166d8c2893f9f2bbf8b00','8c15588da536778257cddc5568004525','2022-12-12 10:40:15.126','android','Suchergebnisseite',1025,3513,'ca4a5ca53b2295e302c48718a27fe31b','2','page impression',0.50,false),
('130','d6e4fa7968d75359f35bd7efef9d33ca','a63ca554261ebcfaa5a04add4aa99f86','2022-12-11 13:25:38.349','www.ecoShop.de','Suchergebnisseite',1025,3513,'b272129c85dcef479c6a48b887a397e6','1','page impression',0.11,false),
('1626','da6e95ea4b5ce1cd681cdf2e29777860','09d86bcc9326f2b511ac332b45ad3c28','2022-12-11 07:15:22.179','ios','Produktliste',1025,3513,'00575fb2e95195d0c3205d81aba3a93e','1','page impression',0.25,false),
('1311','32faf1f56b407fcdf7111b113be02438','6f172c25c71fd4bb0ceca4dca8311f9d','2022-12-10 12:36:37.843','android','Suchergebnisseite',1025,3513,'5d541cb261f0a48b36dcc8fb807125e2','2','page impression',0.88,false),
('258','733611c6403c2669772bdd946b30b2ea','6bd50da786143c2be9099c778eef0283','2022-12-10 12:46:17.445','www.ecoShop.de','Produktliste',1025,3513,'75a803f1c55a48cfc8d7ddec770c4173','3','page impression',0.31,false),
('1124','475a2109a881fe808f5deeb9785dda29','40bf6fcce7689ed1127f9a3d55c03be0','2022-12-11 07:18:39.597','ios','Suchergebnisseite',1025,3529,'fd210775c7a2eb49d5d6843c41771a59','1','page impression',0.47,false),
('849','d027ba4f8891719886e092d8472d760e','aa49ce07030c57a0afcd21739f38d209','2022-12-10 07:13:43.393','ios','Suchergebnisseite',1025,3529,'0eade6634eabb81662dba10d9bead832','1','page impression',0.55,false),
('876','2c71c30d84737dc85cb118c5c31a9ceb','7c80a87744b7db5788e8d2cded28589d','2022-12-10 11:35:51.015','www.ecoShop.de','Produktliste',1025,3529,'78de774d4057c048c16ed856c374f0e6','2','page impression',0.38,false),
('1388','7170105255372bd81c0c02e82037cf1d','545b28ca47c8b2c568576c0fdb20073d','2022-12-10 09:37:45.883','ios','Produktliste',1025,3529,'d7f5e381b52292e61df87db32ba76895','2','page impression',0.61,false),
('1626','da6e95ea4b5ce1cd681cdf2e29777860','09d86bcc9326f2b511ac332b45ad3c28','2022-12-11 07:15:22.179','ios','Produktliste',1025,3529,'00575fb2e95195d0c3205d81aba3a93e','1','page impression',0.22,false),
('1124','475a2109a881fe808f5deeb9785dda29','40bf6fcce7689ed1127f9a3d55c03be0','2022-12-11 07:18:39.597','ios','Suchergebnisseite',1025,3543,'fd210775c7a2eb49d5d6843c41771a59','1','page impression',0.39,false),
('849','d027ba4f8891719886e092d8472d760e','aa49ce07030c57a0afcd21739f38d209','2022-12-10 07:13:43.393','ios','Suchergebnisseite',1025,3543,'0eade6634eabb81662dba10d9bead832','1','page impression',0.50,false),
('876','2c71c30d84737dc85cb118c5c31a9ceb','7c80a87744b7db5788e8d2cded28589d','2022-12-10 11:35:51.015','www.ecoShop.de','Produktliste',1025,3543,'78de774d4057c048c16ed856c374f0e6','2','page impression',0.29,false),
('130','d6e4fa7968d75359f35bd7efef9d33ca','a63ca554261ebcfaa5a04add4aa99f86','2022-12-11 13:25:38.349','www.ecoShop.de','Suchergebnisseite',1025,3543,'b272129c85dcef479c6a48b887a397e6','1','page impression',0.17,false),
('1626','da6e95ea4b5ce1cd681cdf2e29777860','09d86bcc9326f2b511ac332b45ad3c28','2022-12-11 07:15:22.179','ios','Produktliste',1025,3543,'00575fb2e95195d0c3205d81aba3a93e','1','page impression',0.62,false),
('1311','32faf1f56b407fcdf7111b113be02438','6f172c25c71fd4bb0ceca4dca8311f9d','2022-12-10 12:36:37.843','android','Suchergebnisseite',1025,3543,'5d541cb261f0a48b36dcc8fb807125e2','2','page impression',0.60,false),
('454','2e2ae34c362abfdd71d7798546ba9de8','770c3903721b6d52cb5bed64207cec81','2022-12-11 12:54:31.802','www.ecoShop.de','Suchergebnisseite',1025,3543,'67cf41cee79b979aeb9c23572dfa3674','1','page impression',0.62,false),
('127','8abb047bfefc04635be083dea1af067b','8e1cc4c63ea444f24a287a4f46422568','2022-12-11 09:03:36.857','ios','Produktliste',1025,3543,'b48bd64c5a506d623635d9d22c2fa071','3','page impression',0.55,false),
('422','0b7f65b24c33b1501e141f3260033b30','b8a6236bdf8662727cea3b517bd98eee','2022-12-10 14:31:17.194','ios','Suchergebnisseite',1025,3543,'994321fb001f38a99b83dfd930f54bf5','2','page impression',0.40,false),
('782','00bac9940bfd78cc7c4f10011c5120f0','cca0fd5d9ef3c79070153535f09c7604','2022-12-11 07:44:37.111','www.ecoShop.de','Produktliste',1025,3543,'4f885ed906d25e461009e7b27bde6223','1','page impression',0.86,false),
('623','a58eb7627970a19deb7615e22071ed4e','0e6c91a29662c9abc5f1bf5159547b8e','2022-12-10 14:30:36.512','www.ecoShop.de','Produktliste',1025,3543,'9d62f708c432144b59f85250f5c10f56','2','page impression',0.47,false),
('478','eaa8348f8ff841354e7337110c69d2ab','256ec407ad65684ed3bcb98212c88231','2022-12-10 12:56:37.169','www.ecoShop.de','Produktliste',1025,3543,'d0985e4865b493ee799b8443f0b246f1','2','page impression',0.29,false),
('471','eac17901d53756ea0cfd5904b14212c3','3d0d7468bcbcaeb9e1a0609d46e29ce2','2022-12-10 18:12:02.983','www.ecoShop.de','Produktliste',1025,3543,'c993a89c255338ef6a65d6eacdf4aa63','2','page impression',0.18,false),
('1818','40c5b63e604e7d3e8150d068f513ccf0','39e4aaaf6619d14cd8a520bbd5a1d793','2022-12-10 12:07:38.205','www.ecoShop.de','Produktliste',1025,3543,'cc8c8e2f4fa2828cba72ab74a1a28ad6','2','page impression',0.72,false),
('611','bcfe6e780e593fb0d3318f378de554fc','0d00c04d8f6c026cfd62606231f8c1d6','2022-12-14 11:45:17.454','www.ecoShop.de','Suchergebnisseite',1025,3543,'a632a31cff5b7e51d4a572ead04238ab','2','page impression',0.55,false),
('1124','475a2109a881fe808f5deeb9785dda29','40bf6fcce7689ed1127f9a3d55c03be0','2022-12-11 07:18:39.597','ios','Suchergebnisseite',1036,8469,'fd210775c7a2eb49d5d6843c41771a59','1','page impression',0.20,false),
('849','d027ba4f8891719886e092d8472d760e','aa49ce07030c57a0afcd21739f38d209','2022-12-10 07:13:43.393','ios','Suchergebnisseite',1036,8469,'0eade6634eabb81662dba10d9bead832','1','page impression',0.61,false),
('876','2c71c30d84737dc85cb118c5c31a9ceb','7c80a87744b7db5788e8d2cded28589d','2022-12-10 11:35:51.015','www.ecoShop.de','Produktliste',1036,8469,'78de774d4057c048c16ed856c374f0e6','2','page impression',0.48,false),
('130','d6e4fa7968d75359f35bd7efef9d33ca','a63ca554261ebcfaa5a04add4aa99f86','2022-12-11 13:25:38.349','www.ecoShop.de','Suchergebnisseite',1036,8469,'b272129c85dcef479c6a48b887a397e6','1','page impression',0.28,false),
('1626','da6e95ea4b5ce1cd681cdf2e29777860','09d86bcc9326f2b511ac332b45ad3c28','2022-12-11 07:15:22.179','ios','Produktliste',1036,8469,'00575fb2e95195d0c3205d81aba3a93e','1','page impression',0.45,false),
('1311','32faf1f56b407fcdf7111b113be02438','6f172c25c71fd4bb0ceca4dca8311f9d','2022-12-10 12:36:37.843','android','Suchergebnisseite',1036,8469,'5d541cb261f0a48b36dcc8fb807125e2','2','page impression',0.70,false),
('454','2e2ae34c362abfdd71d7798546ba9de8','770c3903721b6d52cb5bed64207cec81','2022-12-11 12:54:31.802','www.ecoShop.de','Suchergebnisseite',1036,8469,'67cf41cee79b979aeb9c23572dfa3674','1','page impression',0.55,false),
('127','8abb047bfefc04635be083dea1af067b','8e1cc4c63ea444f24a287a4f46422568','2022-12-11 09:03:36.857','ios','Produktliste',1036,8469,'b48bd64c5a506d623635d9d22c2fa071','3','page impression',0.16,false),
('422','0b7f65b24c33b1501e141f3260033b30','b8a6236bdf8662727cea3b517bd98eee','2022-12-10 14:31:17.194','ios','Suchergebnisseite',1036,8469,'994321fb001f38a99b83dfd930f54bf5','2','page impression',0.43,false),
('782','00bac9940bfd78cc7c4f10011c5120f0','cca0fd5d9ef3c79070153535f09c7604','2022-12-11 07:44:37.111','www.ecoShop.de','Produktliste',1036,8469,'4f885ed906d25e461009e7b27bde6223','1','page impression',0.48,false),
('623','a58eb7627970a19deb7615e22071ed4e','0e6c91a29662c9abc5f1bf5159547b8e','2022-12-10 14:30:36.512','www.ecoShop.de','Produktliste',1036,8469,'9d62f708c432144b59f85250f5c10f56','2','page impression',0.15,false),
('478','eaa8348f8ff841354e7337110c69d2ab','256ec407ad65684ed3bcb98212c88231','2022-12-10 12:56:37.169','www.ecoShop.de','Produktliste',1036,8469,'d0985e4865b493ee799b8443f0b246f1','2','page impression',0.25,false),
('471','eac17901d53756ea0cfd5904b14212c3','3d0d7468bcbcaeb9e1a0609d46e29ce2','2022-12-10 18:12:02.983','www.ecoShop.de','Produktliste',1036,8469,'c993a89c255338ef6a65d6eacdf4aa63','2','page impression',0.27,false),
('1818','40c5b63e604e7d3e8150d068f513ccf0','39e4aaaf6619d14cd8a520bbd5a1d793','2022-12-10 12:07:38.205','www.ecoShop.de','Produktliste',1036,8469,'cc8c8e2f4fa2828cba72ab74a1a28ad6','2','page impression',0.27,false),
('611','bcfe6e780e593fb0d3318f378de554fc','0d00c04d8f6c026cfd62606231f8c1d6','2022-12-14 11:45:17.454','www.ecoShop.de','Suchergebnisseite',1036,8469,'a632a31cff5b7e51d4a572ead04238ab','2','page impression',0.73,false),
('1124','475a2109a881fe808f5deeb9785dda29','40bf6fcce7689ed1127f9a3d55c03be0','2022-12-11 07:18:39.597','ios','Suchergebnisseite',1036,10434,'fd210775c7a2eb49d5d6843c41771a59','1','page impression',0.87,false),
('849','d027ba4f8891719886e092d8472d760e','aa49ce07030c57a0afcd21739f38d209','2022-12-10 07:13:43.393','ios','Suchergebnisseite',1036,10434,'0eade6634eabb81662dba10d9bead832','1','page impression',0.18,false),
('876','2c71c30d84737dc85cb118c5c31a9ceb','7c80a87744b7db5788e8d2cded28589d','2022-12-10 11:35:51.015','www.ecoShop.de','Produktliste',1036,10434,'78de774d4057c048c16ed856c374f0e6','2','page impression',0.45,false),
('130','d6e4fa7968d75359f35bd7efef9d33ca','a63ca554261ebcfaa5a04add4aa99f86','2022-12-11 13:25:38.349','www.ecoShop.de','Suchergebnisseite',1036,10434,'b272129c85dcef479c6a48b887a397e6','1','page impression',0.40,false),
('1626','da6e95ea4b5ce1cd681cdf2e29777860','09d86bcc9326f2b511ac332b45ad3c28','2022-12-11 07:15:22.179','ios','Produktliste',1036,10434,'00575fb2e95195d0c3205d81aba3a93e','1','page impression',0.51,false),
('1311','32faf1f56b407fcdf7111b113be02438','6f172c25c71fd4bb0ceca4dca8311f9d','2022-12-10 12:36:37.843','android','Suchergebnisseite',1036,10434,'5d541cb261f0a48b36dcc8fb807125e2','2','page impression',0.62,false),
('454','2e2ae34c362abfdd71d7798546ba9de8','770c3903721b6d52cb5bed64207cec81','2022-12-11 12:54:31.802','www.ecoShop.de','Suchergebnisseite',1036,10434,'67cf41cee79b979aeb9c23572dfa3674','1','page impression',0.13,false),
('127','8abb047bfefc04635be083dea1af067b','8e1cc4c63ea444f24a287a4f46422568','2022-12-11 09:03:36.857','ios','Produktliste',1036,10434,'b48bd64c5a506d623635d9d22c2fa071','3','page impression',0.46,false),
('422','0b7f65b24c33b1501e141f3260033b30','b8a6236bdf8662727cea3b517bd98eee','2022-12-10 14:31:17.194','ios','Suchergebnisseite',1036,10434,'994321fb001f38a99b83dfd930f54bf5','2','page impression',0.69,false),
('1124','475a2109a881fe808f5deeb9785dda29','40bf6fcce7689ed1127f9a3d55c03be0','2022-12-11 07:18:39.597','ios','Suchergebnisseite',1036,4088,'fd210775c7a2eb49d5d6843c41771a59','1','page impression',0.35,false),
('849','d027ba4f8891719886e092d8472d760e','aa49ce07030c57a0afcd21739f38d209','2022-12-10 07:13:43.393','ios','Suchergebnisseite',1036,4088,'0eade6634eabb81662dba10d9bead832','1','page impression',0.84,false),
('876','2c71c30d84737dc85cb118c5c31a9ceb','7c80a87744b7db5788e8d2cded28589d','2022-12-10 11:35:51.015','www.ecoShop.de','Produktliste',1036,4088,'78de774d4057c048c16ed856c374f0e6','2','page impression',0.30,false),
('130','d6e4fa7968d75359f35bd7efef9d33ca','a63ca554261ebcfaa5a04add4aa99f86','2022-12-11 13:25:38.349','www.ecoShop.de','Suchergebnisseite',1036,4088,'b272129c85dcef479c6a48b887a397e6','1','page impression',0.50,false),
('1626','da6e95ea4b5ce1cd681cdf2e29777860','09d86bcc9326f2b511ac332b45ad3c28','2022-12-11 07:15:22.179','ios','Produktliste',1036,4088,'00575fb2e95195d0c3205d81aba3a93e','1','page impression',0.63,false),
('1311','32faf1f56b407fcdf7111b113be02438','6f172c25c71fd4bb0ceca4dca8311f9d','2022-12-10 12:36:37.843','android','Suchergebnisseite',1036,4088,'5d541cb261f0a48b36dcc8fb807125e2','2','page impression',0.62,false),
('454','2e2ae34c362abfdd71d7798546ba9de8','770c3903721b6d52cb5bed64207cec81','2022-12-11 12:54:31.802','www.ecoShop.de','Suchergebnisseite',1036,4088,'67cf41cee79b979aeb9c23572dfa3674','1','page impression',0.44,false);
