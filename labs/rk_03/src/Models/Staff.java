package Models;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

import java.util.Date;

@DatabaseTable(tableName = "staff")
public class Staff {

    public static final String ID_FIELD_NAME = "id";
    public static final String EMPLOYEENAME_FIELD_NAME = "employee_name";
    public static final String BIRTHDAY_FIELD_NAME = "birthday";
    public static final String DEPARTMENT_FIELD_NAME = "department";

    @DatabaseField(columnName = ID_FIELD_NAME)
    private int id;

    @DatabaseField(columnName = EMPLOYEENAME_FIELD_NAME)
    private String employeeName;

    @DatabaseField(columnName = BIRTHDAY_FIELD_NAME, dataType = DataType.DATE_STRING, format = "YYYY-MM-DD")
    private Date birthday;

    @DatabaseField(columnName = DEPARTMENT_FIELD_NAME)
    private String department;

    public Staff() {

    }

    public Staff(int id, String employee, Date birthday, String department) {
        this.id = id;
        this.employeeName = employee;
        this.birthday = birthday;
        this.department = department;
    }
}
