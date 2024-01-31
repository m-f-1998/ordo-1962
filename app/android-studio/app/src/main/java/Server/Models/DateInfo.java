package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.UUID;

public class DateInfo {
    @SerializedName("id")
    private String id;

    @SerializedName("weekday")
    private String weekday;

    @SerializedName("day")
    private String day;

    @SerializedName("month")
    private String month;

    @SerializedName("combined")
    private String combined;

    public DateInfo(String weekday, String day, String month, String combined) {
        this.id = UUID.randomUUID().toString();
        this.weekday = weekday;
        this.day = day;
        this.month = month;
        this.combined = combined;
    }

    public DateInfo ( ) {
        this.id = UUID.randomUUID().toString();
        this.weekday = "Mon";
        this.day = "01";
        this.month = "01";
        this.combined = "Mon 01 01";
    }

    public String getId() {
        return id;
    }

    public String getWeekday() {
        return weekday;
    }

    public String getDay() {
        return day;
    }

    public String getMonth() {
        return month;
    }

    public String getCombined() {
        return combined;
    }

    enum CodingKeys {
        weekday, day, month, combined
    }
}
