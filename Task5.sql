SELECT v.vacancy_id, v.position_name
FROM vacancies AS v JOIN responses AS r USING (vacancy_id)
WHERE (r.creation_time - v.creation_time) <= INTERVAL '1 week'
GROUP BY v.vacancy_id, v.position_name
HAVING count(*) > 5;