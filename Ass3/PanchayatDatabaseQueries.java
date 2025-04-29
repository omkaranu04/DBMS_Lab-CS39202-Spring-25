// import all java classes related to SQL
import java.sql.*;

// main class
public class PanchayatDatabaseQueries {
    // all the database connection details, 5432 is the default port for PostgreSQL
    // private static final String URL = "jdbc:postgresql://localhost:5432/omkar";
    // private static final String USER = "omkar";
    // private static final String PASSWORD = "tans";

    private static final String URL = "jdbc:postgresql://10.5.18.72:5432/22CS30016";
    private static final String USER = "22CS30016";
    private static final String PASSWORD = "tans";


    // main method, for connecting to the database and executing queries
    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            executeQueries(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // public static void main(String[] args) {
    //     try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
    //         System.out.println("Connected to the database!");
    //         Statement stmt = conn.createStatement();
    //         ResultSet rs = stmt.executeQuery("SELECT * FROM assets"); // Example query
    //         while (rs.next()) {
    //             System.out.println("Data: " + rs.getString(1));
    //         }
    //     } catch (Exception e) {
    //         e.printStackTrace();
    //     }
    // }

    // all queries stated here
    private static void executeQueries(Connection conn) throws SQLException {
        String queryA = "SELECT c.name FROM citizens c JOIN assets a ON c.citizen_id = a.citizen_owner_id JOIN lands l ON a.asset_id = l.asset_id WHERE l.area_in_acres > 1;";
        executeAndPrintQuery(conn, queryA, "Query A:");

        String queryB = "SELECT c.name FROM citizens c JOIN households h ON c.house_no = h.house_no WHERE c.gender = 'Female' AND (c.edu_level = '10th' OR c.edu_level = '12th') AND h.total_income < 100000;";
        executeAndPrintQuery(conn, queryB, "Query B:");

        String queryC = "SELECT SUM(l.area_in_acres) AS total_acres_rice FROM lands l WHERE l.crop_type = 'Rice';";
        executeAndPrintQuery(conn, queryC, "Query C:");

        String queryD = "SELECT COUNT(*) FROM citizens c WHERE c.dob > '2000-01-01' AND c.edu_level = '10th';";
        executeAndPrintQuery(conn, queryD, "Query D:");

        String queryE = "SELECT c.name FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id JOIN assets a ON c.citizen_id = a.citizen_owner_id JOIN lands l ON a.asset_id = l.asset_id WHERE l.area_in_acres > 1;";
        executeAndPrintQuery(conn, queryE, "Query E:");

        String queryF = "SELECT c.name FROM citizens c WHERE c.house_no = (SELECT h.house_no FROM households h JOIN citizens c ON c.house_no = h.house_no JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id WHERE pm.designation = 'Pradhan') AND c.citizen_id NOT IN (SELECT pm.citizen_id FROM panchayat_members pm WHERE pm.designation = 'Pradhan');";
        executeAndPrintQuery(conn, queryF, "Query F:");

        String queryG = "SELECT SUM(a.value) AS total_value FROM assets a WHERE a.type = 'Street Light' AND a.location = 'Phulera' AND EXTRACT(YEAR FROM a.date_of_acquisition) = 2024;";
        executeAndPrintQuery(conn, queryG, "Query G:");

        String queryH = "SELECT COUNT(DISTINCT c.citizen_id) FROM beneficiaries b JOIN citizens c ON b.citizen_id = c.citizen_id JOIN welfare_schemes ws ON b.scheme_id = ws.scheme_id JOIN citizens p ON c.parent_id = p.citizen_id WHERE ws.scheme_type = 'Vaccination' AND EXTRACT(YEAR FROM b.enrollment_date) = 2024 AND p.edu_level = '10th';";
        executeAndPrintQuery(conn, queryH, "Query H:");

        String queryI = "SELECT COUNT(*) FROM citizens c WHERE c.gender = 'Male' AND EXTRACT(YEAR FROM c.dob) = 2024;";
        executeAndPrintQuery(conn, queryI, "Query I:");

        String queryJ = "SELECT SUM(h.total_members) FROM households h WHERE h.house_no IN (SELECT DISTINCT c.house_no FROM citizens c JOIN panchayat_members pm ON c.citizen_id = pm.citizen_id);";
        executeAndPrintQuery(conn, queryJ, "Query J:");
    }

    // method to execute the query and print the result
    private static void executeAndPrintQuery(Connection conn, String query, String label) throws SQLException {
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            System.out.println(label);
            while (rs.next()) {
                for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                    System.out.print(rs.getString(i) + "\t");
                }
                System.out.println();
            }
            System.out.println();
        }
    }
}