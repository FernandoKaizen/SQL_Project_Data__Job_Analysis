# Introduction

Dive into the data job market! Focusing on data analyst roles, this project explores: top-paying jobs, in-demand skills, and where high demand meets high salary in data anlystics.

SQL queries? Check them out here: [project_sql_folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining other work to find optimal jobs.

### The questions I wantes to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Wich skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market. I harnessed the power of several key tools:

- **SQL:** - The back bone of my analysis, allowing me to query the datavase and unearth critical insights.
- **PostgreSQL:** - The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs, this query highlights the high paying opportunities in the field.

```sql
SELECT  
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles spam from $184,000 top $650,000, indicating significant salary potential in the fied.
- **Diverse Employers:** Companies like AmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** Threre's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\1_top_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; Chatgpt fenerated this graph from sql query results*

### 2. Skills for top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the trol 10 highest paying data analyst jobs in 2023:

- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also gighly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excle show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts
 
 This query helped indentify the skills most frequently requested in job postings, directing focus to areas with high demand.

 ```sql
 SELECT
    skills, 
    COUNT(sjd.job_id) as demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here's the breakdown of the most demanded skills for data analysts in 2023.

![In demand skills](assets\3.png)

*Table of the demand for the top 5 skills in data analyst job postings*

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and Visualization Tools like **Python**, **Tableau**, and **Power** **BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

### 4. Skills based on salary

Exploring the average salaries associated with different skills revealed wich skills are the highest paying.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary 
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
```

Here's a breakdown of the results for top paying skills for Data Analysts:

- **Big Data Technologies**: Skills like **PySpark**, **Databricks**, and **Elasticsearch** are among the highest paying. This reflects the growing demand for professionals who can manage and analyze large volumes of data efficiently.

- **Cloud Computing**: Technologies such as **GCP** (Google Cloud Platform) and **Kubernetes** indicate a significant shift towards cloud-based data solutions. Companies are investing in these platforms for scalability and performance.

- **Programming and Scripting**: Languages like **Python** (e.g., **Pandas**, **NumPy**, **Jupyter**) and **Scala** are highly valued, emphasizing the importance of strong programming skills in data analysis roles.

- **DevOps and Version Control**: Tools like **GitLab**, **Bitbucket**, and **Jenkins** suggest a need for data analysts who are proficient in DevOps practices and version control, essential for collaboration and reproducibility.

- **Machine Learning and AI**: Skills such as **Scikit-learn** and **Watson** (IBM's AI platform) highlight the integration of machine learning and AI into data analysis workflows, showing continued growth in AI-driven insights.

- **Database Management**: **PostgreSQL** remains crucial, indicating ongoing reliance on traditional relational databases alongside newer technologies.

- **Workflow Automation**: Tools like **Airflow** and **Notion** reflect a push towards automating data workflows and improving project management efficiency.

These trends underscore the diverse and evolving skill set required for data analysts, combining technical proficiency with the ability to leverage advanced tools and platforms effectively.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high slaries, offering a strategic focus for skill development.

```sql
WITH skills_demand AS (
SELECT
    sd.skill_id,
    sd.skills, 
    COUNT(sjd.job_id) as demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    sd.skill_id 
), average_salary AS(
SELECT
    sjd.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS average_salary 
FROM
    job_postings_fact jpf 
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id 
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    sjd.skill_id 
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id 
WHERE demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25;
```

Rewriting this same query more concisely
```sql
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
```
![optimal Skills](assets\5_Optimal_skills.png)

The tech market highly values specialized skills in cloud computing, big data, versatile programming languages like Python and R, and project management tools, offering competitive salaries and significant demand for these competencies.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables Like a pro and wielding WITH clauses for high-level temp tables.
- **Data Aggregation:** Got cozy with Group BY and turned aggregate functions like COUNT() AND AVG() into data-summarizing sidekicks.
- **Analytical Wizard:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insighful SQL queries.

# Conclusions

### Closing thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market, The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysis can better position themselves in a competitive job market by focusing on high demand, high salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the filed of data analytics.