/*
Question: What are the top-paying Data Analyst jobs?
- Identify the top 10 highest-paying Data Analyst role that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analytics , offering insights into employes
*/

SELECT  --4) Retorne as seguintes colunas na consulta
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id --3) Este left join foi necessário para fornecer o nome das empresas
WHERE
    job_title_short = 'Data Analyst' AND --2) Respeitando os seguintes filtros
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC  --1) As 10 maiores médias salariais
LIMIT 10

    