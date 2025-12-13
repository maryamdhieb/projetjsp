package org.example.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Base64;
public class Category {

    private int id;
    private String name;
    private String description;
    private  byte[] image ;
    private List<Product> products;
    private String imageBase64;


    public Category(String name, String description, byte[] image) {
        this.name = name;
        this.description = description;
        this.image = image;
        this.products = new ArrayList<>();
        this.imageBase64 = (image != null && image.length > 0)
                ? Base64.getEncoder().encodeToString(image)
                : null;
    }

    public Category(int id, String name, String description, byte[] image, List<Product> products) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.products = products;
        this.imageBase64 = (image != null && image.length > 0)
                ? Base64.getEncoder().encodeToString(image)
                : null;
    }

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    public List<Product> getProducts() { return products; }
    public void setProducts(List<Product> products) { this.products = products; }
    public String getImageBase64() { return imageBase64; }
}
