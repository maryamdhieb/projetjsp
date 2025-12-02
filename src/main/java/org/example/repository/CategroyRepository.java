package org.example.repository;

import org.example.model.Category;
import org.example.model.Product;

import java.util.ArrayList;
import java.util.List;

public class CategroyRepository {

    private static List<Category> categories = new ArrayList<>(List.of(
            new Category(1,"Electronics", "Devices and gadgets", new ArrayList<>(List.of(
                    new Product(1,"Laptop", 999.99, "A high-performance laptop"),
                    new Product(2,"Smartphone", 699.99, "A latest model smartphone"),
                    new Product(3,"Headphones", 199.99, "Noise-cancelling headphones")
            ))),
            new Category(2,"Apparel", "Various clothes", new ArrayList<>(List.of(
                    new Product(4,"Shirts", 99.99, "A high-quality shirt"),
                    new Product(5,"Pants", 29.99, "A latest model Pants"),
                    new Product(6,"Dresses", 119.09, "Very stylish dresses")
            )))
    ));

    public CategroyRepository() {

    }

    public List<Category> getAllCategories() {
        return categories;
    }
    // Ajouter une catégorie
    public void addCategory(Category category) {
        categories.add(category);
    }

    // Supprimer une catégorie par nom
    public void deleteCategory(String name) {
        categories.removeIf(c -> c.getName().equalsIgnoreCase(name));
    }

    // Modifier une catégorie par nom
    public void updateCategory(String originalName, Category updatedCategory) {
        for (Category c : categories) {
            if (c.getName().equalsIgnoreCase(originalName)) {
                c.setName(updatedCategory.getName());
                c.setDescription(updatedCategory.getDescription());
                return;
            }
        }
    }


}
