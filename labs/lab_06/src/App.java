import java.sql.*;
import java.util.*;

import requester.Requester;

public class App
{
    static String menu[] = {
            "1. Scalar query.",
            "2. Multiple join query",
            "3. TODO",
            "4. Querying metadata.",
            "5. Function call.",
            "6. Table function call.",
            "7. Stored function call.",
            "8. TODO: System stored function call.",
            "9. Create new table.",
            "10. Insert into new table.",
            "11. Exit."
    };

    static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws Exception, SQLException
    {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        //Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.1.1:1539:xe", "alexey", "admin");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@0.0.0.0:1521:defects", "alexey", "admin");
        run(conn);
    }

    static void printMenu()
    {
        for (String paragraph: menu)
        {
            System.out.println(paragraph);
        }
    }

    static void chooseAction(Connection conn) throws SQLException
    {
        System.out.print("Choose action: ");
        int action = scanner.nextInt();

        while (action > 11 || action < 1)
        {
            System.out.print("Invalid input. Enter action again: ");
            action = scanner.nextInt();
        }

        switch (action)
        {
            case 1:
                Requester.totalDownloads(conn, "clang-tidy");
                break;
            case 2:
                Requester.analyzersWithCweStatus(conn, "Stable");
                break;
            case 3:
                break;
            case 4:
                Requester.userTables(conn, "ALEXEY");
                break;
            case 5:
                Requester.sumErrors(conn, "clang-tidy");
                break;
            case 6:
                Requester.analyzerErrorsInfo(conn, "clang-tidy");
                break;
            case 7:
                Requester.updatePrice(conn, "clang-tidy", 100);
                break;
            case 8:
                break;
            case 9:
                Requester.createTable(conn);
                break;
            case 10:
                Requester.insertToTable(conn, 2, 5, 5);
                break;
            default:
                conn.close();
                scanner.close();
                System.exit(0);
        }
    }

    public static void run(Connection conn) throws SQLException
    {
        printMenu();
        chooseAction(conn);
        run(conn);
    }

}
