package com.crop.model;

public class CropModel {

    public static String predictCrop(double n, double p, double k,
                                     double temp, double humidity,
                                     double ph, double rain) {

        // 🌾 RICE (high water crop)
        if (rain >= 150 && humidity >= 70 && temp >= 20 && temp <= 35) {
            return "Rice";
        }

        // 🌿 SUGARCANE (very high water)
        else if (rain >= 200 && temp >= 20 && temp <= 38) {
            return "Sugarcane";
        }

        // 🌽 MAIZE (balanced crop)
        else if (temp >= 18 && temp <= 30 && ph >= 5.5 && ph <= 7.5) {
            return "Maize";
        }

        // 🌾 WHEAT (cool crop)
        else if (temp >= 10 && temp <= 25 && humidity <= 60) {
            return "Wheat";
        }

        // 🥔 POTATO (cool + moist)
        else if (temp >= 15 && temp <= 22 && humidity >= 60) {
            return "Potato";
        }

        // 🌱 COTTON (hot + dry)
        else if (temp >= 25 && temp <= 38 && rain <= 120) {
            return "Cotton";
        }

        // 🌾 BARLEY (low rain crop)
        else if (temp >= 12 && temp <= 25 && rain <= 100) {
            return "Barley";
        }

        // 🌶 MILLET (very dry condition)
        else if (rain <= 50 && temp >= 25) {
            return "Millet";
        }

        // 🔥 SMART FALLBACK (IMPORTANT)
        else if (temp >= 20 && humidity >= 50) {
            return "Maize"; // default safe crop
        }

        return "No Suitable Crop Found";
    }
}