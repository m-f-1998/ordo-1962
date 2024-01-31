package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;

public class LocaleDioceses {
    @SerializedName("dioceses")
    private List<String> dioceses;

    @SerializedName("locale")
    private List<Locale> locale;

    public LocaleDioceses(List<String> dioceses, List<Locale> locale) {
        this.dioceses = dioceses;
        this.locale = locale;
    }

    public List<String> getDioceses() {
        return dioceses;
    }

    public List<Locale> getLocale() {
        return locale;
    }

    public boolean equals(LocaleDioceses lhs, LocaleDioceses rhs) {
        return lhs.dioceses.equals(rhs.dioceses) && lhs.locale.equals(rhs.locale);
    }

    public int hashCode() {
        return dioceses.hashCode() + locale.hashCode();
    }
}
