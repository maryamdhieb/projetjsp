<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.CartItem" %>
<%
    List<CartItem> cart = (List<CartItem>) request.getAttribute("cartItems");
    if (cart == null) cart = new java.util.ArrayList<>();

    double total = 0;
    for (CartItem item : cart) {
        double price = item.getProduct().getEffectivePrice();
        total += price * item.getQuantity();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #FF6B35;
            --primary-dark: #E85A2A;
            --secondary: #004E89;
            --accent: #1A936F;
            --dark: #1F2937;
            --text-primary: #111827;
            --text-secondary: #6B7280;
            --bg-gray: #F9FAFB;
            --border-color: #E5E7EB;
            --success: #10B981;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Header Section */
        .cart-header {
            background: linear-gradient(135deg, #ed7c2b 0%, #6e0000 100%);
            padding: 2.5rem 0;
            color: white;
            border-bottom: 4px solid var(--primary);
        }

        .cart-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin: 0;
        }

        .cart-badge {
            background: var(--primary);
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
        }

        /* Main Container */
        .cart-main {
            padding: 3rem 0;
        }

        /* Cart Items Section */
        .cart-items-section {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            overflow: hidden;
        }

        .section-title {
            background: var(--bg-gray);
            padding: 1.5rem 2rem;
            border-bottom: 2px solid var(--border-color);
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .cart-item {
            padding: 2rem;
            border-bottom: 1px solid var(--border-color);
            transition: all 0.2s ease;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item:hover {
            background-color: #FEFEFE;
        }

        .product-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .product-image:hover {
            transform: scale(1.05);
        }

        .product-info h5 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .product-category {
            display: inline-block;
            background: var(--bg-gray);
            color: var(--text-secondary);
            padding: 0.25rem 0.75rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.75rem;
        }

        .price-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .price-original {
            color: var(--text-secondary);
            font-size: 1rem;
            text-decoration: line-through;
        }

        .price-current {
            color: var(--primary);
            font-weight: 800;
            font-size: 1.5rem;
        }

        .discount-badge {
            background: var(--success);
            color: white;
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        /* Quantity Controls */
        .quantity-section {
            background: var(--bg-gray);
            padding: 1rem;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            gap: 1rem;
        }

        .qty-label {
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .quantity-btn {
            width: 40px;
            height: 40px;
            border: 2px solid var(--border-color);
            background: white;
            color: var(--text-primary);
            border-radius: 10px;
            font-size: 1.25rem;
            font-weight: bold;
            transition: all 0.2s;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-btn:hover:not(:disabled) {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        .quantity-btn:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        .quantity-display {
            width: 60px;
            height: 40px;
            text-align: center;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            font-weight: 700;
            font-size: 1.1rem;
            background: white;
        }

        /* Line Total */
        .line-total-section {
            text-align: right;
        }

        .line-total-label {
            font-size: 0.875rem;
            color: var(--text-secondary);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .line-total-amount {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-top: 0.25rem;
        }

        /* Remove Button */
        .remove-btn {
            background: transparent;
            border: 2px solid #EF4444;
            color: #EF4444;
            padding: 0.6rem 1.25rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s;
            cursor: pointer;
        }

        .remove-btn:hover {
            background: #EF4444;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Order Summary */
        .order-summary {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            padding: 2rem;
            position: sticky;
            top: 2rem;
        }

        .summary-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            font-size: 1rem;
        }

        .summary-row.subtotal {
            color: var(--text-secondary);
        }

        .summary-row.total {
            padding: 1.5rem 0 0;
            margin-top: 1rem;
            border-top: 2px solid var(--border-color);
            font-size: 1.25rem;
        }

        .summary-label {
            font-weight: 600;
        }

        .summary-value {
            font-weight: 700;
        }

        .summary-row.total .summary-value {
            color: var(--primary);
            font-size: 2rem;
            font-weight: 900;
        }

        .shipping-badge {
            background: linear-gradient(135deg, var(--accent), #15805E);
            color: white;
            padding: 0.75rem;
            border-radius: 10px;
            text-align: center;
            margin: 1.5rem 0;
            font-weight: 600;
        }

        .btn-checkout {
            width: 100%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border: none;
            padding: 1.25rem;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 12px;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 14px rgba(255, 107, 53, 0.4);
        }

        .btn-checkout:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 107, 53, 0.5);
            color: white;
        }

        .continue-shopping {
            display: block;
            text-align: center;
            margin-top: 1.25rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .continue-shopping:hover {
            color: var(--primary);
        }

        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 5rem 2rem;
        }

        .empty-cart-icon {
            font-size: 6rem;
            color: var(--border-color);
            margin-bottom: 2rem;
        }

        .empty-cart h3 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .empty-cart p {
            font-size: 1.1rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }

        /* Security Badge */
        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem;
            background: var(--bg-gray);
            border-radius: 10px;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .security-badge i {
            color: var(--success);
            font-size: 1.25rem;
        }

        /* Responsive */
        @media (max-width: 991px) {
            .order-summary {
                position: static;
                margin-top: 2rem;
            }
        }
          @media (min-width: 768px) {
              .col-md-2 {
                  /* flex: 0 0 auto; */
                  /* width: 16.66666667%; */
              }
          }

        @media (max-width: 768px) {
            .cart-header {
                padding: 2rem 0;
            }

            .cart-header h1 {
                font-size: 1.75rem;
            }

            .cart-item {
                padding: 1.5rem;
            }

            .product-image {
                width: 100px;
                height: 100px;
            }

            .quantity-section,
            .line-total-section,
            .remove-btn {
                width: 100%;
                justify-content: center;
            }

            .line-total-section {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<jsp:include page="shared/navbar/navbar.jsp" />

<!-- Cart Header -->
<div class="cart-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <h1><i class="bi bi-cart-check-fill me-3"></i>Shopping Cart</h1>
            <span class="cart-badge"><%= cart.size() %> Item<%= cart.size() != 1 ? "s" : "" %></span>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="cart-main">
    <div class="container">
        <% if (cart.isEmpty()) { %>
            <div class="cart-items-section">
                <div class="empty-cart">
                    <i class="bi bi-cart-x empty-cart-icon"></i>
                    <h3>Your Cart is Empty</h3>
                    <p>Start adding your favorite sports gear to get started!</p>
                    <a href="home" class="btn btn-checkout" style="max-width: 300px; margin: 0 auto;">
                        <i class="bi bi-arrow-left me-2"></i>Start Shopping
                    </a>
                </div>
            </div>
        <% } else { %>
            <div class="row g-4">
                <!-- Cart Items -->
                <div class="col-lg-8">
                    <div class="cart-items-section">
                        <div class="section-title">
                            <i class="bi bi-bag-check-fill me-2"></i>Items in Your Cart
                        </div>

                        <% for (CartItem item : cart) {
                            double unitPrice = item.getProduct().getEffectivePrice();
                            double lineTotal = unitPrice * item.getQuantity();
                            boolean hasDiscount = item.getProduct().getPromoPrice() != null;
                            double discount = hasDiscount ?
                                ((item.getProduct().getPrice() - unitPrice) / item.getProduct().getPrice() * 100) : 0;
                        %>
                        <div class="cart-item">
                            <div class="row g-4 align-items-center">
                                <!-- Product Image & Info -->
                                <div class="col-md-5">
                                    <div class="d-flex gap-3 align-items-start">
                                        <img src="data:image/jpeg;base64,<%= item.getProduct().getImageBase64() != null ? item.getProduct().getImageBase64() : "" %>"
                                             alt="<%= item.getProduct().getName() %>"
                                             class="product-image"
                                             onerror="this.src='https://via.placeholder.com/120?text=No+Image'">
                                        <div class="product-info">
                                            <h5><%= item.getProduct().getName() %></h5>
                                            <span class="product-category">
                                                <i class="bi bi-tag-fill me-1"></i>Sports Equipment
                                            </span>
                                            <div class="price-info">
                                                <% if (hasDiscount) { %>
                                                    <span class="price-original">$<%= String.format("%.2f", item.getProduct().getPrice()) %></span>
                                                    <span class="price-current">$<%= String.format("%.2f", unitPrice) %></span>
                                                    <span class="discount-badge">-<%= String.format("%.0f", discount) %>%</span>
                                                <% } else { %>
                                                    <span class="price-current">$<%= String.format("%.2f", unitPrice) %></span>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Quantity Controls -->
                                <div class="col-md-3">
                                    <div class="quantity-section">
                                        <span class="qty-label">Qty</span>
                                        <div class="quantity-controls">
                                            <form action="updateCart" method="post" class="d-inline">
                                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                                <input type="hidden" name="newQuantity" value="<%= item.getQuantity() - 1 %>">
                                                <button type="submit" class="quantity-btn" <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                                    <i class="bi bi-dash-lg"></i>
                                                </button>
                                            </form>
                                            <input type="text" value="<%= item.getQuantity() %>" class="quantity-display" readonly>
                                            <form action="updateCart" method="post" class="d-inline">
                                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                                <input type="hidden" name="newQuantity" value="<%= item.getQuantity() + 1 %>">
                                                <button type="submit" class="quantity-btn">
                                                    <i class="bi bi-plus-lg"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                               <br>

                                <!-- Remove Button -->
                                <div class="col-md-2">
                                    <form action="updateCart" method="post"
                                          onsubmit="return confirm('Remove this item from your cart?');">
                                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                        <input type="hidden" name="newQuantity" value="0">
                                        <button type="submit" class="remove-btn w-100">
                                            <i class="bi bi-trash3-fill me-2"></i>Remove
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="col-lg-4">
                    <div class="order-summary">
                        <h3 class="summary-title">Order Summary</h3>

                        <div class="summary-row subtotal">
                            <span class="summary-label">Subtotal (<%= cart.size() %> items)</span>
                            <span class="summary-value">$<%= String.format("%.2f", total) %></span>
                        </div>

                        <div class="summary-row subtotal">
                            <span class="summary-label">Shipping</span>
                            <span class="summary-value">FREE</span>
                        </div>

                        <div class="shipping-badge">
                            <i class="bi bi-truck me-2"></i>Free Shipping on Orders Over $50!
                        </div>

                        <div class="summary-row total">
                            <span class="summary-label">Total</span>
                            <span class="summary-value">$<%= String.format("%.2f", total) %></span>
                        </div>

                        <a href="checkout" class="btn btn-checkout mt-3">
                            <i class="bi bi-lock-fill me-2"></i>Secure Checkout
                        </a>

                        <a href="home" class="continue-shopping">
                            <i class="bi bi-arrow-left me-2"></i>Continue Shopping
                        </a>

                        <div class="security-badge">
                            <i class="bi bi-shield-fill-check"></i>
                            <span>Secure SSL Encrypted Payment</span>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>