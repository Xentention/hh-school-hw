SELECT round(AVG(compensation_from), 3) AS compensation_from,
       round(AVG(compensation_to), 3) AS compensation_to,
       round(AVG((compensation_to + compensation_from) / 2), 3) AS среднее_арифметическое_from_и_to,
       area_id
FROM vacancies
GROUP BY area_id
ORDER BY area_id;