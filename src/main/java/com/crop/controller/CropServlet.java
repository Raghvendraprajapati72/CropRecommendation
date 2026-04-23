package com.crop.controller;

import java.io.*;
import java.net.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import com.crop.dao.CropDAO;
import com.crop.model.CropModel;
import com.crop.util.DBConnection;

@WebServlet("/predict")
public class CropServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {

            // ============================
            // ✅ 1. GET INPUT
            // ============================
            double n = parse(req.getParameter("n"));
            double p = parse(req.getParameter("p"));
            double k = parse(req.getParameter("k"));
            double temp = parse(req.getParameter("temp"));
            double humidity = parse(req.getParameter("humidity"));
            double ph = parse(req.getParameter("ph"));
            double rain = parse(req.getParameter("rain"));

            // ============================
            // 🌦️ 2. WEATHER API (FIXED)
            // ============================

            // ✅ fallback (IMPORTANT FIX)
            double weatherTemp = temp;
            double weatherHumidity = humidity;

            try {
                String apiKey = "PUT_REAL_API_KEY"; // optional
                String city = "Delhi";

                String urlStr = "https://api.openweathermap.org/data/2.5/weather?q="
                        + city + "&appid=" + apiKey + "&units=metric";

                URL url = new URL(urlStr);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");

                if (conn.getResponseCode() == 200) {

                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(conn.getInputStream()));

                    StringBuilder response = new StringBuilder();
                    String line;

                    while ((line = reader.readLine()) != null) {
                        response.append(line);
                    }
                    reader.close();

                    JSONObject obj = new JSONObject(response.toString());

                    weatherTemp = obj.getJSONObject("main").getDouble("temp");
                    weatherHumidity = obj.getJSONObject("main").getDouble("humidity");

                    // ✅ override only if API works
                    temp = weatherTemp;
                    humidity = weatherHumidity;

                    System.out.println("🌡 API TEMP: " + weatherTemp);
                    System.out.println("💧 API HUMIDITY: " + weatherHumidity);

                } else {
                    System.out.println("⚠️ API FAILED → using form values");
                }

            } catch (Exception e) {
                System.out.println("⚠️ WEATHER ERROR → fallback used");
            }

            // ============================
            // ✅ 3. PREDICTION
            // ============================
            String result = CropModel.predictCrop(n, p, k, temp, humidity, ph, rain);

            if (result == null || result.trim().isEmpty()) {
                result = "No Suitable Crop Found";
            }

            // ============================
            // ✅ 4. SAVE DATA
            // ============================
            CropDAO.saveData(n, p, k, temp, humidity, ph, rain, result);

            // ============================
            // ✅ 5. USER HISTORY
            // ============================
            HttpSession session = req.getSession(false);
            String user = (session != null) ? (String) session.getAttribute("user") : null;

            if (user != null) {
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement(
                             "INSERT INTO predictions(username, crop) VALUES (?, ?)")) {

                    ps.setString(1, user);
                    ps.setString(2, result);
                    ps.executeUpdate();
                }
            }

            // ============================
            // ✅ 6. SEND DATA TO JSP (FIXED)
            // ============================

            req.setAttribute("n", n);
            req.setAttribute("p", p);
            req.setAttribute("k", k);

            // 🔥 IMPORTANT FIX
            req.setAttribute("temp", temp);
            req.setAttribute("humidity", humidity);

            req.setAttribute("ph", ph);
            req.setAttribute("rain", rain);

            // 🔥 SHOW FINAL VALUES (NOT ZERO)
            req.setAttribute("weatherTemp", temp);
            req.setAttribute("weatherHumidity", humidity);

            req.setAttribute("result", result);

            // ============================
            // ✅ 7. FORWARD
            // ============================
            RequestDispatcher rd = req.getRequestDispatcher("/views/result.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            req.setAttribute("error", "❌ Invalid input!");
            req.getRequestDispatcher("/views/index.jsp").forward(req, res);
        }
    }

    private double parse(String value) {
        if (value == null || value.trim().isEmpty()) return 0;
        return Double.parseDouble(value.trim());
    }
}