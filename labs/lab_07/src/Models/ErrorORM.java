package Models;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "errors")
public class ErrorORM {

    public static final String ID_FIELD_NAME = "id";
    public static final String CWEID_FIELD_NAME = "cwe_id";
    public static final String DESCRIPTION_FIELD_NAME = "description";
    public static final String ANALYZERNAME_FIELD_NAME = "analyzer_name";
    public static final String PERCENTAGE_FIELD_NAME = "percentage";
    public static final String DANGERLEVEL_FIELD_NAME = "danger_level";
    public static final String PRICE_FIELD_NAME = "price";

    @DatabaseField(generatedId = true)
    private int id;

    @DatabaseField(columnName = CWEID_FIELD_NAME)
    private int cweId;

    @DatabaseField(columnName = DESCRIPTION_FIELD_NAME)
    private String description;

    @DatabaseField(columnName = ANALYZERNAME_FIELD_NAME)
    private String analyzerName;

    @DatabaseField(columnName = PERCENTAGE_FIELD_NAME)
    private double percentage;

    @DatabaseField(columnName = DANGERLEVEL_FIELD_NAME)
    private int dangerLevel;

    @DatabaseField(columnName = PRICE_FIELD_NAME)
    private int price;

    public ErrorORM() {

    }

    public ErrorORM(int cweId, String description, String analyzerName, double percentage, int dangerLevel, int price) {
        //this.id = id;
        this.cweId = cweId;
        this.description = description;
        this.analyzerName = analyzerName;
        this.percentage = percentage;
        this.dangerLevel = dangerLevel;
        this.price = price;
    }

    public int getId() {
        return this.id;
    }

    public void setCweId(int cweId) {
        this.cweId = cweId;
    }

    public int getCweId() {
        return this.cweId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return this.description;
    }

    public void setAnalyzerName(String analyzerName) {
        this.analyzerName = analyzerName;
    }

    public String getAnalyzerName() {
        return this.analyzerName;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }

    public double getPercentage() {
        return this.percentage;
    }

    public void setDangerLevel(int dangerLevel) {
        this.dangerLevel = dangerLevel;
    }

    public int getDangerLevel() {
        return this.dangerLevel;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPrice() {
        return this.price;
    }

    @Override
    public String toString() {
        return String.format(
                "ID: %d | CWE_ID: %d | Description: %s | Analyzer name: %s " +
                        "| Percentage: %f | Danger level %d | Price: %d",
                this.id, this.cweId, this.description,
                this.analyzerName, this.percentage, this.dangerLevel,  this.price);
    }

    @Override
    public int hashCode() {
        return String.valueOf(this.id).hashCode();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || o.getClass() != getClass()) {
            return false;
        }

        int obj_id = ((ErrorORM) o).getId();
        return String.valueOf(this.id).equals(String.valueOf(obj_id));
    }
}
