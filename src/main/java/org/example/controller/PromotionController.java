package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Promotion;
import org.example.model.Promotion_Product;
import org.example.service.CategoryService;
import org.example.service.PromotionService;
import java.util.List;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "PromotionController", urlPatterns = "/promotions")
public class PromotionController extends HttpServlet {

    private PromotionService promotionService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        promotionService = new PromotionService();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupère toutes les promotions
        List<Promotion> promotions = promotionService.getAllPromotions();
        // Pour chaque promotion, récupérer les produits associés
        for (Promotion p : promotions) {
            p.setProducts(promotionService.getProductsForPromotion(p.getId()));
        }

        request.setAttribute("promotions", promotions);

        // Récupérer toutes les catégories avec leurs produits pour les modals
        request.setAttribute("categories", categoryService.getAllCategoriesWithProducts());

        request.getRequestDispatcher("/promotion.jsp").forward(request, response); // ou promotion.jsp
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double value = Double.parseDouble(request.getParameter("value"));
            String Type = request.getParameter("type");
            LocalDate start = LocalDate.parse(request.getParameter("startDate"));
            LocalDate end = LocalDate.parse(request.getParameter("endDate"));
            String[] selectedProductIds = request.getParameterValues("productIds");
            Promotion promo = new Promotion(0, name, description,  value , Type, start, end);
            promotionService.addPromotionWithProducts(promo, selectedProductIds);


        }else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double value = Double.parseDouble(request.getParameter("value"));
            String Type = request.getParameter("type");
            LocalDate start = LocalDate.parse(request.getParameter("startDate"));
            LocalDate end = LocalDate.parse(request.getParameter("endDate"));
            String[] selectedProductIds = request.getParameterValues("productIds");

            Promotion promo = new Promotion(id, name, description, value, Type, start, end );
            promotionService.updatePromotionWithProducts(promo, selectedProductIds);
        }
        else if("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            promotionService.deletePromotion(id);}

        response.sendRedirect(request.getContextPath() + "/promotions");
    }
}