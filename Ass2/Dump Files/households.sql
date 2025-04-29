WITH asset_ids AS (
    SELECT asset_id
    FROM generate_series(1, 200) AS asset_id
    ORDER BY RANDOM()
),
house_members AS (
    SELECT 
        house_no, 
        COUNT(*) AS total_members
    FROM citizens
    GROUP BY house_no
),
numbered_households AS (
    SELECT 
        hm.house_no, 
        hm.total_members,
        ROW_NUMBER() OVER (ORDER BY hm.house_no) AS rn
    FROM house_members hm
),
numbered_assets AS (
    SELECT 
        ai.asset_id,
        ROW_NUMBER() OVER (ORDER BY ai.asset_id) AS rn
    FROM asset_ids ai
)
INSERT INTO households (house_no, asset_id, address, total_members, total_income)
SELECT 
    nh.house_no, 
    na.asset_id, 
    CONCAT(
        (ARRAY['Green', 'Oak', 'Maple', 'Cedar', 'Pine', 'Elm', 'Willow'])[FLOOR(RANDOM() * 7 + 1)], 
        ' Street, Block ', 
        FLOOR(RANDOM() * 50 + 1)::TEXT
    ) AS address,
    nh.total_members, 
    FLOOR(RANDOM() * 950000 + 50000) AS total_income
FROM numbered_households nh
JOIN numbered_assets na ON nh.rn = na.rn;

UPDATE households
SET total_income = FLOOR(RANDOM() * (100000 - 50000 + 1) + 50000)
WHERE house_no IN (11, 28, 29, 36, 34);

UPDATE households                                                     
SET total_income = FLOOR(RANDOM() * (100000 - 50000 + 1) + 50000)
WHERE house_no IN (20, 37, 47, 50);