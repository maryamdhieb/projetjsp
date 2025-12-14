package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = "/logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer la session et l'invalider
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // supprime toutes les données de session
        }

        // Rediriger vers la page d'accueil ou de login
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
