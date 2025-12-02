package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.model.Product;
import org.example.service.CategoryService;
import org.example.service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductController", urlPatterns = "/products")
public class ProductController extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        categoryService = new CategoryService(); // pour retrouver la catégorie
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String categoryName = request.getParameter("category");

        // retrouver la catégorie
        List<Category> categories = categoryService.getAllCategories();
        Category category = categories.stream()
                .filter(c -> c.getName().equalsIgnoreCase(categoryName))
                .findFirst()
                .orElse(null);

        if (category == null) {
            response.sendRedirect(request.getContextPath() + "/categories");
            return;
        }

        if ("add".equals(action)) {
            int id = category.getProducts()
                    .stream()
                    .mapToInt(Product::getId)
                    .max()
                    .orElse(0) + 1;            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String desc = request.getParameter("description");

            Product product = new Product(id , name, price, desc);
            productService.addProduct(category, product);

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String originalName = request.getParameter("originalName");
            String newName = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String desc = request.getParameter("description");

            Product updatedProduct = new Product(id ,newName, price, desc);
            productService.updateProduct(category, originalName, updatedProduct);

        } else if ("delete".equals(action)) {
            String productName = request.getParameter("productName");
            productService.deleteProduct(category, productName);
        }

        response.sendRedirect(request.getContextPath() + "/categories");
    }
}
