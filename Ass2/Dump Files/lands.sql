INSERT INTO lands (asset_id, soil_type, crop_type, area_in_acres, revenue)
SELECT 
    generate_series(44, 73) AS asset_id,
    (ARRAY['Red', 'Black', 'Mixed', 'Sandy', 'Coarse'])[FLOOR(RANDOM() * 5) + 1] AS soil_type,
    (ARRAY['Rice', 'Wheat', 'Cotton', 'Barley', 'Maize', 'Soybean', 'Sugarcane'])[FLOOR(RANDOM() * 7) + 1] AS crop_type,
    FLOOR(RANDOM() * 10) + 1 AS area_in_acres,
    FLOOR(RANDOM() * (500000 - 10000 + 1)) + 10000 AS revenue
LIMIT 30;