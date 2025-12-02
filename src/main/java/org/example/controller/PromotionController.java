package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.model.Promotion;
import org.example.service.PromotionService;
import java.time.LocalDate;


import java.io.IOException;
import java.util.List;
@WebServlet(name = "PromotionController", urlPatterns = "/promotions")
public class PromotionController extends HttpServlet {

    private PromotionService promoService;

    @Override
    public void init() {
        promoService = new PromotionService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            int id = promoService.getNextId();
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String type = request.getParameter("type"); // percentage / fixed
            double value = Double.parseDouble(request.getParameter("value"));

            LocalDate start = LocalDate.parse(request.getParameter("startDate"));
            LocalDate end = LocalDate.parse(request.getParameter("endDate"));

            Promotion promotion = new Promotion(id, title, description, type, value, start, end);
            promoService.addPromotion(promotion);
        }

        response.sendRedirect("admin-promotions.jsp");
    }
}
