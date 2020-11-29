package requester;

import java.sql.*;

public class Requester
{
    public static void totalDownloads(Connection conn, String analyzer) throws SQLException
    {
        String query = "SELECT AVG(price) FROM errors WHERE analyzer_name = ?";
        int sum = 0;

        try
        {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, analyzer);
            ResultSet res = pstmt.executeQuery();

            if (res.next())
            {
                sum = res.getInt(1);
            }
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        System.out.format("Average error fix fee for the %s is: %d\n", analyzer, sum);
    }

    public static void analyzersWithCweStatus(Connection conn, String status)
    {
        String query = "SELECT name, price, AnalyzersID.id "
                + "FROM analyzers JOIN ( "
                + "     SELECT analyzer_name, id "
                + "     FROM errors JOIN ( "
                + "         SELECT cwe_id FROM cwe WHERE status = ? "
                + "     ) StatusID ON StatusID.cwe_id = errors.cwe_id "
                + " ) AnalyzersID ON AnalyzersID.analyzer_name = analyzers.name "
                + "ORDER BY AnalyzersID.id";

        try
        {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, status);

            ResultSet res = pstmt.executeQuery();
            System.out.format("Information about analyzers, which fire errors with %s status:\n", status);

            while (res.next())
            {
                System.out.format(
                        "Name: %s | price: %d | CWE-ID: %d\n",
                        res.getString(1),
                        res.getInt(2),
                        res.getInt(3)
                );
            }
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static  void errorsInfo(Connection conn, String analyzer)
    {
        String query = "WITH ErrorsInfo(description, danger_level, AvgPrice)\n" +
                "AS (\n" +
                "    SELECT description, danger_level, AVG(price) OVER(PARTITION BY danger_level)\n" +
                "    FROM errors\n" +
                "    WHERE analyzer_name = ?\n" +
                ") \n" +
                "SELECT * FROM ErrorsInfo";

        try
        {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, analyzer);
            ResultSet res = pstmt.executeQuery();

            while (res.next())
            {
                System.out.format(
                        "Error description: %s | Danger level: %d | Average price by danger level: %d\n",
                        res.getString(1),
                        res.getInt(2),
                        res.getInt(3)
                );
            }
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static void userTables(Connection conn, String username) throws SQLException
    {
        String query = "SELECT table_name FROM all_tables WHERE owner = ?";

        try
        {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);

            ResultSet res = pstmt.executeQuery();
            System.out.format("List of all %s tables:\n", username);

            while (res.next())
            {
                System.out.println(res.getString(1));
            }
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static void sumErrors(Connection conn, String analyzer) throws SQLException
    {
        String query = "{? = call SumErrors(?)}";
        int sum = 0;

        try
        {
            CallableStatement cstmt = conn.prepareCall(query);
            cstmt.registerOutParameter(1, Types.INTEGER);
            cstmt.setString(2, analyzer);
            cstmt.executeUpdate();
            sum = cstmt.getInt(1);
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        System.out.format("Amount of payment for fixing all errors of the %s analyzer: %d\n", analyzer, sum);
    }

    public static void analyzerErrorsInfo(Connection conn, String analyzer) throws SQLException
    {
        String query = "SELECT * FROM TABLE(AnalyzerErrorsInfo(?))";

        try
        {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, analyzer);

            ResultSet res = pstmt.executeQuery();
            System.out.format("Information about %s errors:\n", analyzer);

            while (res.next())
            {
                System.out.format(
                        "Error description: %s | Danger level: %d | Price: %d\n",
                        res.getString(1),
                        res.getInt(2), res.getInt(3)
                );
            }
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static void updatePrice(Connection conn, String analyzer, int increasePrice)
    {
        String query = "{call UpdatePrice(?, ?)}";

        try
        {
            CallableStatement cstmt = conn.prepareCall(query);
            cstmt.setString(1, analyzer);
            cstmt.setInt(2, increasePrice);
            cstmt.executeUpdate();
            System.out.format("Price for fixing all the %s analyzer errors has been increase by %d.\n", analyzer, increasePrice);
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static void currentYear(Connection conn)
    {
        String query = "{? = call TO_NUMBER(EXTRACT(year FROM SYSDATE))}";
        int year = 0;

        try
        {
            CallableStatement cstmt = conn.prepareCall(query);
            cstmt.registerOutParameter(1, Types.INTEGER);
            cstmt.executeUpdate();
            year = cstmt.getInt(1);
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        System.out.format("Current year is: %d.\n", year);
    }

    public static void createTable(Connection conn)
    {
        String query = "CREATE TABLE fixers("
                + "id INT PRIMARY KEY, "
                + "accuracy INT CHECK(accuracy BETWEEN 1 AND 5), "
                + "rapidity INT CHECK(rapidity BETWEEN 1 AND 10))";
        try
        {
            Statement stmt = conn.createStatement();
            stmt.execute(query);
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static void insertToTable(Connection conn, int id, int accuracy, int rapidity)
    {
        String query = "INSERT INTO fixers (id, accuracy, rapidity) VALUES (?, ?, ?)";

        try
        {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.setInt(2, accuracy);
            pstmt.setInt(3, rapidity);
            pstmt.execute();
        }
        catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }
}