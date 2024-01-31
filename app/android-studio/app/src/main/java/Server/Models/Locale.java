package Server.Models;

import com.google.gson.annotations.SerializedName;

public class Locale {
    @SerializedName("date")
    private String date;

    @SerializedName("title")
    private String title;

    @SerializedName("colors")
    private String colors;

    public Locale(String date, String title, String colors) {
        this.date = date;
        this.title = title;
        this.colors = colors;
    }

    public String getDate() {
        return date;
    }

    public String getTitle() {
        return title;
    }

    public String getColors() {
        return colors;
    }

    public int hashCode() {
        return date.hashCode() + title.hashCode() + colors.hashCode();
    }
}

