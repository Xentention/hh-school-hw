-- соискателей чаще всего сразу интересует работа
-- только по их специальности и в их регионе
CREATE INDEX vacancies_position_and_area_index
    ON vacancies (position_name, area_id);

--  работодатели тоже хотят видеть подходящих кандидатов
CREATE INDEX candidates_position_and_area_index
    ON candidates (specialization_id, area_id);