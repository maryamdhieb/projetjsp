package org.example.repository;

import org.example.model.Category;
import org.example.model.Product;

import java.util.List;

public class ProductRepository {

    // Ajouter un produit à une catégorie
    public void addProduct(Category category, Product product) {
        if (category.getProducts() != null) {
            category.getProducts().add(product);
        }
    }

    // Supprimer un produit d'une catégorie
    public void deleteProduct(Category category, String productName) {
        if (category.getProducts() != null) {
            category.getProducts().removeIf(p -> p.getName().equalsIgnoreCase(productName));
        }
    }

    // Modifier un produit d'une catégorie
    public void updateProduct(Category category, String originalName, Product updatedProduct) {
        if (category.getProducts() != null) {
            for (Product p : category.getProducts()) {
                if (p.getName().equalsIgnoreCase(originalName)) {
                    p.setName(updatedProduct.getName());
                    p.setPrice(updatedProduct.getPrice());
                    p.setDescription(updatedProduct.getDescription());
                    return;
                }
            }
        }
    }
}
