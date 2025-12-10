package org.example.model;

import java.util.ArrayList;
import java.util.List;
public class Category {
    private  int id;
    private String name;
    private String description;
    private String imageUrl;
    private List<Product> products;

    public  Category() {}
    // Constructeur principal avec la liste des produits
    public Category(int id , String name, String description, String imageUrl , List<Product> products ) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
        this.products = products;
    }

    // Constructeur pratique pour créer une catégorie sans produits
    public Category(String name, String description) {
        this.name = name;
        this.description = description;
        this.products = new ArrayList<>(); // initialise la liste vide
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
