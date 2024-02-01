package Server;

import android.content.Context;
import android.content.SharedPreferences;
import androidx.preference.PreferenceManager;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.time.Year;
import java.util.List;
import java.util.ArrayList;
import Server.Models.*;

public class Cache {
    private static final String ORDO_KEY = "ordo_set";
    private static final String PRAYERS_KEY = "prayers";
    private static final String LOCALE_KEY = "locale";
    private static final String VERSION_KEY = "version";

    private final SharedPreferences preferences;
    private final Gson gson;

    public Cache(Context context) {
        this.preferences = PreferenceManager.getDefaultSharedPreferences(context);
        this.gson = new Gson();
    }

    public List<Ordo> getOrdo() {
        String ordoSetString = preferences.getString(ORDO_KEY, "");
        Type ordoListType = new TypeToken<List<Ordo>>() {}.getType();
        if ( ordoSetString.isEmpty()) {
            return new ArrayList<>();
        }
        return gson.fromJson(ordoSetString, ordoListType);
    }

    public Prayers getPrayers() {
        String prayersJson = preferences.getString(PRAYERS_KEY, "");
        if (prayersJson.isEmpty()) {
            return null;
        }
        return gson.fromJson(prayersJson, Prayers.class);
    }

    public LocaleOrdo getLocale() {
        String localeJson = preferences.getString(LOCALE_KEY, "");
        if (localeJson.isEmpty()) {
            return null;
        }
        return gson.fromJson(localeJson, LocaleOrdo.class);
    }

    public boolean cacheExists() {
        List<Ordo> ordo = getOrdo();
        String version = preferences.getString(VERSION_KEY, "");
        if (!version.isEmpty() && version.equals("1.0")) { // Replace with actual implementation
            return ordo.size() == 6 && ordo.get(0).getYear() == Year.now().getValue();
        }
        return false;
    }

    public boolean currentCacheExists() {
        List<Ordo> ordo = getOrdo();
        return ordo.size() > 0 && ordo.get(0).getYear() == Year.now().getValue();
    }

    public void deleteAll() {
        preferences.edit().remove(ORDO_KEY).remove(PRAYERS_KEY).remove(LOCALE_KEY).apply();
    }

    public void insertPrayers(Prayers prayers) {
        String prayersJson = gson.toJson(prayers);
        preferences.edit().putString(PRAYERS_KEY, prayersJson).apply();
    }

    public void insertOrdo(Ordo ordo) {
        List<Ordo> ordoList = getOrdo();
        ordoList.add(ordo);
        String ordoSetString = gson.toJson(ordoList);
        preferences.edit().putString(ORDO_KEY, ordoSetString).apply();
    }

    public void insertLocale(Ordo locale) {
        String localeJson = gson.toJson(locale);
        preferences.edit().putString(LOCALE_KEY, localeJson).apply();
    }
}
