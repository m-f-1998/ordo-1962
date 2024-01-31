package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class OrdoDay {
    @SerializedName("id")
    private String id;

    @SerializedName("date")
    private DateInfo date;

    @SerializedName("celebrations")
    private List<CelebrationData> celebrations;

    @SerializedName("season")
    private Season season;

    @SerializedName("fasting")
    private List<String> fasting;

    public OrdoDay(DateInfo date, List<CelebrationData> celebrations, Season season, List<String> fasting) {
        this.id = UUID.randomUUID().toString();
        this.date = date;
        this.celebrations = celebrations;
        this.season = season;
        this.fasting = fasting;
    }

    public OrdoDay ( ) {
        this.id = UUID.randomUUID().toString();
        this.date = new DateInfo();
        this.celebrations = new ArrayList<CelebrationData>();
        this.season = new Season();
        this.fasting = new ArrayList<String>();
    }


    public String getId() {
        return id;
    }

    public DateInfo getDate() {
        return date;
    }

    public List<CelebrationData> getCelebrations() {
        return celebrations;
    }

    public Season getSeason() {
        return season;
    }

    public List<String> getFasting() {
        return fasting;
    }

    public boolean equals(OrdoDay lhs, OrdoDay rhs) {
        return lhs.id.equals(rhs.id);
    }

    public int hashCode() {
        return id.hashCode();
    }
}
