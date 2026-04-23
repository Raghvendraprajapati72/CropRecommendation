package com.crop.model;

import java.sql.Timestamp;

public class HelpRequest {

    private int id;
    private String username;
    private String query;
    private String status;
    private Timestamp createdAt;   // ✅ BETTER TYPE

    // ✅ Default constructor
    public HelpRequest() {}

    // ✅ Full constructor
    public HelpRequest(int id, String username, String query, String status, Timestamp createdAt) {
        this.id = id;
        this.username = username;
        this.query = query;
        this.status = status;
        this.createdAt = createdAt;
    }

    // ✅ Insert constructor
    public HelpRequest(String username, String query, String status) {
        this.username = username;
        this.query = query;
        this.status = status;
    }

    // 🔽 GETTERS & SETTERS

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

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}