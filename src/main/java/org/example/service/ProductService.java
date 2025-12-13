package org.example.service;

import org.example.model.Product;
import org.example.repository.ProductRepository;

public class ProductService {

    private final ProductRepository productRepository = new ProductRepository();

    public void addProduct(Product p) {
        productRepository.addProduct(p);
    }

    public void updateProduct(Product p) {
        productRepository.updateProduct(p);
    }

    public void deleteProduct(int id) {
        productRepository.deleteProduct(id);
    }

    public Object getAllProducts() {
        return productRepository.getAllProducts();
    }
}
