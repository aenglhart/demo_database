COPY ADVENTURE_WORKS.SALES_ORDER  (Channel
								 	,Sales_Order_Line_Key
								 	,Sales_Order
								   	,Sales_Order_Line
								  )
FROM 'C:\Users\AENGLHAR\Repos\AdventureWorks\CSV\AdventureWorks Sales_Sales Order_data.csv'
DELIMITER ';'
CSV HEADER;

COPY ADVENTURE_WORKS.SALES_TERRETORY_DATA  (Sales_Territory_Key
											,Region				
											,Country			
											,"Group"			
										  )
FROM 'C:\Users\AENGLHAR\Repos\AdventureWorks\CSV\AdventureWorks Sales_Sales Territory_data.csv'
DELIMITER ';'
CSV HEADER;

COPY ADVENTURE_WORKS.SALES_DATA  (Sales_Order_Line_Key	
									,Reseller_Key			
									,Customer_Key			
									,Product_Key			
									,Order_Date_Key			
									,Due_Date_Key			
									,Ship_Date_Key			
									,Sales_Territory_Key	
									,Order_Quantity			
									,Unit_Price				
									,Extended_Amount		
									,Unit_Price_Discount_Pct
									,Product_Standard_Cost	
									,Total_Product_Cost		
									,Sales_Amount		
								 )
FROM 'C:\Users\AENGLHAR\Repos\AdventureWorks\CSV\AdventureWorks Sales_Sales_data.csv'
DELIMITER ';'
CSV HEADER;

COPY ADVENTURE_WORKS.RESELLER_DATA  (Reseller_Key	
										,Reseller_ID	
										,Business_Type	
										,Reseller		
										,City			
										,State_Province	
										,Country_Region	
										,Postal_Code	
									)
FROM 'C:\Users\AENGLHAR\Repos\AdventureWorks\CSV\AdventureWorks Sales_Reseller_data.csv'
DELIMITER ';'
CSV HEADER;

COPY ADVENTURE_WORKS.PRODUCT_DATA  (Product_Key	
										,SKU			
										,Product		
										,Standard_Cost	
										,Color			
										,List_Price		
										,Model			
										,Subcategory	
										,Category		
									)
FROM 'C:\Users\AENGLHAR\Repos\AdventureWorks\CSV\AdventureWorks Sales_Product_data.csv'
DELIMITER ';'
CSV HEADER;

COPY ADVENTURE_WORKS.CUSTOMER_DATA  (Customer_Key	
										,Customer_ID	
										,Customer		
										,City			
										,Country_Region	
										,Postal_Code	
									)
FROM 'C:\Users\AENGLHAR\Repos\AdventureWorks\CSV\AdventureWorks Sales_Customer_data.csv'
DELIMITER ';'
CSV HEADER;