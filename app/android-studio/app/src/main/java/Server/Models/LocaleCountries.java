package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;
import java.util.Map;

public class LocaleCountries {
    @SerializedName("countries")
    private List<String> countries;

    @SerializedName("locale")
    private Map<String, LocaleDioceses> locale;

    public LocaleCountries(List<String> countries, Map<String, LocaleDioceses> locale) {
        this.countries = countries;
        this.locale = locale;
    }

    public List<String> getCountries() {
        return countries;
    }

    public Map<String, LocaleDioceses> getLocale() {
        return locale;
    }

    public int hashCode() {
        return countries.hashCode() + locale.hashCode();
    }
}
