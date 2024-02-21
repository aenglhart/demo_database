/*
*    
*/

create schema Adventure_Works;

create table ADVENTURE_WORKS.SALES_ORDER (
	 Channel 				VARCHAR(100)
	,Sales_Order_Line_Key	VARCHAR(100)
	,Sales_Order			VARCHAR(100)
	,Sales_Order_Line		VARCHAR(100)
);

create table ADVENTURE_WORKS.SALES_TERRETORY_DATA (
	 Sales_Territory_Key		INTEGER
	,Region						VARCHAR(100)
	,Country					VARCHAR(100)
	,"Group"					VARCHAR(100)
);

create table ADVENTURE_WORKS.SALES_DATA (
	 Sales_Order_Line_Key		VARCHAR(100)
	,Reseller_Key				VARCHAR(100)
	,Customer_Key				VARCHAR(100)
	,Product_Key				VARCHAR(100)
	,Order_Date_Key				VARCHAR(100)
	,Due_Date_Key				VARCHAR(100)
	,Ship_Date_Key				VARCHAR(100)
	,Sales_Territory_Key		INTEGER
	,Order_Quantity				INTEGER	
	,Unit_Price					VARCHAR(100)
	,Extended_Amount			VARCHAR(100)
	,Unit_Price_Discount_Pct	VARCHAR(100)
	,Product_Standard_Cost		VARCHAR(100)
	,Total_Product_Cost			VARCHAR(100)
	,Sales_Amount				VARCHAR(100)
);

create table ADVENTURE_WORKS.RESELLER_DATA(
	 Reseller_Key				VARCHAR(100)
	,Reseller_ID				VARCHAR(100)
	,Business_Type				VARCHAR(100)
	,Reseller					VARCHAR(100)
	,City						VARCHAR(100)
	,State_Province				VARCHAR(100)
	,Country_Region				VARCHAR(100)
	,Postal_Code				VARCHAR(100)
);

create table ADVENTURE_WORKS.PRODUCT_DATA(
	 Product_Key				VARCHAR(100)
	,SKU						VARCHAR(100)
	,Product					VARCHAR(100)
	,Standard_Cost				VARCHAR(100)
	,Color						VARCHAR(100)
	,List_Price					VARCHAR(100)
	,Model						VARCHAR(100)
	,Subcategory				VARCHAR(100)
	,Category					VARCHAR(100)
);

create table ADVENTURE_WORKS.CUSTOMER_DATA(
	 Customer_Key				VARCHAR(100)
	,Customer_ID				VARCHAR(100)
	,Customer					VARCHAR(100)
	,City						VARCHAR(100)
	,Country_Region				VARCHAR(100)
	,Postal_Code				VARCHAR(100)
);
