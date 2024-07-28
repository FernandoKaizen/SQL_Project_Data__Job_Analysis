/*
Answer: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst positions
-Focuses on roles with specified salaries, regardless of location
-Why? It reveals how diffrente skills impact salary levels for Data Analysts and
 helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary 
FROM
    job_postings_fact jpf --5) A média salarial está na job_postings_fact
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id --4) Joins feitos para trazer o nome dos skills da skills_dim
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' --2) Respeitando estes filtros
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills --3) Por skill
ORDER BY
    average_salary DESC --1) As 25 maiores médias salariais
LIMIT 25;

-- Here are top paying skills for data analysts, the top 25, can you provide some quick insights into some trends into the top paying jobs

-- [
--   {
--     "skills": "pyspark",
--     "average_salary": "208172"
--   },
--   {
--     "skills": "bitbucket",
--     "average_salary": "189155"
--   },
--   {
--     "skills": "couchbase",
--     "average_salary": "160515"
--   },
--   {
--     "skills": "watson",
--     "average_salary": "160515"
--   },
--   {
--     "skills": "datarobot",
--     "average_salary": "155486"
--   },
--   {
--     "skills": "gitlab",
--     "average_salary": "154500"
--   },
--   {
--     "skills": "swift",
--     "average_salary": "153750"
--   },
--   {
--     "skills": "jupyter",
--     "average_salary": "152777"
--   },
--   {
--     "skills": "pandas",
--     "average_salary": "151821"
--   },
--   {
--     "skills": "elasticsearch",
--     "average_salary": "145000"
--   },
--   {
--     "skills": "golang",
--     "average_salary": "145000"
--   },
--   {
--     "skills": "numpy",
--     "average_salary": "143513"
--   },
--   {
--     "skills": "databricks",
--     "average_salary": "141907"
--   },
--   {
--     "skills": "linux",
--     "average_salary": "136508"
--   },
--   {
--     "skills": "kubernetes",
--     "average_salary": "132500"
--   },
--   {
--     "skills": "atlassian",
--     "average_salary": "131162"
--   },
--   {
--     "skills": "twilio",
--     "average_salary": "127000"
--   },
--   {
--     "skills": "airflow",
--     "average_salary": "126103"
--   },
--   {
--     "skills": "scikit-learn",
--     "average_salary": "125781"
--   },
--   {
--     "skills": "jenkins",
--     "average_salary": "125436"
--   },
--   {
--     "skills": "notion",
--     "average_salary": "125000"
--   },
--   {
--     "skills": "scala",
--     "average_salary": "124903"
--   },
--   {
--     "skills": "postgresql",
--     "average_salary": "123879"
--   },
--   {
--     "skills": "gcp",
--     "average_salary": "122500"
--   },
--   {
--     "skills": "microstrategy",
--     "average_salary": "121619"
--   }
-- ]

-- Based on the top paying skills for data analysts, here are some insights into current trends:

-- 1. **Big Data Technologies**: Skills like **PySpark**, **Databricks**, and **Elasticsearch** are among the highest paying. This reflects the growing demand for professionals who can manage and analyze large volumes of data efficiently.

-- 2. **Cloud Computing**: Technologies such as **GCP** (Google Cloud Platform) and **Kubernetes** indicate a significant shift towards cloud-based data solutions. Companies are investing in these platforms for scalability and performance.

-- 3. **Programming and Scripting**: Languages like **Python** (e.g., **Pandas**, **NumPy**, **Jupyter**) and **Scala** are highly valued, emphasizing the importance of strong programming skills in data analysis roles.

-- 4. **DevOps and Version Control**: Tools like **GitLab**, **Bitbucket**, and **Jenkins** suggest a need for data analysts who are proficient in DevOps practices and version control, essential for collaboration and reproducibility.

-- 5. **Machine Learning and AI**: Skills such as **Scikit-learn** and **Watson** (IBM's AI platform) highlight the integration of machine learning and AI into data analysis workflows, showing continued growth in AI-driven insights.

-- 6. **Database Management**: **PostgreSQL** remains crucial, indicating ongoing reliance on traditional relational databases alongside newer technologies.

-- 7. **Workflow Automation**: Tools like **Airflow** and **Notion** reflect a push towards automating data workflows and improving project management efficiency.

-- These trends underscore the diverse and evolving skill set required for data analysts, combining technical proficiency with the ability to leverage advanced tools and platforms effectively.