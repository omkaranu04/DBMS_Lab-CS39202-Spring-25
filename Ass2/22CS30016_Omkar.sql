/* 
    PLEASE NOTE THAT THE DATA FILLED IS RANDOM AND DOES NOT REPRESENT ANY REAL WORLD SCENARIO
    THE DATA HENCE IS SEVERLY INCONSISTENT AND DOES NOT FOLLOW ANY REAL WORLD SCENARIO
*/

-- ---------------------- TABLE CREATION ----------------------
-- table for citizens
CREATE TABLE citizens(
    citizen_id INT PRIMARY KEY, 
    name VARCHAR(500), 
    gender VARCHAR(10), 
    dob DATE, 
    house_no INT, 
    phone CHARACTER VARYING(10) UNIQUE CHECK (phone ~ '^\d{10}$'), 
    aadhar_no CHARACTER VARYING(12) UNIQUE CHECK (aadhar_no ~ '^\d{12}$'), 
    edu_level VARCHAR(100),
    parent_id INT
);
ALTER TABLE citizens
ADD CONSTRAINT fk_parent_id
FOREIGN KEY (parent_id) REFERENCES citizens(citizen_id)
ON DELETE SET NULL;

-- table for households
CREATE TABLE households(
    house_no INT PRIMARY KEY, 
    asset_id INT, 
    address VARCHAR(500), 
    total_members INT, 
    total_income INT
);

-- table for lands
CREATE TABLE lands (
    asset_id INT PRIMARY KEY, 
    soil_type VARCHAR(100), 
    crop_type VARCHAR(100), 
    area_in_acres INT, 
    revenue INT
);

-- table for assets
CREATE TABLE assets(
    asset_id INT PRIMARY KEY, 
    panchayat_owner_id INT,
    citizen_owner_id INT, 
    type VARCHAR(100), 
    date_of_acquisition DATE, 
    value INT, 
    location VARCHAR(500)
);

-- table for welfare_schemes
CREATE TABLE welfare_schemes (
    scheme_id INT PRIMARY KEY, 
    scheme_type VARCHAR(100), 
    budget INT, 
    description VARCHAR(500)
);

-- table for beneficiaries
CREATE TABLE beneficiaries (
    citizen_id INT, 
    scheme_id INT, 
    enrollment_date DATE,
    PRIMARY KEY (citizen_id, scheme_id)
);

-- table for panchayat_members
CREATE TABLE panchayat_members(
    citizen_id INT, 
    panchayat_id INT, 
    designation VARCHAR(50), 
    tenure_start DATE, 
    tenure_end DATE, 
    duties VARCHAR(500),
    PRIMARY KEY (citizen_id, panchayat_id)
);

-- table for panchayats
CREATE TABLE panchayats(
    panchayat_id INT PRIMARY KEY, 
    name VARCHAR(100) UNIQUE
);

-- table for surveys
CREATE TABLE surveys(
    survey_id INT PRIMARY KEY, 
    panchayat_id INT, 
    department VARCHAR(100), 
    area VARCHAR(100)
);

-- table for census
CREATE TABLE census(
    survey_id INT, 
    population INT, 
    no_of_households INT, 
    literacy_rate NUMERIC(5, 2), 
    employment_rate NUMERIC(5,2)
);

-- table for environment
CREATE TABLE environment(
    survey_id INT, 
    parameter_name VARCHAR(100), 
    value NUMERIC, 
    last_recorded DATE,
    PRIMARY KEY (survey_id, parameter_name)
);

-- ---------------------- MAKE NECESSARY ALTERATIONS ----------------------
ALTER TABLE assets
ADD CONSTRAINT fk_assets_panchayat_owner_id FOREIGN KEY (panchayat_owner_id) REFERENCES panchayats(panchayat_id),
ADD CONSTRAINT fk_assets_citizen_owner_id FOREIGN KEY (citizen_owner_id) REFERENCES citizens(citizen_id),
ADD CONSTRAINT check_owner_constraint CHECK (
    (citizen_owner_id IS NOT NULL AND panchayat_owner_id IS NULL) OR
    (citizen_owner_id IS NULL AND panchayat_owner_id IS NOT NULL)
);

ALTER TABLE households
ADD CONSTRAINT fk_households_asset_id FOREIGN KEY (asset_id) REFERENCES assets(asset_id);

ALTER TABLE lands
ADD CONSTRAINT fk_lands_asset_id FOREIGN KEY (asset_id) REFERENCES assets(asset_id);

ALTER TABLE citizens
ADD CONSTRAINT fk_citizens_house_no FOREIGN KEY (house_no) REFERENCES households(house_no);

ALTER TABLE beneficiaries
ADD CONSTRAINT fk_beneficiaries_citizen_id FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id),
ADD CONSTRAINT fk_beneficiaries_scheme_id FOREIGN KEY (scheme_id) REFERENCES welfare_schemes(scheme_id);

ALTER TABLE panchayat_members
ADD CONSTRAINT fk_panchayat_members_citizen_id FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id),
ADD CONSTRAINT fk_panchayat_members_panchayat_id FOREIGN KEY (panchayat_id) REFERENCES panchayats(panchayat_id);

ALTER TABLE surveys
ADD CONSTRAINT fk_surveys_panchayat_id FOREIGN KEY (panchayat_id) REFERENCES panchayats(panchayat_id);

ALTER TABLE census
ADD CONSTRAINT fk_census_survey_id FOREIGN KEY (survey_id) REFERENCES surveys(survey_id);

ALTER TABLE environment
ADD CONSTRAINT fk_environment_survey_id FOREIGN KEY (survey_id) REFERENCES surveys(survey_id);

-- ---------------------- POPULATING TABLES ----------------------
INSERT INTO panchayats (panchayat_id, name) VALUES
(1, 'Miraj');

INSERT INTO assets (asset_id, panchayat_owner_id, citizen_owner_id, type, date_of_acquisition, value, location) VALUES
(1, 1, NULL, 'House', '2010-06-25', 500000, 'Miraj Village'),
(2, 1, NULL, 'House', '2012-03-20', 400000, 'Miraj Village'),
(3, 1, NULL, 'House', '2015-04-15', 600000, 'Miraj Village'),
(4, 1, NULL, 'House', '2018-08-10', 700000, 'Miraj Village'),
(5, 1, NULL, 'House', '2020-01-30', 200000, 'Miraj Village'),
(6, 1, NULL, 'House', '2021-02-20', 250000, 'Miraj Village'),
(7, 1, NULL, 'House', '2016-09-15', 350000, 'Miraj Village'),
(8, 1, NULL, 'House', '2017-07-12', 550000, 'Miraj Village'),
(9, 1, NULL, 'House', '2019-11-25', 600000, 'Miraj Village'),
(10, 1, NULL, 'House', '2022-01-17', 450000, 'Miraj Village'),
(11, 1, NULL, 'House', '2024-02-12', 500000, 'Phulera'),
(12, 1, NULL, 'House', '2010-06-25', 500000, 'Miraj Village'),
(13, 1, NULL, 'Land', '2010-06-25', 500000, 'Miraj Village'),
(14, 1, NULL, 'Land', '2012-03-20', 400000, 'Miraj Village'),
(15, 1, NULL, 'Land', '2015-04-15', 600000, 'Miraj Village'),
(16, 1, NULL, 'Land', '2018-08-10', 700000, 'Miraj Village'),
(17, 1, NULL, 'Land', '2020-01-30', 200000, 'Miraj Village'),
(18, 1, NULL, 'Land', '2021-02-20', 250000, 'Miraj Village'),
(19, 1, NULL, 'Land', '2016-09-15', 350000, 'Miraj Village'),
(20, 1, NULL, 'Land', '2017-07-12', 550000, 'Miraj Village'),
(21, 1, NULL, 'Land', '2019-11-25', 600000, 'Miraj Village'),
(22, 1, NULL, 'Land', '2022-01-17', 450000, 'Miraj Village'),
(23, 1, NULL, 'Street Light', '2024-02-12', 20000, 'Phulera');


INSERT INTO households (house_no, asset_id, address, total_members, total_income) VALUES
(101, 1, 'Miraj Village, House 101', 4, 500000), 
(102, 2, 'Miraj Village, House 102', 3, 700000), 
(103, 3, 'Miraj Village, House 103', 3, 800000), 
(104, 4, 'Miraj Village, House 104', 3, 1200000),
(105, 5, 'Miraj Village, House 105', 2, 900000), 
(106, 6, 'Miraj Village, House 106', 2, 80000),  
(107, 7, 'Miraj Village, House 107', 2, 95000),  
(108, 8, 'Miraj Village, House 108', 2, 85000),  
(109, 9, 'Miraj Village, House 109', 4, 500000), 
(110, 10, 'Miraj Village, House 110', 4, 600000),
(111, 11, 'Miraj Village, House 111', 4, 450000),
(112, 12, 'Miraj Village, House 112', 3, 350000);

INSERT INTO lands (asset_id, soil_type, crop_type, area_in_acres, revenue) VALUES
(13, 'Clay', 'Rice', 1.5, 100000),
(14, 'Sandy', 'Wheat', 2.0, 120000),
(15, 'Loamy', 'Rice', 2.5, 150000),
(16, 'Clay', 'Rice', 3.0, 200000),
(17, 'Sandy', 'Rice', 1.0, 75000),
(18, 'Loamy', 'Rice', 1.5, 100000),
(19, 'Clay', 'Rice', 1.8, 130000),
(20, 'Loamy', 'Wheat', 2.0, 110000),
(21, 'Sandy', 'Rice', 1.2, 90000),
(22, 'Clay', 'Rice', 2.5, 160000);

INSERT INTO citizens (citizen_id, name, gender, dob, house_no, phone, aadhar_no, edu_level) VALUES
(1, 'Panchayat Pradhan 1', 'Male', '1985-04-12', 101, '9876543210', '123456789012', '12th'),
(2, 'Panchayat Pradhan 2', 'Female', '1990-02-18', 101, '9123456789', '123456789013', '10th'),
(3, 'Panchayat Member 1', 'Male', '1978-11-03', 102, '9876543234', '123456789014', 'Graduation'),
(4, 'Panchayat Member 2', 'Female', '1982-06-15', 103, '9823456789', '123456789015', 'Graduation'),
(5, 'Panchayat Member 3', 'Male', '1995-01-20', 104, '9456781230', '123456789016', '10th'),
(6, 'Panchayat Member 4', 'Female', '1992-07-10', 105, '9222334455', '123456789017', '12th'),
(7, 'Student Girl 1', 'Female', '2005-03-22', 106, '9900112233', '123456789018', '10th'),
(8, 'Student Girl 2', 'Female', '2006-05-11', 107, '9933445566', '123456789019', '12th'),
(9, 'Student Girl 3', 'Female', '2004-08-17', 108, '9112233445', '123456789020', '12th'),
(10, 'Citizen 1', 'Male', '2001-11-12', 109, '9500112233', '123456789021', '10th'),
(11, 'Citizen 2', 'Female', '1999-02-05', 110, '9111223344', '123456789022', '12th'),
(12, 'Citizen 3', 'Male', '2002-06-25', 111, '9333445566', '123456789023', '10th'),
(13, 'Citizen 4', 'Male', '1998-09-14', 112, '9778992233', '123456789024', '10th'),
(14, 'Boy Child 1', 'Male', '2024-01-01', 101, '9773332233', '123456789025', 'Pre-School'),
(15, 'Boy Child 2', 'Male', '2024-01-01', 101, '9733332233', '123456789026', 'Pre-School');

UPDATE citizens SET parent_id = 2 WHERE citizen_id = 1;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 3;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 4;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 5;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 6;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 7;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 8;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 9;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 10;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 11;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 12;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 13;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 14;
UPDATE citizens SET parent_id = 2 WHERE citizen_id = 15;

UPDATE assets SET citizen_owner_id = 1, panchayat_owner_id = NULL WHERE asset_id = 1;
UPDATE assets SET citizen_owner_id = 3, panchayat_owner_id = NULL WHERE asset_id = 2;
UPDATE assets SET citizen_owner_id = 4, panchayat_owner_id = NULL WHERE asset_id = 3;
UPDATE assets SET citizen_owner_id = 5, panchayat_owner_id = NULL WHERE asset_id = 4;
UPDATE assets SET citizen_owner_id = 6, panchayat_owner_id = NULL WHERE asset_id = 5;
UPDATE assets SET citizen_owner_id = 7, panchayat_owner_id = NULL WHERE asset_id = 6;
UPDATE assets SET citizen_owner_id = 8, panchayat_owner_id = NULL WHERE asset_id = 7;
UPDATE assets SET citizen_owner_id = 9, panchayat_owner_id = NULL WHERE asset_id = 8;
UPDATE assets SET citizen_owner_id = 10, panchayat_owner_id = NULL WHERE asset_id = 9;
UPDATE assets SET citizen_owner_id = 11, panchayat_owner_id = NULL WHERE asset_id = 10;
UPDATE assets SET citizen_owner_id = 12, panchayat_owner_id = NULL WHERE asset_id = 11;
UPDATE assets SET citizen_owner_id = 13, panchayat_owner_id = NULL WHERE asset_id = 12;
UPDATE assets SET citizen_owner_id = 1, panchayat_owner_id = NULL WHERE asset_id = 13;
UPDATE assets SET citizen_owner_id = 3, panchayat_owner_id = NULL WHERE asset_id = 14;
UPDATE assets SET citizen_owner_id = 4, panchayat_owner_id = NULL WHERE asset_id = 15;
UPDATE assets SET citizen_owner_id = 5, panchayat_owner_id = NULL WHERE asset_id = 16;
UPDATE assets SET citizen_owner_id = 6, panchayat_owner_id = NULL WHERE asset_id = 17;
UPDATE assets SET citizen_owner_id = 7, panchayat_owner_id = NULL WHERE asset_id = 18;
UPDATE assets SET citizen_owner_id = 8, panchayat_owner_id = NULL WHERE asset_id = 19;
UPDATE assets SET citizen_owner_id = 9, panchayat_owner_id = NULL WHERE asset_id = 20;
UPDATE assets SET citizen_owner_id = 10, panchayat_owner_id = NULL WHERE asset_id = 21;
UPDATE assets SET citizen_owner_id = 11, panchayat_owner_id = NULL WHERE asset_id = 22;

INSERT INTO welfare_schemes (scheme_id, scheme_type, budget, description) VALUES
(1, 'Vaccination', 500000, 'Vaccination program for children under 10th education level'),
(2, 'Financial Aid', 2000000, 'Financial aid for students pursuing 10th or higher education');

INSERT INTO beneficiaries (citizen_id, scheme_id, enrollment_date) VALUES
(7, 1, '2024-05-10'), 
(8, 1, '2024-05-15'), 
(9, 1, '2024-05-20'); 

INSERT INTO panchayat_members (citizen_id, panchayat_id, designation, tenure_start, tenure_end, duties) VALUES
(1, 1, 'Pradhan', '2020-01-01', '2025-12-31', 'Overall administration of the panchayat'),
(2, 1, 'Member', '2022-01-01', '2027-12-31', 'Work on community welfare'),
(3, 1, 'Member', '2021-01-01', '2026-12-31', 'Work on agriculture and land development'),
(4, 1, 'Member', '2023-01-01', '2028-12-31', 'Work on education and social welfare');

INSERT INTO surveys (survey_id, panchayat_id, department, area) VALUES
(1, 1, 'Agriculture', 'Miraj Village'),
(2, 1, 'Environment', 'Miraj Village');

INSERT INTO census (survey_id, population, no_of_households, literacy_rate, employment_rate) VALUES
(1, 1500, 400, 85.0, 75.5),
(2, 1500, 400, 85.0, 77.0);

INSERT INTO environment (survey_id, parameter_name, value, last_recorded) VALUES
(2, 'Air Quality', 75.5, '2024-12-31'),
(2, 'Water Quality', 80.0, '2024-12-31');

-- ---------------------- QUERIES ----------------------

-- A. Show names of all citizens who holds more than 1 acre of land
SELECT c.name
FROM citizens c
JOIN assets a ON c.citizen_id = a.citizen_owner_id
JOIN lands l ON a.asset_id = l.asset_id
WHERE l.area_in_acres > 1;

-- B. Show name of all girls who study in school with household income less than 1 Lakh per year
SELECT c.name
FROM citizens c
JOIN households h ON c.house_no = h.house_no
WHERE c.gender = 'Female'
  AND (c.edu_level = '10th' OR c.edu_level = '12th')
  AND h.total_income < 100000;

-- C. How many acres of land cultivate rice
SELECT SUM(l.area_in_acres) AS total_acres_rice
FROM lands l
WHERE l.crop_type = 'Rice';

-- D. Number of citizens who are born after 1.1.2000 and have educational qualification of 10th class
SELECT COUNT(*)
FROM citizens c
WHERE c.dob > '2000-01-01' AND c.edu_level = '10th';

-- E. Name of all employees of panchayat who also hold more than 1 acre land
SELECT c.name
FROM citizens c
JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id
JOIN assets a ON c.citizen_id = a.citizen_owner_id
JOIN lands l ON a.asset_id = l.asset_id
WHERE l.area_in_acres > 1;

-- F. Name of the household members of Panchayat Pradhan
SELECT h.total_members
FROM households h
JOIN citizens c ON c.house_no = h.house_no
JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id
WHERE pm.designation = 'Pradhan';

-- G. Total number of street light assets installed in a particular locality named Phulera that are installed in 2024
SELECT SUM(a.value) AS total_value
FROM assets a
WHERE a.type = 'Street Light'
  AND a.location = 'Phulera'
  AND EXTRACT(YEAR FROM a.date_of_acquisition) = 2024;

-- H. Number of vaccinations done in 2024 for the children of citizens whose educational qualification is class 10
SELECT COUNT(DISTINCT c.citizen_id)
FROM beneficiaries b
JOIN citizens c ON b.citizen_id = c.citizen_id
JOIN welfare_schemes ws ON b.scheme_id = ws.scheme_id
JOIN citizens p ON c.parent_id = p.citizen_id
WHERE ws.scheme_type = 'Vaccination'
  AND EXTRACT(YEAR FROM b.enrollment_date) = 2024
  AND p.edu_level = '10th';

-- I. Total number of births of boy child in the year 2024
SELECT COUNT(*)
FROM citizens c
WHERE c.gender = 'Male' AND EXTRACT(YEAR FROM c.dob) = 2024;

-- J. Number of citizens who belong to the household of at least one panchayat employee.
SELECT SUM(h.total_members)
FROM households h
WHERE h.house_no IN (
    SELECT DISTINCT c.house_no
    FROM citizens c
    JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id
);
