import psycopg2
# python is so easy : )
# Database configuration
# DB_CONFIG = {
#     'dbname': 'omkar',
#     'user': 'omkar',
#     'password': 'tans',
#     'host': 'localhost',
#     'port': '5432'
# }
DB_CONFIG = {
    'dbname': '22CS30016',
    'user': '22CS30016',
    'password': 'tans',
    'host': '10.5.18.72',
    'port': '5432'
}

# Queries
QUERIES = {
    "A": "SELECT c.name FROM citizens c JOIN assets a ON c.citizen_id = a.citizen_owner_id JOIN lands l ON a.asset_id = l.asset_id WHERE l.area_in_acres > 1;",
    "B": "SELECT c.name FROM citizens c JOIN households h ON c.house_no = h.house_no WHERE c.gender = 'Female' AND (c.edu_level = '10th' OR c.edu_level = '12th') AND h.total_income < 100000;",
    "C": "SELECT SUM(l.area_in_acres) AS total_acres_rice FROM lands l WHERE l.crop_type = 'Rice';",
    "D": "SELECT COUNT(*) FROM citizens c WHERE c.dob > '2000-01-01' AND c.edu_level = '10th';",
    "E": "SELECT c.name FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id JOIN assets a ON c.citizen_id = a.citizen_owner_id JOIN lands l ON a.asset_id = l.asset_id WHERE l.area_in_acres > 1;",
    "F": "SELECT c.name FROM citizens c WHERE c.house_no = (SELECT c.house_no FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id WHERE pm.designation = 'Pradhan') AND c.citizen_id NOT IN (SELECT pm.citizen_id FROM panchayat_members pm WHERE pm.designation = 'Pradhan');",
    "G": "SELECT SUM(a.value) AS total_value FROM assets a WHERE a.type = 'Street Light' AND a.location = 'Phulera' AND EXTRACT(YEAR FROM a.date_of_acquisition) = 2024;",
    "H": "SELECT COUNT(DISTINCT c.citizen_id) FROM beneficiaries b JOIN citizens c ON b.citizen_id = c.citizen_id JOIN welfare_schemes ws ON b.scheme_id = ws.scheme_id JOIN citizens p ON c.parent_id = p.citizen_id WHERE ws.scheme_type = 'Vaccination' AND EXTRACT(YEAR FROM b.enrollment_date) = 2024 AND p.edu_level = '10th';",
    "I": "SELECT COUNT(*) FROM citizens c WHERE c.gender = 'Male' AND EXTRACT(YEAR FROM c.dob) = 2024;",
    "J": "SELECT SUM(h.total_members) FROM households h WHERE h.house_no IN (SELECT DISTINCT c.house_no FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id);"
}

# Connect to the database and execute queries
def execute_queries():
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                for label, query in QUERIES.items():
                    print(f"Executing Query {label}:")
                    cursor.execute(query)
                    result = cursor.fetchall()
                    for row in result:
                        print(row)
                    print("\n")
    except Exception as e:
        print("Error:", e)

if __name__ == '__main__':
    execute_queries()