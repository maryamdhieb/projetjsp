package org.example.model;

import java.time.LocalDate;
import java.util.List;

public class Promotion {
    private int id;
    private String name;
    private String description;
    private double value;
    private String type;
    private LocalDate startDate;
    private LocalDate endDate;
    private List<Product> products;

    public Promotion(int id, String name, String description, double value, String Type,
                     LocalDate startDate, LocalDate endDate) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.value = value;
        this.type = Type;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public boolean isActive() {
        LocalDate today = LocalDate.now();
        return (today.isEqual(startDate) || today.isAfter(startDate)) &&
                (today.isEqual(endDate) || today.isBefore(endDate));
    }


    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getValue() { return value; }
    public String getType() { return type; }
    public LocalDate getStartDate() { return startDate; }
    public LocalDate getEndDate() { return endDate; }
    public List<Product> getProducts() { return products; }


    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setDescription(String description) { this.description = description; }
    public void setValue(double value) { this.value = value; }
    public void setType(String type) { this.type = type; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    public void setProducts(List<Product> products) { this.products = products; }
}