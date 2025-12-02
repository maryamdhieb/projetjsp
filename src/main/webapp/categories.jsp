<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catégories et Produits</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; color: #343a40; }
        .card-category { transition: transform .15s ease, box-shadow .15s ease; }
        .card-category:hover { transform: translateY(-6px); box-shadow: 0 10px 24px rgba(0,0,0,0.08); }
        .product-badge { font-size: 0.85rem; }
        .product-actions .btn { padding: .25rem .5rem; font-size: .85rem; }
    </style>
</head>
<body>
<jsp:include page="shared/navbar/navbar.jsp" />

<div class="container my-5">
    <h1 class="mb-4 text-center">Gestion des Catégories et Produits</h1>

    <div class="text-end mb-3">
        <!-- Bouton Ajouter catégorie -->
        <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
            + Ajouter catégorie
        </button>
    </div>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String cp = request.getContextPath();
    if (categories != null && !categories.isEmpty()) {
%>
    <div class="row g-4">
        <% for (Category cat : categories) { %>
        <div class="col-12 col-md-6 col-lg-4">
            <div class="card category-card h-100 shadow-sm">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h4 class="card-title text-primary"><%= cat.getName() %></h4>
                            <p class="card-text text-muted"><%= cat.getDescription() != null ? cat.getDescription() : "(Pas de description)" %></p>
                        </div>
                        <div class="text-end">
                            <!-- Actions catégorie -->
                            <button class="btn btn-outline-primary btn-sm edit-category-btn"
                                    data-bs-toggle="modal" data-bs-target="#editCategoryModal"
                                    data-name="<%= cat.getName() %>"
                                    data-desc="<%= cat.getDescription() != null ? cat.getDescription().replace("\"","'") : "" %>">
                                Modifier
                            </button>

                            <form class="d-inline" method="post" action="<%= cp %>/categories" onsubmit="return confirm('Confirmez-vous la suppression de cette catégorie ?');">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="name" value="<%= cat.getName() %>"/>
                                <button type="submit" class="btn btn-outline-danger btn-sm">Delete</button>
                            </form>

                            <!-- Ajouter produit -->
                            <button class="btn btn-sm btn-success mt-2" data-bs-toggle="modal" data-bs-target="#addProductModal"
                                    data-category="<%= cat.getName() %>">
                                + Add product
                            </button>

                            <div class="badge bg-info text-dark product-badge mt-1"><%= cat.getProducts() != null ? cat.getProducts().size() : 0 %> produits</div>
                        </div>
                    </div>

                    <h6 class="mt-3">Produits :</h6>
                    <ul class="list-group list-group-flush">
                        <%
                            List<Product> products = cat.getProducts();
                            if (products != null && !products.isEmpty()) {
                                for (Product product : products) {
                        %>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div style="max-width:55%;"><strong><%= product.getName() %></strong><br/>
                                <small class="text-muted"><%= product.getDescription() != null ? product.getDescription() : "" %></small>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <span class="badge bg-secondary product-badge"><%= product.getPrice() %> €</span>
                                <div class="product-actions">
                                    <!-- Modifier produit -->
                                    <button class="btn btn-outline-primary btn-sm edit-product-btn"
                                            data-bs-toggle="modal" data-bs-target="#editProductModal"
                                            data-category="<%= cat.getName() %>"
                                            data-name="<%= product.getName().replace("\"","'") %>"
                                            data-price="<%= product.getPrice() %>"
                                            data-desc="<%= product.getDescription() != null ? product.getDescription().replace("\"","'") : "" %>">
                                        Modify
                                    </button>
                                    <!-- Supprimer produit -->
                                    <form class="d-inline" method="post" action="<%= cp %>/products" onsubmit="return confirm('Confirmez-vous la suppression de ce produit ?');">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="category" value="<%= cat.getName() %>"/>
                                        <input type="hidden" name="productName" value="<%= product.getName() %>"/>
                                        <button type="submit" class="btn btn-outline-danger btn-sm">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </li>
                        <%      }
                            } else { %>
                        <li class="list-group-item text-center text-muted">Aucun produit pour cette catégorie.</li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
        <% } %>
    </div>
<% } else { %>
    <div class="alert alert-info text-center">Aucune catégorie trouvée.</div>
<% } %>
</div>

<!-- Modals Catégorie -->
<div class="modal fade" id="addCategoryModal">
  <div class="modal-dialog">
    <form class="modal-content" method="post" action="<%= cp %>/categories">
        <input type="hidden" name="action" value="add"/>
      <div class="modal-header"><h5 class="modal-title">Add category</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
          <div class="mb-3"><label>Name</label><input required name="name" class="form-control"/></div>
          <div class="mb-3"><label>Description</label><textarea name="description" class="form-control"></textarea></div>
      </div>
      <div class="modal-footer"><button type="submit" class="btn btn-success">Add</button></div>
    </form>
  </div>
</div>

<div class="modal fade" id="editCategoryModal">
  <div class="modal-dialog">
    <form class="modal-content" method="post" action="<%= cp %>/categories">
        <input type="hidden" name="action" value="edit"/>
        <input type="hidden" name="originalName" id="edit-cat-originalName"/>
      <div class="modal-body">
          <div class="mb-3"><label>Nom</label><input required name="name" id="edit-cat-name" class="form-control"/></div>
          <div class="mb-3"><label>Description</label><textarea name="description" id="edit-cat-desc" class="form-control"></textarea></div>
      </div>
      <div class="modal-footer"><button type="submit" class="btn btn-primary">Save</button></div>
    </form>
  </div>
</div>

<!-- Modals Produit -->
<div class="modal fade" id="addProductModal">
  <div class="modal-dialog">
    <form class="modal-content" method="post" action="<%= cp %>/products">
        <input type="hidden" name="action" value="add"/>
        <input type="hidden" name="category" id="add-category"/>
      <div class="modal-header"><h5 class="modal-title">Add product to</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
          <div class="mb-3"><label>Name</label><input required name="name" class="form-control"/></div>
          <div class="mb-3"><label>Price(€)</label><input required name="price" type="number" step="0.01" class="form-control"/></div>
          <div class="mb-3"><label>Description</label><textarea required name="description" class="form-control"></textarea></div>
      </div>
      <div class="modal-footer"><button type="submit" class="btn btn-success">Add</button></div>
    </form>
  </div>
</div>

<div class="modal fade" id="editProductModal">
  <div class="modal-dialog">
    <form class="modal-content" method="post" action="<%= cp %>/products">
        <input type="hidden" name="action" value="edit"/>
        <input type="hidden" name="category" id="edit-category"/>
        <input type="hidden" name="originalName" id="edit-originalName"/>
      <div class="modal-body">
          <div class="mb-3"><label>Nom</label><input required name="name" id="edit-name" class="form-control"/></div>
          <div class="mb-3"><label>Prix (€)</label><input required name="price" id="edit-price" type="number" step="0.01" class="form-control"/></div>
          <div class="mb-3"><label>Description</label><input required name="description" id="edit-desc" class="form-control"/></div>
      </div>
      <div class="modal-footer"><button type="submit" class="btn btn-primary">Save</button></div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Pré-remplir modal ajout produit
    document.addEventListener('click', function(e){
        const addBtn = e.target.closest('[data-bs-target="#addProductModal"]');
        if (addBtn) document.getElementById('add-category').value = addBtn.getAttribute('data-category') || '';
    });

    // Pré-remplir modal édition produit
    document.querySelectorAll('.edit-product-btn').forEach(btn=>{
        btn.addEventListener('click', ()=>{
            document.getElementById('edit-category').value = btn.getAttribute('data-category');
            document.getElementById('edit-originalName').value = btn.getAttribute('data-name');
            document.getElementById('edit-name').value = btn.getAttribute('data-name');
            document.getElementById('edit-price').value = btn.getAttribute('data-price');
            document.getElementById('edit-desc').value = btn.getAttribute('data-desc');
        });
    });

    // Pré-remplir modal édition catégorie
    document.querySelectorAll('.edit-category-btn').forEach(btn=>{
        btn.addEventListener('click', ()=>{
            document.getElementById('edit-cat-name').value = btn.getAttribute('data-name');
            document.getElementById('edit-cat-desc').value = btn.getAttribute('data-desc');
            document.getElementById('edit-cat-originalName').value = btn.getAttribute('data-name');
        });
    });
</script>
</body>
</html>
