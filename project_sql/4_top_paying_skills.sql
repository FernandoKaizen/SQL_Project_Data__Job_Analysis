/*
Answer: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst positions
-Focuses on roles with specified salaries, regardless of location
-Why? It reveals how diffrente skills impact salary levels for Data Analysts and
 helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    AVG(salary_year_avg) AS average_salary
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;