INSERT INTO surveys (survey_id, panchayat_id, department, area)
SELECT 
    c.survey_id,
    1 AS panchayat_id,
    'Population' AS department,
    'whole village' AS area
FROM census c;

INSERT INTO surveys (survey_id, panchayat_id, department, area)
SELECT 
    e.survey_id,
    1 AS panchayat_id,
    e.parameter_name AS department,
    'whole village' AS area
FROM environment e;