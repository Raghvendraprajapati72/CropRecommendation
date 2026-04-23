package com.crop.model;

public class History {

    private int id;
    private String crop;
    private String soil;
    private double temperature;
    private double humidity;
    private String result;
    private String date;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCrop() { return crop; }
    public void setCrop(String crop) { this.crop = crop; }

    public String getSoil() { return soil; }
    public void setSoil(String soil) { this.soil = soil; }

    public double getTemperature() { return temperature; }
    public void setTemperature(double temperature) { this.temperature = temperature; }

    public double getHumidity() { return humidity; }
    public void setHumidity(double humidity) { this.humidity = humidity; }

    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}