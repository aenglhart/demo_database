create or replace view DEMO_IDENTITY_ADDRESSES_GERMANY as (
with random_adresses as (
	select *
	from DEMO_ADDRESSES_GERMANY DAG 
	order by RANDOM()
	limit 4182
), addresses_with_streetnumber as (
	select concat(street, ' ', floor(RANDOM()*98)+1) as street
		, zip 
		, city
		, floor(RANDOM()*5000)+1 as order_number
	from random_adresses
)
select row_number() over (order by order_number) AS ID 
	, street 
	, zip 
	, city 
from addresses_with_streetnumber 
limit 4182);