package org.example.model;

import javax.swing.*;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private Promotion promotion;

    public Product( int id , String name, double price, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.promotion = null; // par défaut, pas de promotion
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // getters & setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Promotion getPromotion() { return promotion; }
    public void setPromotion(Promotion promotion) { this.promotion = promotion; }
    public boolean isOnPromotion() {
        return promotion != null && promotion.isActive();
    }


}

