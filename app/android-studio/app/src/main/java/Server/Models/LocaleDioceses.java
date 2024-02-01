package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.Dictionary;
import java.util.List;
import java.util.Map;

public class LocaleDioceses {
    @SerializedName("dioceses")
    private List<String> dioceses;

    @SerializedName("locale")
    private Map<String, List<Locale>> locale;

    public LocaleDioceses(List<String> dioceses, Map<String, List<Locale>> locale) {
        this.dioceses = dioceses;
        this.locale = locale;
    }

    public List<String> getDioceses() {
        return dioceses;
    }

    public Map<String, List<Locale>> getLocale() {
        return locale;
    }

    public int hashCode() {
        return dioceses.hashCode() + locale.hashCode();
    }
}
