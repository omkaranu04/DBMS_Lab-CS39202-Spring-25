INSERT INTO beneficiaries (citizen_id, scheme_id, enrollment_date)
SELECT 
    c.citizen_id,
    1 AS scheme_id,
    CURRENT_DATE AS enrollment_date
FROM citizens c
WHERE c.edu_level = '10th'
LIMIT 10;

INSERT INTO beneficiaries (citizen_id, scheme_id, enrollment_date)
SELECT 
    c.citizen_id,
    ws.scheme_id,
    CURRENT_DATE AS enrollment_date
FROM citizens c
JOIN welfare_schemes ws ON ws.scheme_id <> 1
ORDER BY RANDOM()
LIMIT 20;
update beneficiaries set enrollment_date = '2024-01-24' where scheme_id = 1;