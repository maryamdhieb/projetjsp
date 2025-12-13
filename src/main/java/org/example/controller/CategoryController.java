package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.model.Category;
import org.example.service.CategoryService;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "CategoryController", urlPatterns = "/categories")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class CategoryController extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        request.setAttribute("categories", categories);
        request.setAttribute("contextPath", request.getContextPath());

        request.getRequestDispatcher("categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Part imagePart = request.getPart("image");
            byte[] image = getImageBytes(imagePart);

            Category category = new Category(name, description, image);
            categoryService.addCategory(category);

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String newName = request.getParameter("name");
            String description = request.getParameter("description");
            Part imagePart = request.getPart("image");
            byte[] image = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                image = getImageBytes(imagePart); // Nouvelle image
            }

            Category updatedCategory = new Category(newName, description, image);
            boolean success = categoryService.updateCategory(id, updatedCategory);
            if (!success) {
                request.setAttribute("error", "Catégorie introuvable !");
            }

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryService.deleteCategory(id);
        }

        response.sendRedirect(request.getContextPath() + "/categories");
    }
    private byte[] getImageBytes(Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        try (InputStream inputStream = part.getInputStream()) {
            return inputStream.readAllBytes();
        }
    }
}
