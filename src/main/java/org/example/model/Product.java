package org.example.model;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private double Quantity;
    private String imageUrl;
    private boolean promo;
    private double discount;
    private double promoPrice;

    public Product( int id , String name, double price, String description , double quantity , String imageUrl) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.Quantity = quantity;
        this.imageUrl = imageUrl;
        this.promo = false; // par défaut, pas de promotion
    }
    public Product(int id, String name, double price, String description, double quantity, String imageUrl  ,
                   boolean promo, double discount, double promoPrice) {
        this(id, name, price , description , quantity , imageUrl);
        this.promo = promo;
        this.discount = discount;
        this.promoPrice = promoPrice;
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

    public  boolean isPromo() {
        return promo;
    }
    public void setPromo(boolean promo) {
        this.promo = promo;

    }
    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = this.discount;
    }
    public double getPromoPrice() {
        return promoPrice;
    }
    public void setPromoPrice(double promoPrice) {
        this.promoPrice = promoPrice;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public double getQuantity() {
        return Quantity;
    }
    public void setQuantity(double quantity) {
        Quantity = quantity;
    }


}

