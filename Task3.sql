SELECT round(AVG(compensation_from), 3) * (CASE WHEN compensation_gross THEN 0.87 ELSE 1 END) AS compensation_from,
       round(AVG(compensation_to), 3) * (CASE WHEN compensation_gross THEN 0.87 ELSE 1 END) AS compensation_to,
       round(AVG((compensation_to + compensation_from) / 2), 3)
           * (CASE WHEN compensation_gross THEN 0.87 ELSE 1 END) AS среднее_арифметическое_from_и_to,
       area_id
FROM vacancies
GROUP BY area_id, compensation_gross
ORDER BY area_id;