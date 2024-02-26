
INSERT INTO dateTable
    SELECT TO_CHAR(datum,'yyyymmdd')::INT AS date_id,
    datum AS date,
    EXTRACT(epoch FROM datum) AS epoch,
    TO_CHAR(datum,'Dth') AS day_suffix,
    TO_CHAR(datum,'Day') AS day_name,
    TO_CHAR(datum,'Dy') AS day_name_abbr,
    EXTRACT(isodow FROM datum) AS day_of_week,
    EXTRACT(DAY FROM datum) AS day_of_month,
    datum - DATE_TRUNC('quarter',datum)::DATE +1 AS day_of_quarter,
    EXTRACT(doy FROM datum) AS day_of_year,
    TO_CHAR(datum,'W')::INT AS week_of_month,
    EXTRACT(week FROM datum) AS week_of_year,
    TO_CHAR(datum,'YYYY"-W"IW-D') AS week_of_year_iso,
    EXTRACT(MONTH FROM datum) AS month_,
    TO_CHAR(datum,'Month') AS month_name,
    TO_CHAR(datum,'Mon') AS month_name_abbr,
    EXTRACT(quarter FROM datum) AS quarter_,
    CONCAT('Q',EXTRACT(quarter FROM datum)) quarter_name,
    EXTRACT(isoyear FROM datum) AS year_,
    DATE_TRUNC('week', datum)::date AS start_of_week,
    DATE_TRUNC('month', datum)::date AS start_of_month,
    CASE 
            WHEN EXTRACT(DAY FROM datum) < 15 THEN
                DATE_TRUNC('month', datum)::date
            ELSE
                DATE_TRUNC('month', datum)::date + INTERVAL '14 days'
        END AS start_of_midmonth,
    DATE_TRUNC('quarter',datum)::DATE AS start_of_quarter,
    DATE_TRUNC('YEAR',datum)::DATE AS start_of_year,
    (DATE_TRUNC('WEEK',datum) +INTERVAL '1 WEEK - 1 day')::DATE AS end_of_week,
    (DATE_TRUNC('MONTH',datum) +INTERVAL '1 MONTH - 1 day')::DATE AS end_of_month,
    (DATE_TRUNC('quarter',datum) +INTERVAL '3 MONTH - 1 day')::DATE AS end_of_quarter,
    (DATE_TRUNC('YEAR',datum)::DATE +INTERVAL '1 YEAR - 1 day')::DATE AS end_of_year,
    TO_CHAR(datum,'yyyymm') AS yyyymm,
    TO_CHAR(datum,'yyyymmdd') AS yyyymmdd,
    EXTRACT(year FROM datum) "Year",
    CONCAT(EXTRACT(year FROM datum),'-',TO_CHAR(datum,'Mon'))  "Month",
    CONCAT(EXTRACT(year FROM datum),'-Q',EXTRACT(quarter FROM datum)) "Quarter",
    DATE_TRUNC('week', datum)::date "Week Monday",
    CASE WHEN EXTRACT(isodow FROM datum) IN (6,7) THEN 1 ELSE 0 END AS is_weekend FROM (SELECT datum::date FROM GENERATE_SERIES (
        DATE '2000-01-01', 
        DATE '2030-12-31', 
        INTERVAL '1 day'
    ) AS datum) dates_series;