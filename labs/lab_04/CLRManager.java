import java.sql.*;
import java.util.*;
import oracle.sql.*;
import java.io.*;


public class CLRManager 
{
    static int ROWCNT = 254;
    static int LOWCOST = 10000;
    static int AVGCOST = 100000;

    public static int SumErrors(String analyzerName) throws SQLException
    {
        String request = "SELECT SUM(price) FROM errors WHERE analyzerName = ?";
        int sum = -1;

        try
        {
            Connection conn = DriverManager.getConnection("jdbc:default:connection:");
            PreparedStatement pstmt = conn.prepareStatement(request);
            pstmt.setString(1, analyzerName);

            ResultSet res = pstmt.executeQuery();
            res.next();
            sum = res.getInt(1);
        } catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        return sum;
    }

    public static int AnalyzerPrice(String analyzerName) throws SQLException
    {
        String request = "SELECT price FROM analyzers WHERE name = ?";
        int price = -1;

        try
        {
            Connection conn = DriverManager.getConnection("jdbc:default:connection:");
            PreparedStatement pstmt = conn.prepareStatement(request);
            pstmt.setString(1, analyzerName);

            ResultSet res = pstmt.executeQuery();
            res.next();
            price = res.getInt(1);
        } catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        return price;
    }

    public static int TotalSum(String analyzerName) throws SQLException
    {
        return SumErrors(analyzerName) + AnalyzerPrice(analyzerName);
    }

    public static void UpdatePrice(String analyzerName, int increasePrice)
    {
        String request = "UPDATE errors SET price = price + ? WHERE analyzer_name = ?";

        try
        {
            Connection conn = DriverManager.getConnection("jdbc:default:connection:");
            PreparedStatement pstmt = conn.prepareStatement(request);

            pstmt.setInt(1, increasePrice);
            pstmt.setString(2, analyzerName);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    public static void AuditTrigger(String event)
    {
        String request = "INSERT INTO db_audit VALUES (?, SYSDATE, TO_CHAR(SYSDATE, 'HH24:MM:SS'))";

        try
        {
            Connection conn = DriverManager.getConnection("jdbc:default:connection:");
            PreparedStatement pstmt = conn.prepareStatement(request);

            pstmt.setString(1, event);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }
    }

    private static int getFlexCoeff(int dangerLevel, int price)
    {
        if (dangerLevel < 4)
        {
            if (price < LOWCOST)
            {
                return price + dangerLevel * 130 + 1500;
            } 
            else if (price < AVGCOST)
            {
                return price + dangerLevel * 75 + 1200;
            }
            
            return price + dangerLevel * 145 + 1400;
        } 
        else if (dangerLevel < 7)
        {
            if (price < LOWCOST)
            {
                return price + dangerLevel * 90;
            } 
            else if (price < AVGCOST)
            {
                return price + dangerLevel * 125;
            }

            return price + 148 * dangerLevel + 240;
        }

        if (price < LOWCOST)
        {
            return price - dangerLevel * 140 - 1500;
        } 
        else if ( price < AVGCOST)
        {
            return price - dangerLevel * 120 + 77;
        }

        return price - dangerLevel * 100 + 86;
    }

    public static ARRAY AnalyzerErrorsInfo(String analyzerName) throws SQLException
    {
        String request = "SELECT danger_level, price FROM errors WHERE analyzer_name = ?";
        Connection conn = null;
        String table[][] = new String[ROWCNT][3];

        try
        {
            conn = DriverManager.getConnection("jdbc:default:connection:");
            PreparedStatement pstmt = conn.prepareStatement(request);

            pstmt.setString(1, analyzerName);
            ResultSet res = pstmt.executeQuery();

            int i = 0;
            while (res.next())
            {
                int dangerLevel = res.getInt(1);
                int price = res.getInt(2);

                table[i][0] = Integer.toString(dangerLevel);
                table[i][1] = Integer.toString(price);
                table[i++][2] = Integer.toString(getFlexCoeff(dangerLevel, price));
            }

        } catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor("ERRORS_TABLE", conn);

        return new ARRAY(descriptor, conn, table);
    }

    public static STRUCT MinAnalyzerInfo(String analyzerName) throws SQLException
    {
        String request = "SELECT name, price FROM analyzers WHERE name = ?";
        Connection conn = null;
        Object[] obj = new Object[3];

        try
        {
            conn = DriverManager.getConnection("jdbc:default:connection:");
            PreparedStatement pstmt = conn.prepareStatement(request);

            pstmt.setString(1, analyzerName);
            ResultSet res = pstmt.executeQuery();

            if (res.next())
            {
                obj[0] = res.getString(1);
                obj[1] = Integer.toString(res.getInt(2));
                obj[2] = Integer.toString(SumErrors(analyzerName));

                //attr.put("A1", "123");
                //attr.put("price", "456");
                //attr.put("sum_errors_price", "789");
                //obj.put("analyzer_name", name);
                //obj.put("price", Integer.toString(price));
                //obj.put("sum_errors_price", Integer.toString(SumErrors(analyzerName)));
                //obj.put("sum_errors_price", "AYO");
            }

        } catch (SQLException err)
        {
            System.err.println(err.getMessage());
        }

        StructDescriptor descriptor = StructDescriptor.createDescriptor("MINANALYZERINFO_", conn);

        return new STRUCT(descriptor, conn, obj);
    }
}
