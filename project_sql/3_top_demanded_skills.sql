/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 4 in-demand skills for a data analyst
- Focus on all job postings
- Why? Retrieve the top 5 skills with the highest demand in the job market
 -Providing insights into the most valuable skills for job seekers
*/


SELECT
    skills, 
    COUNT(sjd.job_id) as demand_count -- 4) Contagem de IDs no join entre postagem e nome dos skills
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id --3) Estes Joins são necessários para retornar o nome do skill na table
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE --2) Respeitando estes filtros
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC --1) Os 5 skills com maior demanda
LIMIT 5 



SELECT *
FROM skills_dim

SELECT *
FROM skills_job_dim