package org.example.service;

import org.example.model.Category;
import org.example.repository.CategroyRepository;

import java.util.List;

public class CategoryService {

    private final CategroyRepository categroyRepository;

    public CategoryService() {
        this.categroyRepository = new CategroyRepository();
    }

    public List<Category> getAllCategories() {
        return categroyRepository.getAllCategories();
    }

    public void addCategory(Category category) {
        categroyRepository.addCategory(category); // utiliser l'instance et non la classe
    }

    public void updateCategory(String originalName, Category updatedCategory) {
        categroyRepository.updateCategory(originalName, updatedCategory);
    }

    public void deleteCategory(String name) {
        categroyRepository.deleteCategory(name);
    }
}
