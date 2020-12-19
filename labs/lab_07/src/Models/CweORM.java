package Models;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "cwe")
public class CweORM {

    public static final String CWEID_FIELD_NAME = "cwe_id";
    public static final String NAME_FIELD_NAME = "name";
    public static final String WEAKNESSABSTRACTION_FIELD_NAME = "weakness_abstraction";
    public static final String STATUS_FIELD_NAME = "status";
    public static final String DESCRIPTION_FIELD_NAME = "description";

    @DatabaseField(columnName = CWEID_FIELD_NAME)
    private int cweId;

    @DatabaseField(columnName = NAME_FIELD_NAME)
    private String name;

    @DatabaseField(columnName = WEAKNESSABSTRACTION_FIELD_NAME)
    private String weaknessAbstraction;

    @DatabaseField(columnName = STATUS_FIELD_NAME)
    private String status;

    @DatabaseField(columnName = DESCRIPTION_FIELD_NAME)
    private String description;

    public CweORM() {

    }

    public CweORM(int cweId, String name, String weaknessAbstraction, String status, String description) {
        this.cweId = cweId;
        this.name = name;
        this.weaknessAbstraction = weaknessAbstraction;
        this.status = status;
        this.description = description;
    }

    public void setCweId(int id) {
        this.cweId = id;
    }

    public int getCweId() {
        return this.cweId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setWeaknessAbstraction(String weaknessAbstraction) {
        this.weaknessAbstraction = weaknessAbstraction;
    }

    public String getWeaknessabstraction() {
        return this.weaknessAbstraction;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }

    public String getDescription() {
        return this.getDescription();
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public int hashCode() {
        return String.valueOf(this.cweId).hashCode();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || o.getClass() != getClass()) {
            return false;
        }

        int obj_id = ((ErrorORM) o).getCweId();
        return String.valueOf(this.cweId).equals(String.valueOf(obj_id));
    }

    @Override
    public String toString() {
        return String.format(
                "Cwe ID: %d | Name: %s | Weakness Abstraction: %s | Status: %s | Description: %s",
                this.cweId, this.name, this.weaknessAbstraction, this.status, this.description);
    }
}
