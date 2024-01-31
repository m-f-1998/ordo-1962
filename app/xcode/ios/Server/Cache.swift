import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Cache {
    private static final String ORDO_SET_KEY = "ordo_set";
    private static final String PRAYERS_KEY = "prayers";
    private static final String LOCALE_KEY = "locale";
    private static final String VERSION_KEY = "version";

    private final SharedPreferences preferences;
    private final Gson gson;

    public Cache(Context context) {
        this.preferences = PreferenceManager.getDefaultSharedPreferences(context);
        this.gson = new Gson();
    }

    public List<OrdoYear> getOrdo() {
        String ordoSetString = preferences.getString(ORDO_SET_KEY, "");
        Type ordoListType = new TypeToken<List<OrdoYear>>() {}.getType();
        return gson.fromJson(ordoSetString, ordoListType);
    }

    public PrayerLanguageData getPrayers() {
        String prayersJson = preferences.getString(PRAYERS_KEY, "");
        return gson.fromJson(prayersJson, PrayerLanguageData.class);
    }

    public LocaleOrdo getLocale() {
        String localeJson = preferences.getString(LOCALE_KEY, "");
        return gson.fromJson(localeJson, LocaleOrdo.class);
    }

    public boolean cacheExists() {
        List<OrdoYear> ordo = getOrdo();
        String version = preferences.getString(VERSION_KEY, "");
        if (!version.isEmpty() && version.equals("1.0")) { // Replace with actual implementation
            return ordo.size() == 6 && ordo.get(0).getYear() == getCurrentYear();
        }
        return false;
    }

    public boolean currentCacheExists() {
        List<OrdoYear> ordo = getOrdo();
        return ordo.size() > 0 && ordo.get(0).getYear() == getCurrentYear();
    }

    public void deleteAll() {
        preferences.edit().remove(ORDO_SET_KEY).remove(PRAYERS_KEY).remove(LOCALE_KEY).apply();
    }

    public void insertPrayers(PrayerLanguageData prayers) {
        String prayersJson = gson.toJson(prayers);
        preferences.edit().putString(PRAYERS_KEY, prayersJson).apply();
    }

    public void insertOrdo(OrdoYear ordo) {
        List<OrdoYear> ordoList = getOrdo();
        ordoList.add(ordo);
        String ordoSetString = gson.toJson(ordoList);
        preferences.edit().putString(ORDO_SET_KEY, ordoSetString).apply();
    }

    public void insertLocale(LocaleOrdo locale) {
        String localeJson = gson.toJson(locale);
        preferences.edit().putString(LOCALE_KEY, localeJson).apply();
    }

    public void save() {
        // No need to implement save in SharedPreferences, as data is updated in real-time
    }

    private int getCurrentYear() {
        // Implement the logic to get the current year
        return 2024; // Example: replace with actual implementation
    }
}
