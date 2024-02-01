package Server.Models;

import com.google.gson.annotations.SerializedName; // Assuming you're using Gson for JSON parsing

public class Season {
    @SerializedName("title")
    private String title;

    @SerializedName("colors")
    private String colors;

    public Season ( String title, String colors ) {
        this.title = title;
        this.colors = colors;
    }

    public Season ( ) {
        this.title = "";
        this.colors = "";
    }

    public String getTitle() {
        return title;
    }

    public String getColors() {
        return colors;
    }
}
