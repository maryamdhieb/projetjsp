<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Promotion" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<%
    // Récupère les attributs fournis par le servlet
    List<Promotion> promotions = (List<Promotion>) request.getAttribute("promotions");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    if (promotions == null) promotions = new java.util.ArrayList<>();
    if (categories == null) categories = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
     <title>SportShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Hero avec image promo flash sale en fond + élimination margins */
        .hero-promo {
            position: relative;
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.92), rgba(243, 156, 18, 0.88)),
                        url('https://media.istockphoto.com/id/2157690234/vector/hot-deal-sale-banner-vector-template-with-bold-3d-text-thunder-and-flash-lightning-effects.jpg?s=612x612&w=0&k=20&c=MSX9wGXWXM8q6eMZka1qfuRydPxTfAcf6uBdvXg_758=') center/cover no-repeat;
            padding: 2rem 2rem;
            text-align: center;
            color: white;
            margin: 0 0 2rem 0;
            border-bottom: 4px solid var(--primary);
        }

        .hero-promo h1 {
            font-weight: 800;
            font-size: 3rem;
            text-shadow: 0 4px 10px rgba(0,0,0,0.5);
        }

        .hero-promo p {
            font-size: 1.3rem;
            opacity: 0.95;
        }

        /* Container principal sans py-5 excessif */
        .main-content {
            padding: 0 1.5rem 4rem;
        }

        .card {
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
            border: none;
            overflow: hidden;
        }

        .card-header-custom {
            background: linear-gradient(90deg, #e74c3c, #f39c12);
            color: white;
            padding: 1.5rem;
            font-weight: 700;
        }

        .table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            background: #f8f9fa;
            color: #555;
        }

        .table tbody tr:hover {
            background-color: rgba(231,76,60,0.08);
        }

        .badge-active {
            background: #2ecc71;
            color: white;
            padding: 0.6em 1.2em;
            border-radius: 50px;
        }

        .badge-inactive {
            background: #ccc;
            color: #555;
            padding: 0.6em 1.2em;
            border-radius: 50px;
        }

        /* Boutons actions */
        .action-btn {
            border-radius: 0.75rem;
            padding: 0.5rem 0.9rem;
            margin: 0 0.25rem;
        }

        /* Modal styles améliorés */
        .modal-content {
            border-radius: 1.25rem;
            border: none;
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }

        .modal-header {
            background: linear-gradient(90deg, #e74c3c, #f39c12);
            color: white;
            border-bottom: none;
            border-radius: 1.25rem 1.25rem 0 0;
        }

        .modal-body {
            padding: 2rem;
        }

        .form-control, .form-select {
            border-radius: 0.85rem;
            padding: 0.75rem 1rem;
        }

        .products-container {
            max-height: 320px;
            overflow-y: auto;
            border: 2px dashed #f39c12;
            border-radius: 1rem;
            padding: 1.25rem;
            background: #fff9f0;
            margin-top: 1rem;
        }

        .products-container .form-check-label {
            transition: color 0.2s;
        }

        .products-container .form-check-input:checked + .form-check-label {
            color: #e74c3c;
            font-weight: 700;
        }

        .modal-footer {
            background: #fdf2e9;
            border-top: none;
        }

        /* Bouton add plus impactant */
        .btn-add-promo {
            background: linear-gradient(90deg, #e74c3c, #f39c12);
            border: none;
            border-radius: 1rem;
            padding: 0.85rem 2rem;
            font-weight: 600;
            box-shadow: 0 6px 15px rgba(231,76,60,0.3);
        }
    </style>
</head>
<body>

<jsp:include page="shared/navbar/navbar.jsp" />

<!-- Hero avec image promo en fond (remplace le text-center original) -->
<div class="hero-promo">
    <h1 class="fw-bold mb-3"><i class="fas fa-tags me-3"></i>Promotions Management</h1>
    <p class="text-white-50">Create and manage your special offers</p>
</div>

<div class="main-content">
    <!-- Add Button -->
    <div class="text-end mb-4">
        <button class="btn text-white btn-add-promo" data-bs-toggle="modal" data-bs-target="#addPromoModal">
            <i class="fas fa-plus me-2"></i>New Promotion
        </button>
    </div>

    <!-- Promotions Table -->
    <div class="card">
        <div class="card-header-custom">
            <h4 class="mb-0"><i class="fas fa-list me-2"></i>Promotions List</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Type</th>
                            <th>Value</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Utilise la variable promotions initialisée en haut
                            if (promotions != null && !promotions.isEmpty()) {
                                for (Promotion p : promotions) {
                                    boolean isActive = p.isActive();
                        %>
                        <tr>
                            <td><%= p.getName() %></td>
                            <td><%= p.getDescription() != null ? p.getDescription() : "-" %></td>
                            <td><%= p.getType() %></td>
                            <td><%=p.getValue()%></td>
                            <td><%= p.getStartDate() %></td>
                            <td><%= p.getEndDate() %></td>
                            <td>
                                <span class="badge <%= isActive ? "badge-active" : "badge-inactive" %>">
                                    <%= isActive ? "Active" : "Inactive" %>
                                </span>
                            </td>
                            <td>
                                <button class="btn btn-warning action-btn btn-sm"
                                     onclick='openEditModal(
                                         <%= p.getId() %>,
                                         "<%= p.getName().replace("\"","\\\"") %>",
                                         "<%= p.getDescription() != null ? p.getDescription().replace("\"","\\\"") : "" %>",
                                         <%= p.getValue() %>,
                                         "<%= p.getType() %>",
                                         "<%= p.getStartDate() %>",
                                         "<%= p.getEndDate() %>",
                                         <%= p.getProducts().get(0).getCategoryId() %>,
                                         <%= p.getProducts().stream()
                                             .map(prod -> String.valueOf(prod.getId()))
                                             .collect(java.util.stream.Collectors.joining(",", "[", "]")) %>
                                     )'>
                                    <i class="fas fa-edit"></i>
                                </button>
                                <form method="post" action="<%= request.getContextPath() %>/promotions" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="btn btn-danger action-btn btn-sm" onclick="return confirm('Delete this promotion?')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="8" class="text-center py-5 text-muted">
                                No promotions found.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Promotion Modal (inchangé) -->
<div class="modal fade" id="addPromoModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <form method="post" action="<%= request.getContextPath() %>/promotions" class="modal-content">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="id" id="addPromoId">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-plus me-2"></i>New Promotion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Promotion Name" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold text-danger"><i class="fas fa-cog me-2"></i>Type</label>
                    <select name="type" id="promo-type" class="form-select">
                        <option value="percentage">Percentage (%)</option>
                        <option value="fixed">Fixed Amount (€)</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Value</label>
                    <input type="number" step="0.01" min="0" name="value" class="form-control" required>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col">
                        <label class="form-label">Start Date</label>
                        <input type="date" name="startDate" class="form-control" required>
                    </div>
                    <div class="col">
                        <label class="form-label">End Date</label>
                        <input type="date" name="endDate" class="form-control" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select id="addCategorySelect" class="form-select" onchange="loadAddProducts()">
                        <option value="">-- Select a category --</option>
                        <% for (Category cat : categories) { %>
                            <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
                        <% } %>
                    </select>
                </div>
                <div id="addProductsContainer" class="products-container">
                    <p class="text-muted text-center">Please select a category</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-success">Create Promotion</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Promotion Modal (inchangé) -->
<div class="modal fade" id="editPromoModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <form method="post" action="<%= request.getContextPath() %>/promotions" class="modal-content">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="editPromoId">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Edit Promotion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" id="editPromoName" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold text-danger"><i class="fas fa-cog me-2"></i>Type</label>
                    <select name="type" id="promo-type" class="form-select">
                        <option value="percentage">Percentage (%)</option>
                        <option value="fixed">Fixed Amount (€)</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" id="editPromoDescription" class="form-control" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Value</label>
                    <input type="number" step="0.01" min="0" name="value" id="editPromoValue" class="form-control" required>
                </div>
                <div class="row g-3 mb-3">
                    <div class="col">
                        <label class="form-label">Start Date</label>
                        <input type="date" name="startDate" id="editPromoStartDate" class="form-control" required>
                    </div>
                    <div class="col">
                        <label class="form-label">End Date</label>
                        <input type="date" name="endDate" id="editPromoEndDate" class="form-control" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select id="editCategorySelect" class="form-select" onchange="loadEditProducts()">
                        <option value="">-- Select a category --</option>
                        <% for (Category cat : categories) { %>
                            <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
                        <% } %>
                    </select>
                </div>
                <div id="editProductsContainer" class="products-container">
                    <p class="text-muted text-center">Please select a category</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const categories = [
        <% for (Category cat : categories) { %>
        {
            id: <%= cat.getId() %>,
            name: "<%= cat.getName() %>",
            products: [
                <% if (cat.getProducts()!=null){ for(int i=0;i<cat.getProducts().size();i++){
                    Product p = cat.getProducts().get(i); %>
                    {id:<%=p.getId()%>,name:"<%=p.getName().replace("\"","\\\"")%>"}<%= i<cat.getProducts().size()-1?",":"" %>
                <% } } %>
            ]
        }<%= categories.indexOf(cat)<categories.size()-1?",":"" %>
        <% } %>
    ];

    function loadAddProducts(){
        const categoryId = document.getElementById('addCategorySelect').value;
        const container = document.getElementById('addProductsContainer');
        const cat = categories.find(c => c.id == categoryId);
        if(!cat) { container.innerHTML='<p class="text-muted text-center">No products</p>'; return; }
        container.innerHTML = cat.products.map(p=>`<div class="form-check"><input class="form-check-input" type="checkbox" name="productIds" value="${p.id}" id="addProd_${p.id}" ><label class="form-check-label" for="addProd_${p.id}">${p.name}</label></div>`).join('');
    }

    function loadEditProducts(){
        const categoryId = document.getElementById('editCategorySelect').value;
        const container = document.getElementById('editProductsContainer');

        const cat = categories.find(c => c.id == categoryId);
        if(!cat) {
            container.innerHTML = '<p class="text-muted text-center">No products</p>';
            return;
        }

        container.innerHTML = cat.products.map(p => `
            <div class="form-check">
                <input class="form-check-input" type="checkbox"
                       name="productIds"
                       value="${p.id}"
                       id="editProd_${p.id}">
                <label class="form-check-label" for="editProd_${p.id}">
                    ${p.name}
                </label>
            </div>
        `).join('');
    }


  function openEditModal(id, name, desc, value, type, start, end, categoryId, productIds) {

      document.getElementById('editPromoId').value = id;
      document.getElementById('editPromoName').value = name;
      document.getElementById('editPromoDescription').value = desc;
      document.getElementById('editPromoValue').value = value;
      document.getElementById('editPromoStartDate').value = start;
      document.getElementById('editPromoEndDate').value = end;

      // Sélectionner le type
      document.querySelector('#editPromoModal select[name="type"]').value = type;

      // Sélectionner la catégorie
      document.getElementById('editCategorySelect').value = categoryId;

      // Charger les produits de la catégorie
      loadEditProducts();

      // Cocher les produits liés à la promotion
      productIds.forEach(pid => {
          const checkbox = document.getElementById('editProd_' + pid);
          if (checkbox) checkbox.checked = true;
      });

      new bootstrap.Modal(document.getElementById('editPromoModal')).show();
  }


</script>

</body>
</html>