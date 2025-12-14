package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.User;
import org.example.repository.UserRepository;

import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    private UserRepository userRepository;

    @Override
    public void init() throws ServletException {
        userRepository = new UserRepository();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Vérifier si l'email existe déjà
        if (userRepository.findUserByEmailAndPwd(email, password).isPresent()) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }


        User newUser = new User(email, password, fullname, "CLIENT");
        userRepository.addUser(newUser);


        response.sendRedirect("index.jsp");
    }
}
