package org.example.model;
import java.util.Base64;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private double quantity;
    private byte[] image;
    private boolean promo;
    private double discount;
    private double promoPrice;
    private int categoryId;
    private String imageBase64;

    public Product(int id, String name, double price, String description, double quantity, byte[] image, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.quantity = quantity;
        this.image = image;
        this.categoryId = categoryId;
        this.imageBase64 = (image != null && image.length > 0)
                ? Base64.getEncoder().encodeToString(image)
                : null;
    }

    public Product(int id, String name, double price, String description, double quantity, byte[] image
                   , boolean promo, double discount, double promoPrice, int categoryId) {
        this(id, name, price, description, quantity, image, categoryId);
        this.promo = promo;
        this.discount = discount;
        this.promoPrice = promoPrice;
        this.imageBase64 = (image != null && image.length > 0)
                ? Base64.getEncoder().encodeToString(image)
                : null;    }


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

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    public boolean isPromo() { return promo; }
    public void setPromo(boolean promo) { this.promo = promo; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }

    public double getPromoPrice() { return promoPrice; }
    public void setPromoPrice(double promoPrice) { this.promoPrice = promoPrice; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getImageBase64() { return imageBase64; }
}
