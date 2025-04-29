#include <iostream>
#include <vector>
#include <cstring>
#include <sql.h>
#include <sqlext.h>
using namespace std;

void executeQueries()
{
    SQLHENV hEnv;
    SQLHDBC hDbc;
    SQLHSTMT hStmt;
    SQLRETURN ret;

    SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv);
    SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (void *)SQL_OV_ODBC3, 0);
    SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);

    // Update with your database connection details
    // SQLCHAR connStr[] = "DRIVER={PostgreSQL Unicode};DATABASE=omkar;SERVER=localhost;PORT=5432;UID=omkar;PWD=tans;";
    SQLCHAR connStr[] = "DRIVER={PostgreSQL Unicode};DATABASE=22CS30016;SERVER=10.5.18.72;PORT=5432;UID=22CS30016;PWD=tans;";
    ret = SQLDriverConnect(hDbc, NULL, connStr, SQL_NTS, NULL, 0, NULL, SQL_DRIVER_COMPLETE);

    if (SQL_SUCCEEDED(ret))
    {
        // after successful connection
        cout << "Connected to the database successfully." << endl
             << "Executing queries..." << endl;

        // store the queries
        vector<string> queries = {
            // Query A
            "SELECT c.name FROM citizens c JOIN assets a ON c.citizen_id = a.citizen_owner_id JOIN lands l ON a.asset_id = l.asset_id WHERE l.area_in_acres > 1;",
            // Query B
            "SELECT c.name FROM citizens c JOIN households h ON c.house_no = h.house_no WHERE c.gender = 'Female' AND (c.edu_level = '10th' OR c.edu_level = '12th') AND h.total_income < 100000;",
            // Query C
            "SELECT SUM(l.area_in_acres) AS total_acres_rice FROM lands l WHERE l.crop_type = 'Rice';",
            // Query D
            "SELECT COUNT(*) FROM citizens c WHERE c.dob > '2000-01-01' AND c.edu_level = '10th';",
            // Query E
            "SELECT c.name FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id JOIN assets a ON c.citizen_id = a.citizen_owner_id JOIN lands l ON a.asset_id = l.asset_id WHERE l.area_in_acres > 1;",
            // Query F
            "SELECT c.name FROM citizens c WHERE c.house_no = (SELECT h.house_no FROM households h JOIN citizens p ON h.house_no = p.house_no JOIN panchayat_members pm ON p.citizen_id = pm.citizen_id WHERE pm.designation = 'Pradhan') AND c.citizen_id NOT IN (SELECT pm.citizen_id FROM panchayat_members pm WHERE pm.designation = 'Pradhan');",
            // Query G
            "SELECT SUM(a.value) AS total_value FROM assets a WHERE a.type = 'Street Light' AND a.location = 'Phulera' AND EXTRACT(YEAR FROM a.date_of_acquisition) = 2024;",
            // Query H
            "SELECT COUNT(DISTINCT c.citizen_id) FROM beneficiaries b JOIN citizens c ON b.citizen_id = c.citizen_id JOIN welfare_schemes ws ON b.scheme_id = ws.scheme_id JOIN citizens p ON c.parent_id = p.citizen_id WHERE ws.scheme_type = 'Vaccination' AND EXTRACT(YEAR FROM b.enrollment_date) = 2024 AND p.edu_level = '10th';",
            // Query I
            "SELECT COUNT(*) FROM citizens c WHERE c.gender = 'Male' AND EXTRACT(YEAR FROM c.dob) = 2024;",
            // Query J
            "SELECT SUM(h.total_members) FROM households h WHERE h.house_no IN (SELECT DISTINCT c.house_no FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id);"};

        char x = 'A';
        for (const auto &query : queries)
        {
            // allocate statement handle for this query
            SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);
            // execute the query
            ret = SQLExecDirect(hStmt, (SQLCHAR *)query.c_str(), SQL_NTS);

            if (SQL_SUCCEEDED(ret))
            {
                cout << "Query: " << x++ << endl;
                SQLCHAR columnData[500];
                while (SQLFetch(hStmt) == SQL_SUCCESS)
                {
                    SQLGetData(hStmt, 1, SQL_C_CHAR, columnData, sizeof(columnData), NULL);
                    cout << columnData << endl;
                }
                cout << endl;
            }
            else
            {
                printf("Error in Query %c\n", x++);
            }
            SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
        }
    }
    else
    {
        printf("Error in connection\n");
    }
    // free the resources
    SQLDisconnect(hDbc);
    SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
    SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
}

int main()
{
    executeQueries();
    return 0;
}
