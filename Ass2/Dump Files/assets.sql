WITH 
house_assets AS (
    SELECT 
        h.asset_id,
        (SELECT citizen_id 
         FROM citizens 
         WHERE house_no = h.house_no 
         LIMIT 1) AS owner_id,
        'House' AS type,
        DATE '1990-01-01' + (RANDOM() * (DATE '2020-12-31' - DATE '1990-01-01'))::INTEGER AS date_of_acquisition,
        FLOOR(RANDOM() * 300000 + 100000) AS value,
        h.address AS location
    FROM households h
),
land_assets AS (
    SELECT 
        l.asset_id,
        c.citizen_id AS owner_id,
        'Agricultural Land' AS type,
        DATE '1990-01-01' + (RANDOM() * (DATE '2020-12-31' - DATE '1990-01-01'))::INTEGER AS date_of_acquisition,
        l.revenue AS value,
        CONCAT(l.soil_type, ' ', l.crop_type, ' Land') AS location
    FROM (
        SELECT l.*, ROW_NUMBER() OVER () AS rn
        FROM lands l
    ) l
    JOIN (
        SELECT citizen_id, ROW_NUMBER() OVER () AS rn
        FROM citizens
    ) c
    ON l.rn = c.rn
)
INSERT INTO assets (asset_id, owner_id, type, date_of_acquisition, value, location)
SELECT * FROM house_assets
UNION ALL
SELECT * FROM land_assets;


INSERT INTO assets (asset_id, owner_id, type, date_of_acquisition, value, location)
VALUES 
    (74, 1, 'Street Lights', '2015-03-15', 15, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (75, 1, 'Community Hall', '2010-11-20', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (76, 1, 'Public Handpump', '2012-06-10', 3, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (77, 1, 'Primary School Building', '2008-04-01', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (78, 1, 'Waiting Shed', '2016-09-05', 2, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (79, 1, 'Public Toilet', '2017-12-12', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (80, 1, 'Water Storage Tank', '2013-08-25', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (81, 1, 'Playground', '2011-02-14', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (82, 1, 'Cremation Ground', '2009-07-30', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (83, 1, 'Public Library', '2014-01-22', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (84, 1, 'Solar Streetlamps', '2018-11-05', 5, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (85, 1, 'Public Computer Center', '2016-05-17', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (86, 1, 'Ambulance', '2012-10-03', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (87, 1, 'Public Dispensary', '2011-06-22', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]),
    (88, 1, 'Community Kitchen', '2019-04-08', 1, (ARRAY['Phulera', 'Nadives', 'Hall Road', 'Parishad', 'Vindhyachal'])[FLOOR(RANDOM() * 5 + 1)]);
insert into assets (asset_id, owner_id, type, date_of_acquisition, value, location) values (89, 1, 'Street Lights', '2024-03-17', 18, 'Phulera');