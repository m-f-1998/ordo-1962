package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Prayers {
    private Map<String, PrayerCategoryData> res = new HashMap<>();

    public Prayers ( PrayerCategoryData english, PrayerCategoryData latin ) {
        res.put ( "English", english );
        res.put ( "Latin", latin );
    }

    public String getPrayer(String lang, String category, String name) {
        PrayerCategoryData categoryMap = this.res.get(lang);
        if (categoryMap != null) {
            PrayerData prayerMap = categoryMap.get(category);
            if (prayerMap != null) {
                return prayerMap.get(name);
            }
        }
        return "";
    }

    public List<String> getPrayerNames(String lang, String cat) {
        PrayerCategoryData categoryMap = this.res.get(lang);
        if (categoryMap != null) {
            return categoryMap.get(cat) != null ? categoryMap.get(cat).keySet().stream().sorted().toList() : List.of();
        }
        return List.of();
    }

    public List<String> getCategories(String lang) {
        PrayerCategoryData categoryMap = this.res.get(lang);
        return categoryMap != null ? categoryMap.keySet().stream().sorted().toList() : List.of();
    }

    public List<String> getLanguageDetails() {
        return List.of("English", "Latin").stream().sorted().toList();
    }
}

class PrayerCategoryData extends HashMap<String, PrayerData> { }

class PrayerData extends HashMap<String, String> { }
