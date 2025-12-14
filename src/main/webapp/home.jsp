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

    PromotionService promoService = new PromotionService();
    List<Promotion> activePromotions = promoService.getActivePromotions();

    List<Product> displayProducts = new java.util.ArrayList<>();

    if (selectedCategoryId != null && !selectedCategoryId.isEmpty()) {
        for (Category cat : categories) {
            if (String.valueOf(cat.getId()).equals(selectedCategoryId) && cat.getProducts() != null) {
                displayProducts.addAll(cat.getProducts());
                break;
            }
        }
    } else {
        for (Category cat : categories) {
            if (cat.getProducts() != null) {
                for (Product p : cat.getProducts()) {
                    if (promoService.hasActivePromotion(p, activePromotions)) {
                        displayProducts.add(p);
                    }
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>SportShop</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #FF6B35;
            --primary-dark: #E85A2A;
            --secondary: #004E89;
            --accent: #1A936F;
            --success: #10B981;
            --danger: #EF4444;
            --dark: #1F2937;
            --text-primary: #111827;
            --text-secondary: #6B7280;
            --bg-gray: #F9FAFB;
            --border-color: #E5E7EB;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Promo Ticker */
        .promo-ticker {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 1rem 0;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(255,107,53,0.3);
            position: relative;
        }

        .promo-ticker::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
        }

        .ticker-content {
            display: inline-flex;
            gap: 100px;
            animation: ticker 40s linear infinite;
            padding-left: 100%;
            align-items: center;
        }

        .ticker-content span {
            font-size: 1rem;
            font-weight: 600;
            white-space: nowrap;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .ticker-content strong {
            font-weight: 800;
            text-transform: uppercase;
        }

        .promo-ticker:hover .ticker-content {
            animation-play-state: paused;
        }

        @keyframes ticker {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* Hero Section */
        .hero {
            background:
                        url('assets/img/test1.jpg') center/cover no-repeat;
            min-height: 85vh;
            display: flex;
            align-items: center;
            color: white;
            position: relative;
            overflow: hidden;
        }



        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            font-size: 4.5rem;
            font-weight: 900;
            line-height: 1.1;
            letter-spacing: -2px;
            margin-bottom: 1.5rem;
        }

        .hero p {
            font-size: 1.4rem;
            max-width: 600px;
            opacity: 0.95;
            line-height: 1.7;
            font-weight: 500;
        }

        .btn-hero {
            background: var(--primary);
            border: none;
            padding: 1.25rem 3rem;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 8px 20px rgba(255,107,53,0.4);
        }

        .btn-hero:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 12px 28px rgba(255,107,53,0.5);
        }

        /* Main Content */
        .main-content {
            padding: 4rem 0;
        }

        /* Sidebar */
        .sidebar {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            position: sticky;
            top: 2rem;
        }

        .sidebar-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 3px solid var(--primary);
        }

        .category-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 1.25rem;
            border-radius: 12px;
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-bottom: 0.5rem;
            border: 2px solid transparent;
        }

        .category-link:hover {
            background: var(--bg-gray);
            color: var(--primary);
            transform: translateX(5px);
            border-color: var(--border-color);
        }

        .category-link.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            transform: translateX(8px);
            box-shadow: 0 4px 12px rgba(255,107,53,0.3);
        }

        .category-link i {
            font-size: 1.25rem;
        }

        /* Section Title */
        .section-header {
            margin-bottom: 3rem;
            position: relative;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            letter-spacing: -1px;
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        /* Product Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        /* Product Card */
        .product-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            transition: all 0.4s ease;
            display: flex;
            flex-direction: column;
            border: 2px solid transparent;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            border-color: var(--primary);
        }

        .product-image-wrapper {
            position: relative;
            height: 260px;
            overflow: hidden;
            background: var(--bg-gray);
        }

        .product-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.1);
        }

        .badge-promo {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: var(--danger);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 700;
            text-transform: uppercase;
            z-index: 2;
            box-shadow: 0 4px 12px rgba(239,68,68,0.4);
        }

        .badge-stock {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: rgba(0,0,0,0.7);
            backdrop-filter: blur(10px);
            color: white;
            padding: 0.5rem 0.75rem;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
            z-index: 2;
        }

        .product-body {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-desc {
            font-size: 0.9rem;
            color: var(--text-secondary);
            margin-bottom: 1rem;
            flex-grow: 1;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.5;
        }

        .price-section {
            margin-bottom: 1rem;
        }

        .price-wrapper {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .price-old {
            text-decoration: line-through;
            color: var(--text-secondary);
            font-size: 1rem;
            font-weight: 600;
        }

        .price-new {
            font-size: 1.75rem;
            font-weight: 900;
            color: var(--primary);
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

        .btn-add-cart {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border: none;
            border-radius: 12px;
            padding: 1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            color: white;
            width: 100%;
        }

        .btn-add-cart:hover {
            background: linear-gradient(135deg, var(--primary-dark), #D14E1F);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255,107,53,0.4);
            color: white;
        }

        .btn-add-cart i {
            margin-right: 0.5rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 6rem 2rem;
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }

        .empty-state i {
            font-size: 6rem;
            color: var(--border-color);
            margin-bottom: 2rem;
        }

        .empty-state h3 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .empty-state p {
            font-size: 1.1rem;
            color: var(--text-secondary);
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .hero {
                min-height: 70vh;
                padding: 3rem 0;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .sidebar {
                position: static;
                margin-bottom: 2rem;
            }

            .products-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="shared/navbar/navbar.jsp" />

<!-- PROMOTION TICKER -->
<% if (!activePromotions.isEmpty()) { %>
<div class="promo-ticker">
    <div class="ticker-content">
        <% for (Promotion p : activePromotions) { %>
            <span>
                <i class="bi bi-lightning-charge-fill"></i>
                <strong><%= p.getName() %></strong> — <%= p.getDescription() %>
            </span>
        <% } %>
        <!-- Duplicate for smooth loop -->
        <% for (Promotion p : activePromotions) { %>
            <span>
                <i class="bi bi-lightning-charge-fill"></i>
                <strong><%= p.getName() %></strong> — <%= p.getDescription() %>
            </span>
        <% } %>
    </div>
</div>
<% } %>

<!-- HERO SECTION -->
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <div class="hero-content">
                    <h1>Elevate Your Game</h1>
                    <p class="mt-4">
                        Premium sports equipment designed for champions.
                        Performance meets innovation in every product.
                    </p>
                    <a href="#products" class="btn btn-hero text-white mt-4">
                        <i class="bi bi-bag-fill me-2"></i>Shop Collection
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- MAIN CONTENT -->
<div class="main-content" id="products">
    <div class="container">
        <div class="row">
            <!-- SIDEBAR -->
            <div class="col-lg-3 mb-4">
                <div class="sidebar">
                    <h5 class="sidebar-title">
                        <i class="bi bi-grid-fill me-2"></i>Categories
                    </h5>

                    <a href="home" class="category-link <%= (selectedCategoryId == null) ? "active" : "" %>">
                        <i class="bi bi-fire"></i>
                        <span>Hot Deals</span>
                    </a>

                    <% for (Category cat : categories) { %>
                        <a href="home?categoryId=<%= cat.getId() %>"
                           class="category-link <%= (selectedCategoryId != null && selectedCategoryId.equals(String.valueOf(cat.getId()))) ? "active" : "" %>">
                            <i class="bi bi-tag-fill"></i>
                            <span><%= cat.getName() %></span>
                        </a>
                    <% } %>
                </div>
            </div>

            <!-- PRODUCTS GRID -->
            <div class="col-lg-9">
                <div class="section-header">
                    <h2 class="section-title">
                        <%= selectedCategoryId != null ?
                                categories.stream()
                                        .filter(c -> String.valueOf(c.getId()).equals(selectedCategoryId))
                                        .findFirst()
                                        .map(Category::getName)
                                        .orElse("Products")
                                : "Hot Deals & Promotions" %>
                    </h2>
                    <p class="section-subtitle">
                        <%= displayProducts.size() %> product<%= displayProducts.size() != 1 ? "s" : "" %> available
                    </p>
                </div>

                <% if (displayProducts.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="bi bi-inbox"></i>
                        <h3>No Products Available</h3>
                        <p>Check back soon for new arrivals!</p>
                    </div>
                <% } else { %>
                    <div class="products-grid">
                        <% for (Product prod : displayProducts) {
                            boolean inPromo = promoService.hasActivePromotion(prod, activePromotions);
                            double originalPrice = prod.getPrice();
                            double displayPrice = inPromo ? promoService.getPromoPrice(prod, activePromotions) : originalPrice;
                            double discount = inPromo ? ((originalPrice - displayPrice) / originalPrice * 100) : 0;
                        %>
                            <div class="product-card">
                                <div class="product-image-wrapper">
                                    <% if (inPromo) { %>
                                        <span class="badge-promo">
                                            <i class="bi bi-percent me-1"></i>Sale
                                        </span>
                                    <% } %>

                                    <span class="badge-stock">
                                        <i class="bi bi-box-seam me-1"></i><%= (int) prod.getQuantity() %> in stock
                                    </span>

                                    <img src="data:image/jpeg;base64,<%= prod.getImageBase64() != null ? prod.getImageBase64() : "" %>"
                                         alt="<%= prod.getName() %>"
                                         class="product-img"
                                         onerror="this.src='https://via.placeholder.com/400x300/F3F4F6/9CA3AF?text=<%= prod.getName().replace(" ", "+") %>'">
                                </div>

                                <div class="product-body">
                                    <h5 class="product-name"><%= prod.getName() %></h5>
                                    <p class="product-desc">
                                        <%= prod.getDescription() != null ? prod.getDescription() : "Premium quality sports equipment for peak performance." %>
                                    </p>

                                    <div class="price-section">
                                        <% if (inPromo) { %>
                                            <div class="price-wrapper">
                                                <span class="price-old">$<%= String.format("%.2f", originalPrice) %></span>
                                                <span class="price-new">$<%= String.format("%.2f", displayPrice) %></span>
                                                <span class="discount-badge">-<%= String.format("%.0f", discount) %>%</span>
                                            </div>
                                        <% } else { %>
                                            <span class="price-new">$<%= String.format("%.2f", displayPrice) %></span>
                                        <% } %>
                                    </div>
                                    <% if (prod.getQuantity() > 0) { %>
                                    <form action="addToCart" method="post">
                                        <input type="hidden" name="productId" value="<%= prod.getId() %>">
                                        <button type="submit" class="btn btn-add-cart">
                                            <i class="bi bi-cart-plus-fill"></i>Add to Cart
                                        </button>

                                    </form>
                                    <% } else { %>
                                    <div class="text-center">
                                        <button class="btn btn-secondary" disabled>
                                            <i class="bi bi-x-circle-fill"></i>Out of Stock
                                        </button>

                                      </div>
                                      <%}%>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>