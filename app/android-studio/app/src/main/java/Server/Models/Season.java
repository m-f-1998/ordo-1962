package Server.Models;

import com.google.gson.annotations.SerializedName; // Assuming you're using Gson for JSON parsing

public class Season {
    @SerializedName("title")
    private String title;

    @SerializedName("colors")
    private String colors;

    public String getTitle() {
        return title;
    }

    public String getColors() {
        return colors;
    }
}
