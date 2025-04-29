INSERT INTO environment (survey_id, parameter_name, value, last_recorded)
SELECT 
    generate_series(1, 10) AS survey_id,
    (ARRAY['Air Quality', 'Water Quality', 'Soil Quality', 'Noise Level', 'Temperature', 
            'Humidity', 'Carbon Dioxide', 'Ozone Level', 'Particulate Matter', 'UV Index'])[FLOOR(RANDOM() * 10) + 1] AS parameter_name,
    ROUND((RANDOM() * 100)::numeric, 2) AS value,
    CURRENT_DATE - (FLOOR(RANDOM() * 30) + 1) * INTERVAL '1 day' AS last_recorded
LIMIT 10;