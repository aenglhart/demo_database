insert into demo_addresses_germany(
	select 
		row_number() over (order by street )as ID
		,street
		,zip
		,city
	from DEMO_ADDRESSES_GERMANY
	where street ~ '^[^0-9]'
	OR	length(street) >= 3
	OR 	street not like '-%'

);


insert into DEMO_IDENTITIES_GERMANY(
    select dpg.ID  
        , dpg.FIRSTNAME
        , dpg.SURNAME
        , dpg.GENDER
        , diag.STREET
        , diag.ZIP
        , diag.CITY
    from DEMO_PERSON_GERMANY dpg 
    join DEMO_IDENTITY_ADDRESSES_GERMANY diag 
        on dpg.ID = diag.ID
);