<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Admin E-commerce Sport • Gestion Catalogue</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Orbitron:wght@700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #ff3b30;        /* rouge vif */
            --primary-dark: #c72e24;   /* rouge foncé */
            --accent: #ff9f1c;         /* orange vif pour badges et accents */
            --accent-dark: #e07b1b;
            --success: #2ecc71;        /* vert pour ajout/succès */
            --dark: #121212;            /* fond général */
            --gray: #1f1f1f;           /* fond cartes */
            --light: #f5f5f5;          /* texte clair secondaire */
            --text: #ffffff;            /* texte principal */
            --text-muted: #aaa;         /* texte secondaire */
        }

        body {
            background: var(--dark);
            color: var(--text);
            font-family: 'Montserrat', sans-serif;
            min-height: 100vh;
        }



        /* Catégorie bannière */
        .category-block {
            position: relative;
            border-radius: 24px;
            overflow: hidden;
            margin-bottom: 60px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.5);
            transition: all 0.4s ease;
        }
        .category-block:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
        }

        .category-banner {
            height: 280px;
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            background-blend-mode: overlay;
        }

        .category-title {
            font-family: 'Orbitron', sans-serif;
            font-size: 4rem;
            font-weight: 900;
            color: #fff;
            text-shadow: 0 8px 20px rgba(0,0,0,0.7);
            letter-spacing: 3px;
        }

        .category-desc {
            background: rgba(0,0,0,0.6);
            padding: 12px 28px;
            border-radius: 50px;
            backdrop-filter: blur(8px);
            font-size: 1.2rem;
            margin-top: 12px;
            color: var(--light);
        }

        /* Grille produits */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding: 35px;
            background: rgba(255,255,255,0.02);
            border-radius: 0 0 24px 24px;
        }

        .product-card {
            background: var(--gray);
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            border: 1px solid rgba(255,59,48,0.2);
            transition: all 0.4s ease;
        }

        .product-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 20px 50px rgba(255,59,48,0.3);
            border-color: var(--primary);
        }

        .product-image {
            height: 240px;
            background: #333;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .product-image::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 70%;
            background: linear-gradient(transparent, var(--gray));
        }

        .product-info {
            padding: 18px 20px;
        }

        .product-name {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 6px;
            color: var(--text);
        }

        .product-desc {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-price {
            font-size: 1.8rem;
            font-weight: 900;
            color: var(--accent);
            font-family: 'Bebas Neue', sans-serif;
        }

        .admin-actions {
            position: absolute;
            top: 12px;
            right: 12px;
            display: flex;
            gap: 8px;
            opacity: 0;
            transition: all 0.3s;
            z-index: 10;
        }

        .product-card:hover .admin-actions {
            opacity: 1;
        }

        .admin-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(0,0,0,0.7);
            border: none;
            color: var(--text);
            font-size: 1.1rem;
            backdrop-filter: blur(8px);
            transition: all 0.3s;
        }

        .admin-btn:hover {
            background: var(--accent-dark);
            transform: scale(1.15);
        }

        .btn-add-product-floating {
            background: var(--success);
            color: var(--text);
            border-radius: 50px;
            font-weight: 700;
            padding: 10px 18px;
            box-shadow: 0 8px 25px rgba(46,204,113,0.4);
        }

        .btn-add-product-floating:hover {
            background: #27ae60;
        }

        .fab-main {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border: none;
            border-radius: 50%;
            font-size: 2rem;
            color: white;
            box-shadow: 0 15px 40px rgba(255,59,48,0.6);
            z-index: 1000;
            transition: all 0.3s;
        }

        .fab-main:hover {
            transform: scale(1.2) rotate(90deg);
            background: linear-gradient(135deg, var(--accent), var(--primary-dark));
        }

        .empty-category {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            border: 2px dashed var(--primary);
            border-radius: 20px;
            background: rgba(255,59,48,0.05);
        }
         /* Modal édition produit  */
         #editProductModal .form-control,
         #editProductModal .form-control:focus {
             background-color: #f8f9fa;
             border: 2px solid transparent;
             transition: all 0.3s ease;
         }

         #editProductModal .form-control:focus {
             border-color: #ff3b30;
             box-shadow: 0 0 0 0.25rem rgba(255, 59, 48, 0.15);
             background-color: white;
         }

         #editProductModal .form-control::placeholder {
             color: #999;
             font-style: italic;
         }

         /* Boutons arrondis et modernes */
         #editProductModal .btn {
             font-weight: 600;
             letter-spacing: 0.5px;
             transition: all 0.3s ease;
         }

         #editProductModal .btn:hover {
             transform: translateY(-2px);
         }

    </style>
</head>
<body>

<jsp:include page="shared/navbar/navbar.jsp" />

<div class="container-fluid px-4">

    <h1 class="page-title"></i>SPORTS CATALOG</h1>
    <p class="page-subtitle">Manage your complete e-commerce product catalog</p>


    <button class="fab-main shadow-lg" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
        <i class="fas fa-plus"></i>
    </button>

    <%
        List<Category> categories = (List<Category>) request.getAttribute("categories");
        String cp = request.getContextPath();

        if (categories != null && !categories.isEmpty()) {
            for (Category cat : categories) {
                String bannerImg = "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&q=80";
                if (cat.getName().toLowerCase().contains("cardio")) bannerImg = "https://images.unsplash.com/photo-1517836357463-d25dfeac68b8?ixlib=rb-4.0.3&auto=format&fit=crop&q=80";
                else if (cat.getName().toLowerCase().contains("musculation")) bannerImg = "https://images.unsplash.com/photo-1581129724900-9d0e2b0252d3?ixlib=rb-4.0.3&auto=format&fit=crop&q=80";
                else if (cat.getName().toLowerCase().contains("yoga")) bannerImg = "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&q=80";
    %>

    <div class="category-block">
        <div class="category-banner" style="background-image: url('<%= bannerImg %>');">
        <button class="admin-btn edit-category-btn"
                data-bs-toggle="modal" data-bs-target="#editCategoryModal"
                data-id="<%= cat.getId() %>"
                data-name="<%= cat.getName() %>"
                data-desc="<%= cat.getDescription() != null ? cat.getDescription().replace("\"","\\\"") : "" %>">
            <i class="fas fa-edit"></i>
        </button>
          <form method="post" action="<%= cp %>/categories" style="display:inline;">
              <input type="hidden" name="action" value="delete"/>
              <input type="hidden" name="id" value="<%= cat.getId() %>"/>

              <button type="submit" class="admin-btn bg-danger"
                      onclick="return confirm('Delete this category ?');">
                  <i class="fas fa-trash"></i>
              </button>
          </form>

        <div>
            <h2 class="category-title"><%= cat.getName().toUpperCase() %></h2>
            <div class="category-desc">
                <%= cat.getDescription() != null ? cat.getDescription() : "Matériel sportif & accessoires" %>
            </div>
        </div>
        </div>
          <button class="btn btn-add-product-floating mt-3"
                data-bs-toggle="modal" data-bs-target="#addProductModal"
                data-category="<%= cat.getId() %>">
            <i class="fas fa-plus "></i>
        </button>

        <div class="product-grid">

            <%
                List<Product> products = cat.getProducts();
                if (products != null && !products.isEmpty()) {
                    for (Product p : products) {
                        String prodImg = "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&q=80";
            %>

            <div class="product-card">
                <div class="product-image" style="background-image: url('<%= prodImg %>')">
                    <div class="admin-actions">
                        <button class="admin-btn edit-product-btn"
                                data-bs-toggle="modal" data-bs-target="#editProductModal"
                                data-id="<%= p.getId() %>"
                                data-category="<%= cat.getName() %>"
                                data-name="<%= p.getName() %>"
                                data-price="<%= p.getPrice() %>"
                                data-desc="<%= p.getDescription() != null ? p.getDescription().replace("\"","\\\"") : "" %>">
                            <i class="fas fa-edit"></i>
                        </button>
                        <form method="post" action="<%= cp %>/products" style="display:inline">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="category" value="<%= cat.getName() %>"/>
                            <input type="hidden" name="productName" value="<%= p.getName() %>"/>
                            <button type="submit" class="admin-btn bg-danger"
                                    onclick="return confirm('delete this product ?')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                    </div>
                </div>
                <div class="product-info">
                    <h3 class="product-name"><%= p.getName() %></h3>
                    <p class="product-desc"><%= p.getDescription() != null ? p.getDescription() : "Produit haut de gamme" %></p>
                    <div class="product-price"><%= String.format("%.2f", p.getPrice()) %> €</div>
                </div>

            </div>

            <% } } else { %>
                <div class="empty-category">
                    <i class="fas fa-box-open"></i>
                    <p class="text-muted mb-5" style="font-size: 1rem;">
                        Soyez le premier à ajouter un article dans <strong><%= cat.getName() %></strong>
                    </p>
                     <button class="btn btn-add-product-floating mt-3"
                            data-bs-toggle="modal" data-bs-target="#addProductModal"
                            data-category="<%= cat.getName() %>">
                        <i class="fas fa-plus "></i>
                    </button>
                </div>
            <% } %>

        </div>
    </div>

    <% } } else { %>

    <div class="text-center py-5 my-5">
        <i class="fas fa-dumbbell display-1 mb-4" style="color: var(--primary); opacity: 0.3;"></i>
        <h2 class="text-white">Votre catalogue est vide</h2>
        <p class="lead text-muted mb-5">Commencez par créer votre première catégorie sportive !</p>
        <button class="btn btn-lg px-5" style="background: var(--primary); color: white; font-size: 1.4rem;"
                data-bs-toggle="modal" data-bs-target="#addCategoryModal">
            <i class="fas fa-plus me-3"></i> Créer la première catégorie
        </button>
    </div>

    <% } %>

</div>

<!---------------------------------------------------- CRUD Category --------------------------------------------------->

<!-- Modal Add Category -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <form class="modal-content shadow-lg border-0 overflow-hidden" method="post" action="<%= cp %>/categories">
            <input type="hidden" name="action" value="add"/>

            <!-- En-tête stylé -->
            <div class="modal-header bg-gradient text-grey border-0 py-4"
                 style="background: linear-gradient(135deg, #ff3b30, #ff6b6b);">
                <h5 class="modal-title fs-3 fw-bold" id="addCategoryModalLabel">
                    <i class="fas fa-trophy me-3"></i> Create New Category
                </h5>
                <button type="button" class="btn-close btn-close-grey" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Corps du modal – fond blanc -->
            <div class="modal-body bg-white p-5">
                <div class="row g-4">

                    <div class="col-12">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-layer-group text-danger me-2"></i> Category Name
                        </label>
                        <input required name="name"
                               class="form-control form-control-lg rounded-pill shadow-sm border-0"
                               maxlength="50"/>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-align-left text-primary me-2"></i> Description
                        </label>
                        <textarea required name="description" rows="4" class="form-control rounded-3 shadow-sm border-0" ></textarea>

                    </div>

                </div>
            </div>

            <!-- Pied de page -->
            <div class="modal-footer bg-light border-0 py-4 px-5 justify-content-between">
                <button type="button" class="btn btn-outline-secondary btn-lg px-5 rounded-pill" data-bs-dismiss="modal">
                    Cancel
                </button>
                <button type="submit" class="btn btn-danger btn-lg px-5 rounded-pill shadow">
                    <i class="fas fa-plus me-2"></i> Create Category
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Edit Category -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <form class="modal-content shadow-lg border-0 overflow-hidden" method="post" action="<%= cp %>/categories">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="id" id="edit-category-id"/>
             <input type="hidden" name="category" id="edit-category"/>
             <input type="hidden" name="originalName" id="edit-originalName"/>
            <div class="modal-header bg-gradient text-grey border-0 py-4" style="background: linear-gradient(135deg, #ff3b30, #ff6b6b);">
                <h5 class="modal-title fs-3 fw-bold" id="editCategoryModalLabel">
                    <i class="fas fa-edit me-3"></i> Edit Category
                </h5>
                <button type="button" class="btn-close btn-close-grey" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body bg-white p-5">
                <div class="row g-4">
                    <div class="col-12">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-layer-group text-danger me-2"></i> Category Name
                        </label>
                        <input required name="name" id="edit-category-name" class="form-control form-control-lg rounded-pill shadow-sm border-0" maxlength="50"/>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-align-left text-primary me-2"></i> Description
                        </label>
                         <textarea required name="description" id="edit-category-desc" rows="4" class="form-control rounded-3 shadow-sm border-0"></textarea>

                    </div>
                </div>
            </div>

            <div class="modal-footer bg-light border-0 py-4 px-5 justify-content-between">
                <button type="button" class="btn btn-outline-secondary btn-lg px-5 rounded-pill" data-bs-dismiss="modal">
                    Cancel
                </button>
                <button type="submit" class="btn btn-danger btn-lg px-3 rounded-pill shadow">
                    <i class="fas fa-save me-2"></i> Save
                </button>
            </div>
        </form>
    </div>
</div>

<!---------------------------------------------------- CRUD Product --------------------------------------------------->

<!-- Modal Add Product -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <form class="modal-content shadow-lg border-0 overflow-hidden" method="post" action="<%= cp %>/products">
            <input type="hidden" name="action" value="add"/>
            <input type="hidden" name="category" id="add-category"/>

            <div class="modal-header bg-gradient text-grey border-0 py-4" style="background: linear-gradient(135deg, #ff3b30, #ff6b6b);">
                <h5 class="modal-title fs-3 fw-bold" id="addProductModalLabel">
                    <i class="fas fa-plus me-3"></i> Add New Product
                </h5>
                <button type="button" class="btn-close btn-close-grey" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body bg-white p-5">
                <div class="row g-4">
                    <div class="col-md-12">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-tag text-danger me-2"></i> Product Name
                        </label>
                        <input required name="name" class="form-control form-control-lg rounded-pill shadow-sm border-0"/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-euro-sign text-success me-2"></i> Price
                        </label>
                        <input required name="price" type="number" step="0.01" class="form-control form-control-lg rounded-pill shadow-sm border-0"/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-align-left text-primary me-2"></i> Description
                        </label>
                        <textarea name="description" rows="3" class="form-control rounded-3 shadow-sm border-0"></textarea>
                    </div>
                </div>
            </div>

            <div class="modal-footer bg-light border-0 py-4 px-5 justify-content-between">
                <button type="button" class="btn btn-outline-secondary btn-lg px-5 rounded-pill" data-bs-dismiss="modal">
                    Cancel
                </button>
                <button type="submit" class="btn btn-success btn-lg px-3 rounded-pill shadow">
                    <i class="fas fa-plus me-2"></i> Add Product
                </button>
            </div>
        </form>
    </div>
</div>


<!-- Modal Edit Product  -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <form class="modal-content shadow-lg border-0 overflow-hidden" method="post" action="<%= cp %>/products">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="category" id="edit-category"/>
            <input type="hidden" name="originalName" id="edit-originalName"/>
            <input type="hidden" name="id" id="edit-id"/>

            <!-- En-tête stylé -->
            <div class="modal-header bg-gradient text-grey border-0 py-4" style="background: linear-gradient(135deg, #ff3b30, #ff6b6b);">
                <h5 class="modal-title fs-3 fw-bold" id="editProductModalLabel">
                    <i class="fas fa-edit me-3"></i> Modify Product
                </h5>
                <button type="button" class="btn-close btn-close-grey" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Corps du modal – fond blanc propre -->
            <div class="modal-body bg-white p-5">
                <div class="row g-4">

                    <div class="col-md-12">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-tag text-danger me-2"></i>Product Name
                        </label>
                        <input required name="name" id="edit-name" class="form-control form-control-lg rounded-pill shadow-sm border-0"/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-euro-sign text-success me-2"></i> Price
                        </label>
                        <input required name="price" id="edit-price" type="number" step="0.01"
                               class="form-control form-control-lg rounded-pill shadow-sm border-0"/>

                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold text-dark fs-5">
                            <i class="fas fa-align-left text-primary me-2"></i> Description
                        </label>
                        <textarea name="description" id="edit-desc" rows="3" class="form-control rounded-3 shadow-sm border-0"> </textarea>

                    </div>

                </div>
            </div>

            <!-- Pied de page -->
            <div class="modal-footer bg-light border-0 py-4 px-5 justify-content-between">
                <button type="button" class="btn btn-outline-secondary btn-lg px-5 rounded-pill" data-bs-dismiss="modal">
                    Cancel
                </button>
                <button type="submit" class="btn btn-danger btn-lg px-3 rounded-pill shadow">
                    <i class="fas fa-save me-2"></i> Save
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    //modal ajout categories
  document.querySelectorAll('[data-bs-target="#addProductModal"]').forEach(btn => {
        btn.addEventListener('click', () => {
            document.getElementById('add-category')?.setAttribute('value', btn.dataset.category);
        });
    });
    // Open edit category modal
    document.querySelectorAll('.edit-category-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.getElementById('edit-category-id').value = btn.dataset.id;
            document.getElementById('edit-category-name').value = btn.dataset.name;
            document.getElementById('edit-category-desc').value = btn.dataset.desc;
        });
    });

    // Open delete category modal
    document.querySelectorAll('.delete-category-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.getElementById('delete-category-id').value = btn.dataset.id;
            document.getElementById('delete-category-name').innerText = btn.dataset.name;
        });
    });

    // Pré-remplir modal édition produit
   document.querySelectorAll('.edit-product-btn').forEach(btn => {
       btn.addEventListener('click', () => {
           document.getElementById('edit-id').value = btn.dataset.id;
           document.getElementById('edit-category').value = btn.dataset.category;
           document.getElementById('edit-originalName').value = btn.dataset.name;
           document.getElementById('edit-name').value = btn.dataset.name;
           document.getElementById('edit-price').value = btn.dataset.price;
           document.getElementById('edit-desc').value = btn.dataset.desc;
       });
   });

</script>





</body>
</html>
