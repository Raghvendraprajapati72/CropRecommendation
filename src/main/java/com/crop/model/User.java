package com.crop.model;

public class User {

    private int id;
    private String username;
    private String password;
    private String role;
    private String status; // 🔥 NEW FIELD

    // Default Constructor
    public User() {}

    // Parameterized Constructor
    public User(String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.status = "active"; // 🔥 default
    }

    // FULL Constructor (optional - advanced)
    public User(int id, String username, String password, String role, String status) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    // GETTERS & SETTERS

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // 🔥 STATUS (VERY IMPORTANT)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}