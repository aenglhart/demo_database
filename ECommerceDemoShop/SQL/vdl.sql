/*
*   create a VIEW which returns a table of retailers and their RESELLER_LEVEL
*/

create or replace view CORE.RESELLER_LEVEL as (
	with amount_per_order as (
		select ORDER_ID 
			, product_id 
			, QUANTITY * UNIT_PRICE 	as total_order_amount 
		from core.ORDERS O2 
		group by ORDER_ID, product_id  
	), total_order_amount_retailer as (
		select rp.RETAILER_ID 
			, sum(apo.total_order_amount) 	as total_order_amount
		from core.RETAILER_PRODUCT RP 
		join core.PRODUCTS P 
			on rp.PRODUCT_ID = p.PRODUCT_ID 
		join amount_per_order apo 
			on p.PRODUCT_ID = apo.product_id
		group by rp.RETAILER_ID
	)
	select retailer_id
		, case 
			when toar.total_order_amount <= 14000 then 'D'
			when toar.total_order_amount > 14000 and toar.total_order_amount <= 100000 then 'C'
			when toar.total_order_amount > 100000 and toar.total_order_amount <= 500000 then 'B'
			when toar.total_order_amount > 500000 and toar.total_order_amount < 1000000 then 'A'
			when toar.total_order_amount >= 1000000 then 'A+'
		end	as RESELLER_LEVEL	
	from total_order_amount_retailer toar
);