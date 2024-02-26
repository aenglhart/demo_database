/*
*   Credits to: Jason Tragakis
*   https://medium.com/justdataplease/building-a-dynamic-date-calendar-in-postgresql-a-step-by-step-guide-20c8edfc3bf7
*/ 

CREATE TABLE dateTable (
    date_id          INT NOT NULL,
    date             DATE NOT NULL,
    epoch            BIGINT NOT NULL,
    day_suffix       VARCHAR(4) NOT NULL,
    day_name         VARCHAR(9) NOT NULL,
    day_name_abbr    VARCHAR(9) NOT NULL,
    day_of_week      INT NOT NULL,
    day_of_month     INT NOT NULL,
    day_of_quarter   INT NOT NULL,
    day_of_year      INT NOT NULL,
    week_of_month    INT NOT NULL,
    week_of_year     INT NOT NULL,
    week_of_year_iso CHAR(10) NOT NULL,
    month_           INT NOT NULL,
    month_name       VARCHAR(9) NOT NULL,
    month_name_abbr  CHAR(3) NOT NULL,
    quarter_         INT NOT NULL,
    quarter_name     VARCHAR(9) NOT NULL,
    year_            INT NOT NULL,
    start_of_week    DATE NOT NULL,
    start_of_month   DATE NOT NULL,
    start_of_midmonth DATE NOT NULL,
    start_of_quarter DATE NOT NULL,
    start_of_year   DATE NOT NULL,
    end_of_week     DATE NOT NULL,
    end_of_month    DATE NOT NULL,
    end_of_quarter  DATE NOT NULL,
    end_of_year     DATE NOT NULL,
    yyyymm          VARCHAR NOT NULL,
    yyyymmdd        VARCHAR NOT NULL,
    "Year"          VARCHAR,
    "Month"         VARCHAR,
    "Quarter"       VARCHAR,
    "Week Monday"   VARCHAR,
    is_weekend INT2 NOT NULL
);

ALTER TABLE public.dateTable ADD CONSTRAINT dateTable_date_pk PRIMARY KEY (date_id);


CREATE INDEX dateTable_date_ac_idx ON dateTable(date);