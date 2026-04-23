package com.crop.model;

public class MLModel {

    public static String predict(double n, double p, double k,
                                 double temp, double humidity,
                                 double ph, double rain) {

        if (rain >= 150 && humidity >= 70 && temp >= 20 && temp <= 35) {
            return "Rice";
        } else if (rain >= 200 && temp >= 20 && temp <= 38) {
            return "Sugarcane";
        } else if (temp >= 18 && temp <= 30 && ph >= 5.5 && ph <= 7.5) {
            return "Maize";
        } else if (temp >= 10 && temp <= 25 && humidity <= 60) {
            return "Wheat";
        } else if (temp >= 15 && temp <= 22 && humidity >= 60) {
            return "Potato";
        } else if (temp >= 25 && temp <= 38 && rain <= 120) {
            return "Cotton";
        } else if (temp >= 12 && temp <= 25 && rain <= 100) {
            return "Barley";
        } else if (rain <= 50 && temp >= 25) {
            return "Millet";
        } else if (temp >= 20 && humidity >= 50) {
            return "Maize";
        }

        return "No Suitable Crop Found";
    }
}