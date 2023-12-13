DROP TABLE IF EXISTS responses;
DROP TABLE IF EXISTS resumes;
DROP TABLE IF EXISTS candidates;
DROP TABLE IF EXISTS vacancies;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS employers;
DROP TABLE IF EXISTS areas;
DROP TABLE IF EXISTS specializations;

CREATE TABLE specializations (
	specialization_id SERIAL PRIMARY KEY,
	specialization_name VARCHAR NOT NULL
);

CREATE TABLE areas (
	area_id SERIAL PRIMARY KEY,
	area_name VARCHAR NOT NULL
);

CREATE TABLE employers (
	employer_id SERIAL PRIMARY KEY,
	employer_name VARCHAR NOT NULL,
	area_id INTEGER NOT NULL REFERENCES areas (area_id)
);

CREATE TABLE skills (
	skill_id SERIAL PRIMARY KEY,
	skill_name VARCHAR NOT NULL
);

CREATE TABLE vacancies (
	vacancy_id SERIAL PRIMARY KEY,
	employer_id INTEGER NOT NULL REFERENCES employers (employer_id),
	position_name VARCHAR NOT NULL,
	compensation_from INTEGER,
	compensation_to INTEGER,
	compensation_gross BOOLEAN,
	area_id INTEGER NOT NULL REFERENCES areas (area_id),
	creation_time TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE candidates (
	candidate_id SERIAL PRIMARY KEY,
	surname VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	patronymic VARCHAR,
	specialization_id INTEGER NOT NULL REFERENCES specializations (specialization_id),
	area_id integer NOT NULL REFERENCES areas (area_id)
);

CREATE TABLE resumes (
	resume_id SERIAL PRIMARY KEY,
	candidate_id INTEGER NOT NULL REFERENCES candidates (candidate_id),
	description VARCHAR NOT NULL,
	area_id INTEGER NOT NULL REFERENCES areas (area_id),
	specialization_id INTEGER NOT NULL REFERENCES specializations (specialization_id),
	creation_time TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE responses (
	response_id SERIAL PRIMARY KEY,
	candidate_id INTEGER NOT NULL REFERENCES candidates (candidate_id),
	resume_id INTEGER NOT NULL REFERENCES resumes (resume_id),
	vacancy_id INTEGER NOT NULL REFERENCES vacancies (vacancy_id),
	creation_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	is_accepted BOOLEAN
);
	