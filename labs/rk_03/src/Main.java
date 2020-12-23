import java.sql.*;
import java.util.*;

import Models.AuditEmployee;
import Models.Staff;
import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.dao.GenericRawResults;
import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.stmt.query.In;
import com.j256.ormlite.support.ConnectionSource;


class Requester {

    static private Dao<Staff, Integer> staffDao;
    static private Dao<AuditEmployee, Integer> auditDao;

    public static void getLatecomers(Connection conn, String today, int lateTime) throws SQLException {
        String workBegin = today + " 09:00";
        String query = "SELECT staff.id, employee_name, birthday, department FROM (" +
                "   SELECT * FROM " +
                "   staff JOIN staff_audit ON staff.id = staff_audit.id " +
                "   WHERE audit_type = 1 AND day_date = to_date(?, 'YYYY-MM-DD')" +
                ") WHERE ((time_w - to_date(?, 'YYYY-MM-DD hh24:mi')) * 24 * 60) > (?)";

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, today);
            pstmt.setString(2, workBegin);
            pstmt.setInt(3, lateTime);
            ResultSet res = pstmt.executeQuery();

            while (res.next()) {
                // тут надо просто добавить принты но я не успеваю!
            }

        } catch (SQLException err) {
            System.err.println(err.getMessage());
        }
    }

    public static void getLeftMoreThan(Connection conn, String today, int diff) throws SQLException {
        String query = "";

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);

        } catch (SQLException err) {
            System.err.println(err.getMessage());
        }
    }

    // в ormlite (потому что lite) нет нормальных джойнов поэтому только raw
    public static void getAccountantsORM(ConnectionSource connectionSource) throws SQLException {
        staffDao = DaoManager.createDao(connectionSource, Staff.class);
        auditDao = DaoManager.createDao(connectionSource, AuditEmployee.class);

        GenericRawResults<Object[]> rawResults =
                staffDao.queryRaw("SELECT time, type, department, staff.id, employee_name, birthday" +
                        "FROM staff JOIN staff_audit ON staff.id = staff.audit_id");
                        //"WHERE time < to_date('08:00', 'hh24:mi') AND type = 1 AND department = ACCOUNTANT

        for (Object[] obj: rawResults) {
            if (obj[0] < 8 && obj[1] == 1 && obj[2] == "ACCOUNTANT") {
                // напечатать staff[3], staff[4], staff[5], времени нет!
            }
        }
    }

    public static void getAccountants(Connection conn) throws SQLException {
        String query = "SELECT staff.id, employee_name, birthday" +
                "FROM staff JOIN staff_audit ON staff.id = staff.audit_id" +
                "WHERE time < to_date('08:00', 'hh24:mi') AND type = 1 AND department = ACCOUNTANT"; // бухгалтера

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet res = pstmt.executeQuery();

            while (res.next()) {
                // тут надо просто добавить принты но я не успеваю!
            }
        } catch (SQLException err) {
            System.err.println(err.getMessage());
        }
    }
}

public class Main {

    private final static String DATABASE_URL = "jdbc:oracle:thin:@0.0.0.0:1521:defects";
    private final static String USER = "alexey";
    private final static String PASS = "admin";

    public static void main(String[] args) throws Exception
    {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(DATABASE_URL, USER, PASS);
        Requester.getLatecomers(conn, "2020-12-19", 5);
        Requester.getAccountants(conn);

        conn.close();

        ConnectionSource connectionSource = new JdbcConnectionSource(DATABASE_URL, USER, PASS);
        Requester.getAccountantsORM(connectionSource);

    }
}
