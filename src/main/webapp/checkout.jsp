<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.CartItem" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart");
        return;
    }

    double total = 0;
    for (CartItem item : cart) {
        total += item.getPrice() * item.getQuantity();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>SportShop</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body { background-color: #f8f9fa; }
        .progress-bar { background-color: #ff6b35; }
        .checkout-card { border-radius: 16px; box-shadow: 0 8px 25px rgba(0,0,0,0.08); }
        .product-img { width: 80px; height: 80px; object-fit: cover; border-radius: 10px; }
        .total-amount { font-size: 1.8rem; color: #ff6b35; }
        .btn-confirm { background-color: #ff6b35; border: none; font-weight: bold; padding: 12px; }
        .btn-confirm:hover { background-color: #e55a2b; transform: translateY(-2px); }
        .sticky-summary { position: sticky; top: 100px;
        }
         .page-header {
             background: linear-gradient(135deg, var(--secondary) 0%, #003D6E 100%);
             padding: 3rem 0;
             color:#d71313;
             border-bottom: 4px solid var(--primary);
             margin-bottom: 3rem;
         }

         .page-title {
             font-size: 3rem;
             font-weight: 900;
             letter-spacing: -1px;
             margin: 0;
             text-transform: uppercase;
         }

         .page-subtitle {
             font-size: 1.2rem;
             opacity: 0.9;
             margin-top: 0.5rem;
             font-weight: 500;
         }
    </style>
</head>
<body>

<jsp:include page="shared/navbar/navbar.jsp" />

<div class="container py-5">
<!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title">
                <i class="fas fa-cogs me-3"></i>Checkout Process
            </h1>
            <p class="page-subtitle">Final step: Order Confirmation</p>
        </div>
    </div>



    <h2 class="fw-bold text-center mb-5">Complete Your Order</h2>

    <form action="checkout" method="post">
        <div class="row g-5">

            <!-- Shipping Information + Payment -->
            <div class="col-lg-7">
                <div class="card checkout-card p-4 mb-4">
                    <h5 class="fw-bold mb-4"><i class="bi bi-truck me-2"></i>Shipping Information</h5>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" name="nom" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" name="prenom" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Full Address</label>
                            <input type="text" class="form-control" name="adresse" placeholder="Street, Building, Apartment..." required>
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">City</label>
                            <input type="text" class="form-control" name="ville" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Postal Code</label>
                            <input type="text" class="form-control" name="codepostal" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" name="telephone" required>
                        </div>
                    </div>

                    <h5 class="fw-bold mt-5 mb-3"><i class="bi bi-credit-card me-2"></i>Payment Method</h5>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="paiement" value="livraison" id="cod" checked>
                        <label class="form-check-label fw-semibold" for="cod">Cash on Delivery (Recommended)</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paiement" value="carte" id="card">
                        <label class="form-check-label" for="card">Credit Card (Coming Soon)</label>
                    </div>
                </div>
            </div>

            <!-- Order Summary -->
            <div class="col-lg-5">
                <div class="card checkout-card p-4 sticky-summary">
                    <h5 class="fw-bold mb-4"><i class="bi bi-cart4 me-2"></i>Order Summary</h5>

                    <div class="border-bottom pb-3 mb-3">
                        <% for (CartItem item : cart) { %>
                        <div class="d-flex align-items-center mb-3">

                            <div class="flex-grow-1">
                                <h6 class="mb-1"><%= item.getProduct().getName() %></h6>
                                <small class="text-muted">Quantity: <%= item.getQuantity() %></small>
                            </div>
                            <span class="fw-semibold"><%= String.format("%.2f", item.getPrice() * item.getQuantity()) %> DT</span>
                        </div>
                        <% } %>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="fs-5">Total Amount</span>
                        <span class="total-amount fw-bold"><%= String.format("%.2f", total) %> DT</span>
                    </div>

                    <button type="submit" class="btn btn-confirm btn-lg w-100  shadow-sm">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        Confirm Order
                    </button>

                    <p class="text-center text-muted small mt-3">
                        <i class="bi bi-shield-lock me-1"></i> Secure Payment • Fast Delivery Across Tunisia
                    </p>
                </div>
            </div>

        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>