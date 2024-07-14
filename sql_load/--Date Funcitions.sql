--Date Functions
--::DATE - Removing the time portion
--AT TIME ZONE - Especific TZ
--EXTRACT: Get time parts (e.g, year, month, day)
--Note: Timestamp = Date and Time

SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

--CAST STRING AS DATE
SELECT '2023-02-19';

SELECT '2023-02-19'::DATE;


--EX.:
SELECT
    '2023-02-19'::DATE,
    '123'::INTERGER,
    'True'::BOOLEAN,
    '3.14'::REAL;

--1) CAST AS DATE
SELECT
    job_title_short AS title,
    job_location AS job_location,
    job_posted_date::DATE AS date --CAST AS DATE
FROM
    job_postings_fact;

--2) AT TIME ZONE
SELECT
    job_title_short AS title,
    job_location AS job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date --CONVERTED UTC Universal +00:00 to UTC EST (Eastern Standart Time) -5:00
FROM
    job_postings_fact;


--3) EXTRACT
SELECT
    job_title_short AS title,
    job_location AS job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date, --CONVERTED UTC Universal +00:00 to UTC EST (Eastern Standart Time) -5:00
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact;

--EXERCÍCIO: QUAIS OS MESES COM MAIOR NÚMERO DE JOBS PARA DATA ANALYST?
SELECT
    job_title_short AS title,
    COUNT(job_id) AS number_of_jobs,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    title, month 
ORDER BY
    number_of_jobs DESC;