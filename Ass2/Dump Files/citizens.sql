CREATE OR REPLACE FUNCTION generate_phone_number() 
RETURNS VARCHAR(10) AS $$
BEGIN
    RETURN LPAD(FLOOR(RANDOM() * 9000000000 + 1000000000)::TEXT, 10, '0');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_aadhar_number() 
RETURNS VARCHAR(12) AS $$
BEGIN
    RETURN LPAD(FLOOR(RANDOM() * 900000000000 + 100000000000)::TEXT, 12, '0');
END;
$$ LANGUAGE plpgsql;

INSERT INTO citizens (
    citizen_id, name, gender, dob, house_no, phone, aadhar_no, edu_level
)
WITH family_distribution AS (
    SELECT 
        generate_series(100, 199) AS citizen_id,
        (ARRAY['Raghav', 'Priya', 'Amit', 'Neha', 'Sanjay', 'Divya', 
               'Rahul', 'Anita', 'Vikram', 'Kavita', 'Rajesh', 'Meera', 
               'Suresh', 'Anjali', 'Karthik', 'Deepa'])[FLOOR(RANDOM() * 16 + 1)] || ' ' ||
        (ARRAY['Singh', 'Sharma', 'Patel', 'Kumar', 'Gupta', 'Verma', 
               'Reddy', 'Mehta', 'Agarwal', 'Naidu'])[FLOOR(RANDOM() * 10 + 1)] AS name,
        (ARRAY['Male', 'Female'])[FLOOR(RANDOM() * 2 + 1)] AS gender,
        DATE '1960-01-01' + (FLOOR(RANDOM() * (DATE '2005-01-01' - DATE '1960-01-01')) * INTERVAL '1 day') AS dob,
        FLOOR(RANDOM() * 50 + 10)::INT AS house_no,
        (ARRAY['Illiterate', 'Primary', 'Secondary', '10th', '12th', 'Graduate', 'Post-Graduate'])[FLOOR(RANDOM() * 7 + 1)] AS edu_level
)
SELECT 
    citizen_id,
    name,
    gender,
    dob,
    house_no,
    generate_phone_number(),
    generate_aadhar_number(),
    edu_level
FROM (
    SELECT 
        *, 
        ROW_NUMBER() OVER (PARTITION BY house_no ORDER BY RANDOM()) AS family_member_order
    FROM family_distribution
) subquery
WHERE family_member_order <= 6;

update citizens set dob = '2024-11-27' where citizen_id in (131,143, 109, 169,113);
update citizens set dob = '2024-04-07' where citizen_id in (127, 177, 161, 109);
