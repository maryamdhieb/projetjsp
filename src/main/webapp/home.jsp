<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="org.example.model.Promotion" %>
<%@ page import="org.example.service.PromotionService" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    if (categories == null) categories = new java.util.ArrayList<>();

    String selectedCategoryId = request.getParameter("categoryId");
    List<Product> displayProducts = new java.util.ArrayList<>();

    if (selectedCategoryId != null && !selectedCategoryId.isEmpty()) {
        for (Category cat : categories) {
            if (String.valueOf(cat.getId()).equals(selectedCategoryId)) {
                displayProducts = cat.getProducts();
                break;
            }
        }
    } else {
        // Default: show promo products
        for (Category cat : categories) {
            if (cat.getProducts() != null) {
                for (Product p : cat.getProducts()) {
                    if (p.isPromo()) displayProducts.add(p);
                }
            }
        }
    }

    PromotionService promoService = new PromotionService();
    List<Promotion> promos = promoService.getActivePromotions();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sport & Wellness - Premium Fitness Gear</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #ff1a44;
            --primary-dark: #e6002d;
            --text: #1a1a1a;
            --text-light: #555;
            --bg: #f8f9fc;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg);
            color: var(--text);
            line-height: 1.6;
        }

       /* Promotions Ticker Improved */
       .promo-ticker {
           background: var(--primary);
           color: white;
           padding: 12px 0;
           overflow: hidden;
           position: relative;
           box-shadow: 0 4px 20px rgba(255, 26, 68, 0.25);
       }

       .ticker-wrapper {
           white-space: nowrap;
           overflow: hidden;
           position: relative;
       }

       .ticker-content {
           display: inline-flex;
           align-items: center;
           gap: 80px;
           white-space: nowrap;
           animation: ticker 25s linear infinite;
           padding-left: 100%;
       }

       .ticker-content span {
           font-size: 1.15rem;
           font-weight: 500;
       }

       .ticker-content strong {
           font-weight: 700;
       }

       /* Pause animation when hovered */
       .promo-ticker:hover .ticker-content {
           animation-play-state: paused;
       }

       @keyframes ticker {
           0% { transform: translateX(0); }
           100% { transform: translateX(-100%); }
       }


        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.6)), url('assets/img/test1.jpg') center/cover no-repeat;
            height: 90vh;
            min-height: 600px;
            display: flex;
            align-items: center;
            color: white;
        }

        .hero h1 {
            font-size: 4.5rem;
            font-weight: 800;
            line-height: 1.1;
        }

        .hero p {
            font-size: 1.4rem;
            max-width: 600px;
            opacity: 0.95;
        }

        /* Sidebar */
        .sidebar {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            height: fit-content;
            position: sticky;
            top: 100px;
        }

        .sidebar a {
            display: block;
            padding: 12px 16px;
            border-radius: 12px;
            color: var(--text-light);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-bottom: 6px;
        }

        .sidebar a:hover, .sidebar a.active {
            background: var(--primary);
            color: white;
            transform: translateX(8px);
        }

        .sidebar a.active {
            font-weight: 600;
        }

        /* Product Card */
        .product-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .product-img {
            height: 220px;
            object-fit: cover;
            width: 100%;
        }

        .card-body {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .price-old {
            text-decoration: line-through;
            color: #999;
            font-size: 0.95rem;
        }

        .price-new {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
        }

        .badge-promo {
            position: absolute;
            top: 12px;
            left: 12px;
            background: var(--primary);
            color: white;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            z-index: 2;
        }

        .btn-add-cart {
            background: var(--primary);
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-add-cart:hover {
            background: var(--primary-dark);
            transform: scale(1.05);
        }

        h2.section-title {
            font-weight: 700;
            font-size: 2.2rem;
            color: var(--text);
        }
        .btn-add-cart {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border: none;
            font-size: 1.05rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-add-cart:hover {
            background: linear-gradient(135deg, var(--primary-dark), #cc0022);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 26, 68, 0.3) !important;
        }

        @media (max-width: 768px) {
            .hero h1 { font-size: 3rem; }
            .hero p { font-size: 1.2rem; }
            .sidebar { position: static; }
        }
    </style>
</head>
<body>

<jsp:include page="shared/navbar/navbar.jsp" />

<!-- PROMOTION TICKER -->
<% if (promos != null && !promos.isEmpty()) { %>
<div class="promo-ticker">
    <div class="ticker-wrapper">
        <div class="ticker-content">
            <% for (Promotion p : promos) { %>
                <span><strong><%= p.getTitle() %></strong> — <%= p.getDescription() %></span>
            <% } %>

            <% for (Promotion p : promos) { %>
                <span><strong><%= p.getTitle() %></strong> — <%= p.getDescription() %></span>
            <% } %>
        </div>
    </div>
</div>
<% } %>

<!-- HERO SECTION -->
<section class="hero">
    <div class="container">
        <div class="row>
            <div class="col-lg-7">
                <h1>Sport & Wellness</h1>
                <p class="mt-3">Elevate your fitness journey with premium gear designed for performance, comfort, and style.</p>
                <a href="home" class="btn btn-light btn-lg mt-4 px-5 py-3 fw-semibold">Shop Now</a>
            </div>
        </div>
    </div>
</section>

<!-- MAIN CONTENT -->
<div class="container py-5">
    <div class="row">
        <!-- SIDEBAR -->
        <div class="col-md-3 mb-5">
            <div class="sidebar">
                <h5 class="fw-bold mb-4 text-dark">Categories</h5>
                <a href="home" class="<%= (selectedCategoryId == null) ? "active" : "" %>">
                    On Sale Now
                </a>
                <% for (Category cat : categories) { %>
                    <a href="home?categoryId=<%= cat.getId() %>"
                       class="<%= (selectedCategoryId != null && selectedCategoryId.equals(String.valueOf(cat.getId()))) ? "active" : "" %>">
                        <%= cat.getName() %>
                    </a>
                <% } %>
            </div>
        </div>

        <!-- PRODUCTS GRID -->
        <div class="col-md-9">
            <h2 class="section-title mb-5">
                <%= (selectedCategoryId != null) ?
                    "Category: " + categories.stream()
                        .filter(c -> String.valueOf(c.getId()).equals(selectedCategoryId))
                        .findFirst().get().getName()
                    : "Hot Deals & Promotions" %>
            </h2>

            <% if (displayProducts.isEmpty()) { %>
                <div class="text-center py-5">
                    <p class="fs-3 text-muted">No products available in this category yet.</p>
                </div>
            <% } else { %>
                <div class="row g-4">
                    <% for (Product prod : displayProducts) { %>
                        <div class="col-md-6 col-lg-4">
                            <div class="product-card position-relative">
                                <% if (prod.isPromo()) { %>
                                    <span class="badge-promo">SALE</span>
                                <% } %>
                                <img src="https://via.placeholder.com/400x300/111827/ffffff?text=<%= prod.getName().replace(" ", "+") %>"
                                     alt="<%= prod.getName() %>" class="product-img">

                                <div class="card-body">
                                    <h5 class="fw-bold"><%= prod.getName() %></h5>
                                    <p class="text-muted small flex-grow-1"><%= prod.getDescription() %></p>
                                    <p class="text-muted small">Stock: <%= prod.getQuantity() %></p>

                                    <div class="mt-3">
                                        <% if (prod.isPromo()) { %>
                                            <p>
                                                <span class="price-old">$<%= String.format("%.2f", prod.getPrice()) %></span>
                                                <span class="price-new ms-3">$<%= String.format("%.2f", prod.getPromoPrice()) %></span>
                                            </p>
                                        <% } else { %>
                                            <p class="price-new">$<%= String.format("%.2f", prod.getPrice()) %></p>
                                        <% } %>
                                    </div>

                                    <form action="addToCart" method="post" class="mt-auto">
                                        <input type="hidden" name="productId" value="<%= prod.getId() %>">
                                        <button type="submit" class="btn btn-add-cart text-white w-100 mt-2">
                                            Add to Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>