<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* Navbar global */
        .navbar { transition: all 0.3s ease; }

        /* Logo */
        .navbar-brand { font-size: 1.6rem; font-weight: 800; letter-spacing: 1px; }

        /* Liens centraux */
        .navbar-nav .nav-link {
            position: relative;
            margin: 0 12px;
            color: #ff6b35;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link::after {
            content: "";
            position: absolute;
            width: 0;
            height: 3px;
            background-color:#ff6b35;
            left: 50%;
            bottom: -6px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover { color:black; }
        .navbar-nav .nav-link:hover::after { width: 100%; left: 0; }

        /* Panier */
        .cart-icon i { transition: transform 0.3s ease; }
        .cart-icon:hover i { transform: scale(1.15); color: black; }

        /* Badge panier */
        .cart-badge { font-size: 0.7rem; padding: 4px 7px; }

        /* Dropdown utilisateur */
        .dropdown-menu { border-radius: 12px; }
        .dropdown-item:hover { background-color: #ff6b35; color: white !important; }

        .text-primary { color:black !important; }
        .bi-person-circle::before { color:#ff6b35; }
    </style>
</head>

<body>
<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    Integer cartCount = (session.getAttribute("cartCount") != null) ? (Integer) session.getAttribute("cartCount") : 0;
%>

<nav class="navbar navbar-expand-lg bg-white shadow-sm py-3">
    <div class="container-fluid">

        <!-- Logo -->
        <a class="navbar-brand text-primary" href="/servlet-jsp-gr3/home">
             SportShop
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">

            <% if ("ADMIN".equals(role)) { %>
            <!-- Liens Admin -->
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link fw-semibold fs-5" href="/servlet-jsp-gr3/categories">Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold fs-5" href="/servlet-jsp-gr3/promotions">Sales</a>
                </li>
            </ul>
            <% } else { %>
            <!-- Zone droite pour utilisateur normal -->
            <ul class="navbar-nav ms-auto align-items-center">

                <!-- Panier -->
                <li class="nav-item me-4 cart-icon">
                    <a class="nav-link position-relative" href="cart">
                        <i class="bi bi-cart3 fs-3"></i>
                        <% if (cartCount > 0) { %>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-badge">
                            <%= cartCount %>
                        </span>
                        <% } %>
                    </a>
                </li>
            <% } %>

                <!-- Dropdown utilisateur -->
                <% if (name != null) { %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center fw-semibold"
                       href="javascript:void(0);" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-3 me-2 text-primary"></i>
                        <%= name %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                        <!-- Exemple d'autres options : Profil -->
                        <li>
                            <a class="dropdown-item" href="/servlet-jsp-gr3/profile">
                                <i class="bi bi-person me-2"></i>
                                Profil
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <!-- Déconnexion -->
                        <li>
                            <a class="dropdown-item text-danger" href="<%=request.getContextPath()%>/logout">
                                <i class="bi bi-box-arrow-right me-2"></i>
                                Déconnexion
                            </a>
                        </li>
                    </ul>
                </li>
                <% } %>

            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
