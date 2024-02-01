package Server;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import Server.Models.*;

public class ActiveData extends ViewModel {
    private MutableLiveData<Boolean> loading = new MutableLiveData<>(true);
    private MutableLiveData<Boolean> downloading = new MutableLiveData<>(false);
    private MutableLiveData<Boolean> error = new MutableLiveData<>(false);
    private MutableLiveData<Integer> percentage = new MutableLiveData<>(0);

    private String lastErr = "";
    private List<Ordo> ordo = new ArrayList<>();
    private Prayers prayers;
    private LocaleOrdo locale;

    public MutableLiveData<Boolean> getLoading() {
        return loading;
    }

    public MutableLiveData<Boolean> getDownloading() {
        return downloading;
    }

    public MutableLiveData<Boolean> getError() {
        return error;
    }

    public MutableLiveData<Integer> getPercentage() {
        return percentage;
    }

    public String getLastErr() {
        return lastErr;
    }

    public List<Ordo> getOrdo() {
        return ordo;
    }

    public Prayers getPrayers() {
        return prayers;
    }

    public LocaleOrdo getLocale() {
        return locale;
    }

    public void setSuccess(List<Ordo> ordo, LocaleOrdo locale, Prayers prayers) {
        this.ordo = ordo;
        this.locale = locale;
        this.prayers = prayers;
        setStatus(false, false, false);
    }

    public void setDownload(int download) {
        percentage.setValue(download);
    }

    public void setError(String error) {
        lastErr = error;
        setStatus(true, false, false);
    }

    public void setStatus(boolean error, boolean downloading, boolean loading) {
        try {
            this.error.postValue(error);
        } catch (Exception e) {
            System.out.println(e);
        }
        this.downloading.postValue(downloading);
        this.loading.postValue(loading);
    }

    private String CurrentMonth ( ) {
        Calendar cal = Calendar.getInstance();
        return new SimpleDateFormat("MMM").format(cal.getTime());
    }

    private Integer CurrentDay ( ) {
        Calendar cal = Calendar.getInstance();
        int dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);
        return dayOfMonth;
    }

    public String getIDToday() {
        if (!ordo.isEmpty()) {
            Calendar cal = Calendar.getInstance();
            return ordo.get(0).getDay(CurrentMonth(), CurrentDay()).getDate().getCombined();
        }
        return "";
    }

    public List<String> getCountries() {
        if (locale != null && locale.getFeasts() != null && locale.getFeasts().getCountries() != null) {
            return locale.getFeasts().getCountries();
        }
        return new ArrayList<>();
    }

    public List<String> getDioceses(String country) {
        if (locale != null && locale.getFeasts() != null && locale.getFeasts().getLocale() != null) {
            return locale.getFeasts().getLocale().get(Integer.parseInt(country)).getDioceses();
        }
        return new ArrayList<>();
    }

    public List<Locale> getDioceseLocale(String country, String diocese) {
        if (locale != null && locale.getFeasts() != null && locale.getFeasts().getLocale() != null) {
            return locale.getFeasts().getLocale().get(Integer.parseInt(country)).getLocale().get(diocese);
        }
        return new ArrayList<>();
    }

    public Ordo getYear(int year) {
        int index = year - Year.now().getValue();
        if (index < ordo.size()) {
            return ordo.get(index);
        }
        return null;
    }

    public List<List<OrdoDay>> getFilteredOrdo(String search, int year) {
        List<List<OrdoDay>> filteredOrdo = new ArrayList<>();
        Ordo ordoYear = getYear(year);
        if (ordoYear != null) {
            for (List<OrdoDay> dayList : ordoYear.getOrdo()) {
                List<OrdoDay> filteredDayList = filter(search, dayList);
                if (!filteredDayList.isEmpty()) {
                    filteredOrdo.add(filteredDayList);
                }
            }
        }
        return filteredOrdo;
    }

    private List<OrdoDay> filter(String search, List<OrdoDay> data) {
        List<OrdoDay> filteredList = new ArrayList<>();
        for (OrdoDay day : data) {
            if (day.getSeason().getTitle().toLowerCase().contains(search.toLowerCase())) {
                filteredList.add(day);
            } else {
                for (Celebrations celebration : day.getCelebrations()) {
                    if (celebration.getTitle().toLowerCase().contains(search.toLowerCase())) {
                        filteredList.add(day);
                        break;
                    }
                    for (Commemorations commemoration : celebration.getCommemorations()) {
                        if (commemoration.getTitle().toLowerCase().contains(search.toLowerCase())) {
                            filteredList.add(day);
                            break;
                        }
                    }
                }
            }
        }
        return filteredList;
    }
}
