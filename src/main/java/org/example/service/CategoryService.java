package org.example.service;

import org.example.model.Category;
import org.example.repository.CategoryRepository;

import java.util.List;

public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService() {
        this.categoryRepository = new CategoryRepository();
    }


    public List<Category> getAllCategories() {
        return categoryRepository.getAllCategories();
    }

    public void addCategory(Category category) {
        categoryRepository.addCategory(category);
    }

    public boolean updateCategory(int id, Category updatedCategory) {
        return categoryRepository.updateCategory(id, updatedCategory);
    }

    public void deleteCategory(int id) {
        categoryRepository.deleteCategory(id);
    }
    public static List<Category> getAllCategoriesWithProducts() {
        CategoryRepository categoryRepository = new CategoryRepository();
        return categoryRepository.getAllCategories();
    }
}
