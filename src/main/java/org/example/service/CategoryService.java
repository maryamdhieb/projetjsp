package org.example.service;

import org.example.model.Category;
import org.example.repository.CategoryRepository;

import java.util.List;

public class CategoryService {

    private final CategoryRepository categroyRepository;

    public CategoryService() {
        this.categroyRepository = new CategoryRepository();
    }

    public List<Category> getAllCategories() {
        return categroyRepository.getAllCategories();
    }

    public void addCategory(Category category) {
        categroyRepository.addCategory(category); // utiliser l'instance et non la classe
    }

    public boolean updateCategory(int id, Category updatedCategory) {
        categroyRepository.updateCategory( id, updatedCategory);
        return false;
    }

    public void deleteCategory(int id) {
        categroyRepository.deleteCategory(id);
    }
}
