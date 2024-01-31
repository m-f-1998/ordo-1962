package Server.Models;

import com.google.gson.annotations.SerializedName;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

public class Ordo {
    @SerializedName("id")
    private String id;

    @SerializedName("ordo")
    private List<List<OrdoDay>> ordo;

    @SerializedName("year")
    private int year;

    @SerializedName("date")
    private Date date;

    public Ordo(List<List<OrdoDay>> ordo, int year) {
        this.id = UUID.randomUUID().toString();
        this.ordo = ordo;
        this.year = year;
        this.date = new Date();
    }

    public String getId() {
        return id;
    }

    public List<List<OrdoDay>> getOrdo() {
        return ordo;
    }

    public int getYear() {
        return year;
    }

    public Date getDate() {
        return date;
    }

    public List<OrdoDay> getMonth(String month) {
        return ordo.get(Calendar.getInstance().getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.getDefault()).equals(month) ? 0 : 1);
    }

    public OrdoDay getDay(String month, int day) {
        List<OrdoDay> res = getMonth(month);
        if (day <= res.size()) {
            return res.get(day - 1);
        }
        return new OrdoDay();
    }

    public static boolean equals(Ordo lhs, Ordo rhs) {
        return lhs.id.equals(rhs.id);
    }

    public int hashCode() {
        return id.hashCode();
    }
}

