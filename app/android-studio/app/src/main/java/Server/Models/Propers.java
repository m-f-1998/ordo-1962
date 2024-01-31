package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.HashMap;
import java.util.Map;

public class Propers {
    @SerializedName("title")
    private String title;

    @SerializedName("english")
    public String english;

    @SerializedName("latin")
    public String latin;

    private final Map<String, String> prayers;

    public Propers(String title, String english, String latin) {
        this.title = title;
        this.english = english;
        this.latin = latin;
        this.prayers = new HashMap<>();
        this.prayers.put("English", english);
        this.prayers.put("Latin", latin);
    }

    public String getTitle() {
        return title;
    }

    public String getPrayer(String lang) {
        return prayers.getOrDefault(lang, "");
    }
}
