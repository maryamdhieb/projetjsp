package org.example.service;

import org.example.model.Category;
import org.example.model.Product;
import org.example.repository.ProductRepository;

public class ProductService {

    private final ProductRepository productRepository;

    public ProductService() {
        this.productRepository = new ProductRepository();
    }

    public void addProduct(Category category, Product product) {
        productRepository.addProduct(category, product);
    }

    public void updateProduct(Category category, String originalName, Product updatedProduct) {
        productRepository.updateProduct(category, originalName, updatedProduct);
    }

    public void deleteProduct(Category category, String productName) {
        productRepository.deleteProduct(category, productName);
    }
}
