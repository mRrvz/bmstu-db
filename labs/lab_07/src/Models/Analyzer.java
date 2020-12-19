package Models;

public class Analyzer {
    private String name;
    private String homepage;
    private String description;
    private String languages;
    //private char proprietary;
    private int downloads;
    private int price;

    public Analyzer() {

    }

    public Analyzer(String name, String homepage, String description, String languages, int downloads, int price) {
        this.name = name;
        this.homepage = homepage;
        this.description = description;
        this.languages = languages;
        this.downloads = downloads;
        this.price = price;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setHomepage(String homepage) {
        this.homepage = homepage;
    }

    public String getHomepage(String homepage) {
        return this.homepage;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return this.description;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
    }

    public String getLanguages() {
        return this.languages;
    }

    /*
    public void setProprietary(char proprietary) {
        this.proprietary = proprietary;
    }
    */

    public void setDownloads(int downloads) {
        this.downloads = downloads;
    }

    public int getDownloads() {
        return this.downloads;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPrice() {
        return this.price;
    }
}
