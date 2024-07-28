/*
Answer: What are the most optimal skills to learn it's in high demand and high-paying skill?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for careep development in data analysis
*/

WITH skills_demand AS (
SELECT
    sd.skill_id,
    sd.skills, 
    COUNT(sjd.job_id) as demand_count -- 1) Skills com maior demanda: Contagem de IDs no join entre postagem e nome dos skills
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id --3) Estes Joins são necessários para retornar o nome do skill na table
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE --2) Respeitando estes filtros
    job_title_short = 'Data Analyst' --2) Respeitando os seguintes filtros
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    sd.skill_id --4) Agrupados por skills
), average_salary AS(
SELECT
    sjd.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS average_salary 
FROM
    job_postings_fact jpf --1) A média salarial está na job_postings_fact
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id --3) Joins feitos para trazer o nome dos skills da skills_dim
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' --2) Respeitando estes filtros
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    sjd.skill_id --4) Por skill
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id --1) Join entre as duas tabelas para trazer dados de ambas
WHERE demand_count > 10
ORDER BY
    average_salary DESC,  --2) Final: Os top 25 skills por demand x salary
    demand_count DESC
LIMIT 25;


--Rewriting this same query more concisely
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim) = 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
