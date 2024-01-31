package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;

public class LocaleCountries {
    @SerializedName("countries")
    private List<String> countries;

    @SerializedName("locale")
    private List<LocaleDioceses> locale;

    public LocaleCountries(List<String> countries, List<LocaleDioceses> locale) {
        this.countries = countries;
        this.locale = locale;
    }

    public List<String> getCountries() {
        return countries;
    }

    public List<LocaleDioceses> getLocale() {
        return locale;
    }

    public boolean equals(LocaleCountries lhs, LocaleCountries rhs) {
        return lhs.countries.equals(rhs.countries) && lhs.locale.equals(rhs.locale);
    }

    public int hashCode() {
        return countries.hashCode() + locale.hashCode();
    }
}
