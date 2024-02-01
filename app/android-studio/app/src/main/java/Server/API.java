package Server;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Looper;

import androidx.preference.PreferenceManager;

import com.google.gson.Gson;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import java.time.Year;

import Server.Models.*;
import com.mfrankland.ordo62.BuildConfig;

public class API {
    private final Cache cache;
    private final ActiveData activeData;
    private final Executor backgroundExecutor;
    private final Executor mainThreadExecutor;

    private final SharedPreferences sharedPreferences;

    public API(ActiveData activeData, Context context) {
        this.activeData = activeData;
        this.cache = new Cache(context);
        this.sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
        this.backgroundExecutor = Executors.newCachedThreadPool();
        this.mainThreadExecutor = new MainThreadExecutor();
    }

    public Cache getCache() {
        return this.cache;
    }

    public void updateCache() {
        CompletableFuture.runAsync(this::updateCacheTask, backgroundExecutor);
    }

    public Ordo getCurrent() {
        try {
            return ordoRequest(String.valueOf(getCurrentYear()));
        } catch (IOException e) {
            e.printStackTrace();
            // Handle the exception
            return null;
        }
    }

    private int getCurrentYear() {
        // Implement the logic to get the current year
        return Year.now().getValue(); // Example: replace with actual implementation
    }

    private <T> T decode(String json, Class<T> type) {
        return new Gson().fromJson(json, type);
    }

    private Ordo ordoRequest(String year) throws IOException {
        String url = "https://matthewfrankland.co.uk/ordo-1962/v1.3/ordo.php?year=" + year;
        // Implement the logic to perform HTTP request and handle the response
        return decode(httpRequest(url), Ordo.class);
    }

    private Prayers prayerRequest() throws IOException {
        String url = "https://matthewfrankland.co.uk/ordo-1962/v1.3/prayers.php";
        // Implement the logic to perform HTTP request and handle the response
        return decode(httpRequest(url), Prayers.class);
    }

    private LocaleOrdo localeRequest() throws IOException {
        String url = "https://matthewfrankland.co.uk/ordo-1962/v1.3/locale.php";
        // Implement the logic to perform HTTP request and handle the response
        return decode(httpRequest(url), LocaleOrdo.class);
    }

    private String httpRequest(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
        try {
            InputStream in = urlConnection.getInputStream();
            return convertInputStreamToString(in);
        } finally {
            urlConnection.disconnect();
        }
    }

    private String convertInputStreamToString(InputStream inputStream) throws IOException {
        ByteArrayOutputStream result = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        for (int length; (length = inputStream.read(buffer)) != -1; ) {
            result.write(buffer, 0, length);
        }
        return result.toString("UTF-8");
    }

    private void updateCacheTask() {
        try {
            cache.deleteAll();
            LocaleOrdo locale = localeRequest();
            // Update the UI on the main thread
            updateMainThread(() -> activeData.setDownload(4));

            Prayers prayers = prayerRequest();
            // Update the UI on the main thread
            updateMainThread(() -> activeData.setDownload(8));

            ArrayList<Ordo> ordo = new ArrayList<>();

            for (int i = getCurrentYear(); i <= getCurrentYear() + 5; i++) {
                System.out.println("Downloading " + i + "...");
                Ordo ordoYear = ordoRequest(String.valueOf(i));
                ordo.add(ordoYear);
                cache.insertOrdo(ordoYear);
                // Update the UI on the main thread
                int finalI = i;
                updateMainThread(() -> activeData.setDownload((finalI + 1 - getCurrentYear()) * 16));
            }

            // Get version from the app's metadata
            String version = BuildConfig.VERSION_NAME; // Replace with actual implementation
            // Save the version in SharedPreferences
            // You need to implement SharedPreferences logic
            // Here's a simplified example:
            this.sharedPreferences.edit().putString("version", version).apply();
            activeData.setSuccess(ordo, locale, prayers);
        } catch (IOException e) {
            e.printStackTrace();
            // Handle the exception
        }
    }

    private void updateMainThread(Runnable runnable) {
        new Handler(Looper.getMainLooper()).post(runnable);
    }

    private static class MainThreadExecutor implements Executor {
        private final Handler handler = new Handler(Looper.getMainLooper());

        @Override
        public void execute(Runnable command) {
            handler.post(command);
        }
    }
}
