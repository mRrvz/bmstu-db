package Models;

public class Error {
    private int id;
    private int cweId;
    private String description;
    private String analyzerName;
    private double percentage;
    private int dangerLevel;
    private int price;

    public Error() {

    }

    public Error(int id, int cweId, String description, String analyzerName, double percentage, int dangerLevel, int price) {
        this.id = id;
        this.cweId = cweId;
        this.description = description;
        this.analyzerName = analyzerName;
        this.percentage = percentage;
        this.dangerLevel = dangerLevel;
        this.price = price;
    }

    public void setId(int id) {
        this.id = id;
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
}
