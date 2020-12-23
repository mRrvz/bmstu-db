package Models;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

import java.util.Date;
// нужно добавить анотацию полей как в staff классе, но у меня нет времени
@DatabaseTable(tableName = "staff_audit")
public class AuditEmployee {
    private int id;

    private int idEmployee;

    private Date dayDate;

    private String dayOfWeek;

    private Date timeW;

    private int auditType;

    public AuditEmployee() {

    }

    public AuditEmployee(int id, int idEmployee, Date dayDate, String dayOfWeek, Date timeW, int auditType) {
        this.id = id;
        this.idEmployee = idEmployee;
        this.dayDate = dayDate;
        this.dayOfWeek = dayOfWeek;
        this.timeW = timeW;
        this.auditType = auditType;
    }
}
