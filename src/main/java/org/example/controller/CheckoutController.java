package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.CartItem;
import org.example.model.Order;
import org.example.repository.OrderItemRepository;
import org.example.repository.OrderRepository;
import org.example.repository.ProductRepository;

import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    private final OrderRepository orderRepo = new OrderRepository();
    private final OrderItemRepository itemRepo = new OrderItemRepository();
    private final ProductRepository productRepo = new ProductRepository();

    // ✅ AFFICHER LA PAGE CHECKOUT
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    // ✅ TRAITER LA COMMANDE
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        double total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }

        // 1️⃣ Créer la commande
        Order order = new Order();
        order.setUserId(userId);
        order.setNom(request.getParameter("nom"));
        order.setPrenom(request.getParameter("prenom"));
        order.setAdresse(request.getParameter("adresse"));
        order.setVille(request.getParameter("ville"));
        order.setTelephone(request.getParameter("telephone"));
        order.setPaiement(request.getParameter("paiement"));
        order.setTotal(total);

        int orderId = orderRepo.saveOrder(order);

        // 2️⃣ Sauvegarder les items
        itemRepo.saveItems(orderId, cart);

        // 3️⃣ Diminuer le stock
        boolean stockOk = true;
        for (CartItem item : cart) {
            boolean success = productRepo.decreaseStock(item.getProduct().getId(), item.getQuantity());
            if (!success) {
                stockOk = false;
                break;
            }
        }

        if (!stockOk) {
            request.setAttribute("error", "Stock insuffisant pour certains produits");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // 4️⃣ Vider le panier
        session.removeAttribute("cart");
        session.setAttribute("cartCount", 0);

        // 5️⃣ Rediriger vers la page succès
        response.sendRedirect("checkout-success.jsp");
    }
}
