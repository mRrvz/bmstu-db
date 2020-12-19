import java.sql.*;
import java.util.*;

import Linq.Requester;
import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.support.ConnectionSource;

public class Main {

    private final static String DATABASE_URL = "jdbc:oracle:thin:@0.0.0.0:1521:defects";
    private final static String USER = "alexey";
    private final static String PASS = "admin";

    public static void main(String[] args) throws Exception, SQLException {
        //Class.forName("oracle.jdbc.driver.OracleDriver");
        //Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.1.1:1539:xe", "alexey", "admin");
        Connection conn = DriverManager.getConnection(DATABASE_URL, USER, PASS);

        Requester.linqToObject(conn);
        Requester.linqToJson(conn);

        conn.close();
        ConnectionSource connectionSource = new JdbcConnectionSource(DATABASE_URL, USER, PASS);

        Requester.linqToSql(connectionSource);
    }
}
