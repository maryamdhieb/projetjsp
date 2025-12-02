package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.service.CategoryService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", urlPatterns = "/categories")
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
            Category category = new Category(name, description);
            categoryService.addCategory(category);

        } else if ("edit".equals(action)) {
            String originalName = request.getParameter("originalName");
            String newName = request.getParameter("name");
            String description = request.getParameter("description");
            Category updatedCategory = new Category(newName, description);
            categoryService.updateCategory(originalName, updatedCategory);

        } else if ("delete".equals(action)) {
            String name = request.getParameter("name");
            categoryService.deleteCategory(name);
        }

        response.sendRedirect(request.getContextPath() + "/categories");
    }
}
