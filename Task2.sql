WITH test_data (specialization_id, specialization_name) AS (
	SELECT generate_series(1, 100) AS specialization_id,
		md5(random()::TEXT) AS specialization_name)
INSERT INTO specializations(specialization_id, specialization_name)
SELECT specialization_id, specialization_name
FROM test_data;

WITH test_data (area_id, area_name) AS (
	SELECT generate_series(1, 50) AS area_id,
		md5(random()::TEXT) AS area_name)
INSERT INTO areas(area_id, area_name)
SELECT area_id, area_name
FROM test_data;

WITH test_data (employer_id, employer_name, area_id) AS (
	SELECT generate_series(1, 1000) AS employer_id,
		md5(random()::TEXT) AS employer_name,
		random() * ((SELECT count(*) FROM areas) - 1) + 1 AS area_id)
INSERT INTO employers(employer_id, employer_name, area_id)
SELECT employer_id, employer_name, area_id
FROM test_data;

WITH test_data (skill_id, skill_name) AS (
	SELECT generate_series(1, 100) AS skill_id,
		md5(random()::TEXT) AS skill_name)
INSERT INTO skills(skill_id, skill_name)
SELECT skill_id, skill_name
FROM test_data;

WITH test_data (vacancy_id, employer_id, position_name,
		compensation_from, compensation_gross,
		area_id, creation_time) AS (
	SELECT generate_series(1, 10000) AS vacancy_id,
		random() * ((SELECT count(*) FROM employers) - 1) + 1 AS employer_id,
		md5(random()::TEXT) AS position_name,
		random() * 500000 + 20000 AS compensation_from,
		random() > 0.5 AS compensation_gross,
		random() * ((SELECT count(*) FROM areas) - 1) + 1 AS area_id,
        TIMESTAMPTZ '2018-10-20 10:00:00' + random() * (TIMESTAMPTZ '2018-10-20 10:00:00' - TIMESTAMPTZ '2023-12-20 10:00:00') AS creation_time
)
INSERT INTO vacancies(vacancy_id, employer_id, position_name,
			compensation_from, compensation_to, compensation_gross,
			area_id, creation_time)
SELECT vacancy_id, employer_id, position_name,
	compensation_from, compensation_from + 30000, compensation_gross,
	area_id, creation_time
FROM test_data;

WITH test_data (candidate_id, surname, first_name, patronymic,
		specialization_id, area_id) AS (
	SELECT generate_series(1, 90000) AS candidate_id,
		md5(random()::TEXT) AS surname,
		md5(random()::TEXT) AS first_name,
		md5(random()::TEXT) AS patronymic,
		random() * ((SELECT count(*) FROM specializations) - 1) + 1 AS specialization_id,
		random() * ((SELECT count(*) FROM areas) - 1) + 1 AS area_id)
INSERT INTO candidates(candidate_id, surname, first_name, patronymic,
			specialization_id, area_id)
SELECT candidate_id, surname, first_name, patronymic,
	specialization_id, area_id
FROM test_data;

WITH test_data (resume_id, candidate_id, description, area_id,
		specialization_id, creation_time) AS (
	SELECT generate_series(1, 100000) AS resume_id,
		random() * ((SELECT count(*) FROM candidates) - 1) + 1 AS candidate_id,
		md5(random()::TEXT) AS description,
		random() * ((SELECT count(*) FROM areas) - 1) + 1 AS area_id,
		random() * ((SELECT count(*) FROM specializations) - 1) + 1 AS specialization_id,
        TIMESTAMPTZ '2018-10-20 10:00:00' + random() * (TIMESTAMPTZ '2018-10-20 10:00:00' - TIMESTAMPTZ '2023-12-20 10:00:00') AS creation_time)
INSERT INTO resumes(resume_id, candidate_id, description, area_id,
			specialization_id, creation_time)
SELECT resume_id, candidate_id, description, area_id,
	specialization_id, creation_time
FROM test_data;

WITH test_data (response_id, candidate_id, resume_id, vacancy_id,
		creation_time, is_accepted) AS (
	SELECT generate_series(1, 200000) AS response_id,
		random() * ((SELECT count(*) FROM candidates) - 1) + 1 AS candidate_id,
		random() * ((SELECT count(*) FROM resumes) - 1) + 1 AS resume_id,
		random() * ((SELECT count(*) FROM vacancies) - 1) + 1 AS vacancy_id,
        TIMESTAMPTZ '2018-10-20 10:00:00' + random() * (TIMESTAMPTZ '2018-10-20 10:00:00' - TIMESTAMPTZ '2023-12-20 10:00:00') AS creation_time,
		random() > 0.5 AS is_accepted)
INSERT INTO responses(response_id, candidate_id, resume_id, vacancy_id,
			creation_time, is_accepted)
SELECT response_id, candidate_id, resume_id, vacancy_id,
	creation_time, is_accepted
FROM test_data;