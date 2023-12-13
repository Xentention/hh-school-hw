WITH vacancies_per_months AS (
    SELECT date_trunc('month', creation_time) AS month,
    count(*) AS count_vacancies
    FROM vacancies
    GROUP BY (date_trunc('month', creation_time))
    ORDER BY count_vacancies
    DESC
    LIMIT 1),
resumes_per_months AS (
    SELECT date_trunc('month', creation_time) AS month,
    count(*) AS count_resumes
    FROM resumes
    GROUP BY (date_trunc('month', creation_time))
    ORDER BY count_resumes
    LIMIT 1)
SELECT count_vacancies, count_resumes
FROM vacancies_per_months AS v, resumes_per_months as r;

