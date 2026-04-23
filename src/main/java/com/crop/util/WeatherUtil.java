package com.crop.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class WeatherUtil {

    // 🔥 IMPORTANT: Apni real API key yaha daalo
    private static final String API_KEY = "PASTE_YOUR_REAL_API_KEY_HERE";

    public static double[] getWeather(String city) {

        double temp = 0;
        double humidity = 0;

        try {
            String urlStr = "https://api.openweathermap.org/data/2.5/weather?q="
                    + city + "&appid=" + API_KEY + "&units=metric";

            System.out.println("🌍 URL: " + urlStr);

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            int responseCode = conn.getResponseCode();
            System.out.println("📡 Response Code: " + responseCode);

            BufferedReader reader;

            // ✅ Handle BOTH success & error response
            if (responseCode == 200) {
                reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                reader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            StringBuilder response = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            System.out.println("📦 API RESPONSE: " + response.toString());

            // ❌ If API failed → return default safe values
            if (responseCode != 200) {
                return new double[]{25, 60}; // fallback
            }

            // ✅ JSON PARSE
            JSONObject obj = new JSONObject(response.toString());

            if (obj.has("main")) {
                JSONObject main = obj.getJSONObject("main");

                temp = main.getDouble("temp");
                humidity = main.getDouble("humidity");
            }

            System.out.println("🌡 Temp: " + temp);
            System.out.println("💧 Humidity: " + humidity);

        } catch (Exception e) {
            System.out.println("❌ WEATHER ERROR");
            e.printStackTrace();

            // ✅ fallback if exception
            return new double[]{25, 60};
        }

        return new double[]{temp, humidity};
    }
}