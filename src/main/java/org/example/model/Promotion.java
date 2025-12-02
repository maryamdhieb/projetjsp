package org.example.model;

import java.time.LocalDate;

public class Promotion {
    private int id;
    private String title;
    private String description;
    private String type; // "percentage" ou "fixed"
    private double value; // % ou montant en dinars
    private LocalDate startDate;
    private LocalDate endDate;

    public Promotion(int id, String title, String description, String type, double value,
                     LocalDate startDate, LocalDate endDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.value = value;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public boolean isActive() {
        LocalDate today = LocalDate.now();
        return (today.isEqual(startDate) || today.isAfter(startDate)) &&
                (today.isEqual(endDate)   || today.isBefore(endDate));
    }
    public String getDescription() {
        return description;
    }

    public String getTitle() {
        return title;
    }

    public int getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public double getValue() {
        return value;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }


}
