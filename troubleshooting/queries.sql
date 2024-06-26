-- get all rows from the table with a condition applied
select * from "raw".injixo_testplan
where start_date = '2024-05-03';
----------------------------------------
-- check for duplicate rows
select employee_id, personnel_number, activity_id, third_party_interface, type, start_date, start_time, end_date, end_time, duration, count(*) as count
from "raw".injixo_testplan
group by employee_id, personnel_number, activity_id, third_party_interface, type, start_date, start_time, end_date, end_time, duration
having count(*) > 1;
----------------------------------------
-- get the max or last date
SELECT MAX(start_date) AS max_date
FROM "raw".injixo_testplan;
----------------------------------------
-- select the last 40 days from injixo_testplan
WITH MaxStartDate AS (
   SELECT CURRENT_DATE AS max_date
)
SELECT DISTINCT start_date
FROM "raw"."injixo_testplan"
WHERE TO_DATE(start_date, 'YYYY-MM-DD') >= (SELECT max_date - INTERVAL '40 days' FROM MaxStartDate)
ORDER BY start_date DESC;
---------------------------------------
-- delete the data from injixo_testplan table for the last 40 days
WITH MaxStartDate AS (
   SELECT CURRENT_DATE AS max_date
)
DELETE FROM "raw"."injixo_testplan"
WHERE TO_DATE(start_date, 'YYYY-MM-DD') >= (SELECT max_date - INTERVAL '40 days' FROM MaxStartDate);
---------------------------------------
-- get the start_date from injixo_testplan in desc order
SELECT distinct start_date
FROM "raw".injixo_testplan
ORDER BY start_date DESC;
--------------------------------------
-- select a range of dates from the date_lookup table between max_date from start_date column in injixo_testplan until the current_date
WITH MaxDate AS (
    SELECT MAX(TO_DATE(start_date, 'YYYY-MM-DD')) AS max_date
    FROM "raw"."injixo_testplan"
)
SELECT *
FROM "raw"."date_lookup"
WHERE date BETWEEN (SELECT max_date + INTERVAL '1 day' FROM MaxDate) AND CURRENT_DATE
ORDER BY date ASC;
--------------------------------------
-- count total rows
SELECT COUNT(*) AS total_rows
FROM "raw".injixo_testplan;
