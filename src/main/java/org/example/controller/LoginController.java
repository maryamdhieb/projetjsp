package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.User;
import org.example.service.UserService;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("uname");
        String password = request.getParameter("psw");

        // Vérification dans la base via UserService → UserRepository
        Optional<User> user = userService.findUserByEmailAndPwd(email, password);

        if (user.isPresent()) {
            request.getSession().setAttribute("name", user.get().getFullname());
            request.getSession().setAttribute("role", user.get().getRole());
            request.getSession().setAttribute("isAdmin", user.get().getRole().equals("ADMIN"));

            response.sendRedirect("home");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
