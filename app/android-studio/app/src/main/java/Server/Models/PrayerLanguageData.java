package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PrayerLanguageData {
    @SerializedName("English")
    private Map<String, PrayerCategoryData> resEnglish = new HashMap<>();

    @SerializedName("Latin")
    private Map<String, PrayerCategoryData> resLatin = new HashMap<>();

    public String getPrayer(String lang, String category, String name) {
        Map<String, PrayerCategoryData> languageMap = "English".equals(lang) ? resEnglish : resLatin;
        PrayerCategoryData categoryMap = languageMap.get(lang);
        if (categoryMap != null) {
            PrayerData prayerMap = categoryMap.get(category);
            if (prayerMap != null) {
                return prayerMap.get(name);
            }
        }
        return "";
    }

    public List<String> getPrayerNames(String lang, String cat) {
        Map<String, PrayerCategoryData> languageMap = "English".equals(lang) ? resEnglish : resLatin;
        PrayerCategoryData categoryMap = languageMap.get(lang);
        if (categoryMap != null) {
            return categoryMap.get(cat) != null ? categoryMap.get(cat).keySet().stream().sorted().toList() : List.of();
        }
        return List.of();
    }

    public List<String> getCategories(String lang) {
        Map<String, PrayerCategoryData> languageMap = "English".equals(lang) ? resEnglish : resLatin;
        PrayerCategoryData categoryMap = languageMap.get(lang);
        return categoryMap != null ? categoryMap.keySet().stream().sorted().toList() : List.of();
    }

    public List<String> getLanguageDetails() {
        return List.of("English", "Latin").stream().sorted().toList();
    }
}
