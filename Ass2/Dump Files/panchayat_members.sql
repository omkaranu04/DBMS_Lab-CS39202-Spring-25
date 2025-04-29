INSERT INTO panchayat_members (citizen_id, panchayat_id, designation, tenure_start, tenure_end, duties)
SELECT 
    citizen_id,
    1 AS panchayat_id,
    designation,
    CURRENT_DATE AS tenure_start,
    CURRENT_DATE + INTERVAL '5 years' AS tenure_end,
    CASE 
        WHEN designation = 'Sarpanch' THEN 'Lead the panchayat and oversee all activities.'
        WHEN designation = 'Panchayat Member' THEN 'Participate in panchayat meetings and decision-making.'
        WHEN designation = 'Secretary' THEN 'Maintain records and documentation for the panchayat.'
        WHEN designation = 'Treasurer' THEN 'Manage the finances and budget of the panchayat.'
        WHEN designation = 'Village Development Officer' THEN 'Plan and implement development projects in the village.'
        WHEN designation = 'Health Officer' THEN 'Oversee health initiatives and programs in the community.'
        WHEN designation = 'Education Officer' THEN 'Promote and manage educational programs and initiatives.'
        WHEN designation = 'Agriculture Officer' THEN 'Support and promote agricultural practices and initiatives.'
    END AS duties
FROM (
    SELECT 
        c.citizen_id,
        (ARRAY['Sarpanch', 'Panchayat Member', 'Secretary', 'Treasurer', 'Village Development Officer', 'Health Officer', 'Education Officer', 'Agriculture Officer'])[FLOOR(RANDOM() * 8) + 1] AS designation
    FROM citizens c
    WHERE FLOOR(EXTRACT(YEAR FROM AGE(c.dob)) + 0.5) >= 30
) AS subquery
LIMIT 10;

INSERT INTO panchayat_members (citizen_id, panchayat_id, designation, tenure_start, tenure_end, duties)
VALUES (154, 1, 'Panchayat Pradhan', '2025-01-23', '2030-01-23', 'Lead the panchayat and oversee all activities.');