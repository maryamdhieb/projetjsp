<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.CartItem" %>

<%
    List<CartItem> cart = (List<CartItem>) request.getAttribute("cartItems");
    if (cart == null) cart = new java.util.ArrayList<>();

    // Calcul du total
    double total = 0;
    for (CartItem item : cart) {
        double price = item.getProduct().isPromo() ? item.getProduct().getPromoPrice() : item.getProduct().getPrice();
        total += price * item.getQuantity();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #ff1a44;
            --primary-dark: #e6002d;
            --gray-light: #f8e8e93;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
            min-height: 100vh;
        }

        .cart-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .cart-header {
            background: var(--primary);
            color: white;
            padding: 2rem;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .cart-item {
            padding: 1.5rem;
            border-bottom: 1px solid #eee;
            transition: background 0.3s;
        }

        .cart-item:hover {
            background: #f9f9f9;
        }

        .quantity-btn {
            width: 36px;
            height: 36px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 10px;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s;
        }

        .quantity-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .quantity-input {
            width: 60px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 8px;
            margin: 0 8px;
        }

        .remove-btn {
            color: #ff3b30;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .remove-btn:hover {
            color: #d70015;
            text-decoration: underline;
        }

        .price-final {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--primary);
        }

        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--gray-light);
        }

        .empty-cart i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
    </style>
</head>
<body class="pt-5">

<jsp:include page="shared/navbar/navbar.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <div class="cart-container">

                <!-- Header -->
                <div class="cart-header d-flex justify-content-between align-items-center">
                    <span>Your Shopping Cart</span>
                    <span class="fs-5 fw-normal"><%= cart.size() %> item<%= cart.size() != 1 ? "s" : "" %></span>
                </div>

                <!-- Cart Items -->
                <div class="cart-body">
                    <% if (cart.isEmpty()) { %>
                        <div class="empty-cart">
                            <i class="bi bi-cart3"></i>
                            <h3>Your cart is empty</h3>
                            <p>Looks like you haven't added anything yet.</p>
                            <a href="home" class="btn btn-primary btn-lg mt-3 px-5" style="background:var(--primary); border:none;">
                                Continue Shopping
                            </a>
                        </div>
                    <% } else { %>

                        <% for (CartItem item : cart) {
                            double unitPrice = item.getProduct().isPromo() ? item.getProduct().getPromoPrice() : item.getProduct().getPrice();
                            double lineTotal = unitPrice * item.getQuantity();
                        %>
                        <div class="cart-item d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <div class="d-flex align-items-center gap-4 flex-grow-1">
                                <img src="https://via.placeholder.com/100x80/111827/ffffff?text=<%= item.getProduct().getName().replace(" ", "+") %>"
                                     alt="<%= item.getProduct().getName() %>" class="rounded-3" style="width:100px; height:80px; object-fit:cover;">

                                <div>
                                    <h5 class="mb-1 fw-semibold"><%= item.getProduct().getName() %></h5>
                                    <p class="text-muted small mb-0">
                                        <% if (item.getProduct().isPromo()) { %>
                                            <del>$<%= String.format("%.2f", item.getProduct().getPrice()) %></del>
                                            <span class="text-danger fw-bold">$<%= String.format("%.2f", unitPrice) %></span>
                                        <% } else { %>
                                            $<%= String.format("%.2f", unitPrice) %>
                                        <% } %>
                                    </p>
                                </div>
                            </div>

                            <!-- Quantity Controls -->
                            <div class="d-flex align-items-center">
                                <form action="updateCart" method="post" class="d-inline">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                    <input type="hidden" name="newQuantity" value="<%= item.getQuantity() - 1 %>">
                                    <button type="submit" class="quantity-btn" <%= item.getQuantity() <= 1 ? "disabled" : "" %>>−</button>
                                </form>

                                <input type="text" value="<%= item.getQuantity() %>" class="quantity-input" readonly>

                                <form action="updateCart" method="post" class="d-inline">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                    <input type="hidden" name="newQuantity" value="<%= item.getQuantity() + 1 %>">
                                    <button type="submit" class="quantity-btn">+</button>
                                </form>
                            </div>

                            <!-- Line Total -->
                            <div class="text-end" style="min-width:120px;">
                                <div class="fw-bold fs-5">$<%= String.format("%.2f", lineTotal) %></div>
                            </div>

                            <!-- Remove Button -->
                           <div>
                               <form action="/servlet-jsp-gr3/cart" method="post"
                                     onsubmit="return confirm('Remove this item from cart?');"
                                     style="display: inline;">
                                   <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                   <button type="submit" class="remove-btn border-0 bg-transparent text-danger fw-medium">
                                       <i class="bi bi-trash3 me-1"></i> Remove
                                   </button>
                               </form>
                           </div>
                        </div>
                        <% } %>

                        <!-- Total & Checkout -->
                        <div class="p-4 bg-light">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0 fw-bold">Total</h4>
                                <span class="price-final">$<%= String.format("%.2f", total) %></span>
                            </div>

                            <div class="text-center">
                                <a href="checkout" class="btn btn-lg text-white px-5 py-3 rounded-3"
                                   style="background:var(--primary); font-weight:600; font-size:1.1rem;">
                                    Proceed to Checkout
                                </a>
                                <div class="mt-3">
                                    <a href="home" class="text-muted">Continue Shopping</a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>