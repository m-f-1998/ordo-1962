package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;
import java.util.UUID;

public class LocaleOrdo {
    @SerializedName("id")
    private String id;

    @SerializedName("in_certain_locations")
    private List<Locale> certainLocations;

    @SerializedName("feasts")
    private LocaleCountries feasts;

    public LocaleOrdo(List<Locale> certainLocations, LocaleCountries feasts) {
        this.id = UUID.randomUUID().toString();
        this.certainLocations = certainLocations;
        this.feasts = feasts;
    }

    public String getId() {
        return id;
    }

    public List<Locale> getCertainLocations() {
        return certainLocations;
    }

    public LocaleCountries getFeasts() {
        return feasts;
    }

    public static boolean equals(LocaleOrdo lhs, LocaleOrdo rhs) {
        return lhs.id.equals(rhs.id);
    }
}
