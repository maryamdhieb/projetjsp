package org.example.model;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private double quantity;
    private String imageUrl;
    private boolean promo;
    private double discount;
    private double promoPrice;
    private int categoryId;

    public Product(int id, String name, double price, String description, double quantity, String imageUrl, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
        this.categoryId = categoryId;
    }

    public Product(int id, String name, double price, String description, double quantity,
                   String imageUrl, boolean promo, double discount, double promoPrice, int categoryId) {
        this(id, name, price, description, quantity, imageUrl, categoryId);
        this.promo = promo;
        this.discount = discount;
        this.promoPrice = promoPrice;
    }


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isPromo() { return promo; }
    public void setPromo(boolean promo) { this.promo = promo; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; } // 🔥 FIX

    public double getPromoPrice() { return promoPrice; }
    public void setPromoPrice(double promoPrice) { this.promoPrice = promoPrice; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
}
