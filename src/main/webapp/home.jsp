<%@ page import="java.util.List" %>
<%@ page import="org.example.model.Promotion" %>
<%@ page import="org.example.service.PromotionService" %>

<html>
<head>
    <title>IIT/GR3</title>
</head>

<style>
.promotions-banner {
    background: #ffdfdf;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 10px;
}

.promo-card {
    padding: 10px;
    margin-bottom: 10px;
    background: #fff3f3;
    border-left: 5px solid red;
}
</style>

<body>

<jsp:include page="shared/navbar/navbar.jsp" />

<%
    PromotionService promoService = new PromotionService();
    List<Promotion> activePromos = promoService.getActivePromotions();
%>

<div class="promotions-banner">
    <% for (Promotion ap : activePromos) { %>
        <div class="promo-card">
            <h2><%= ap.getTitle() %></h2>
            <p><%= ap.getDescription() %></p>
        </div>
    <% } %>
</div>
</body>
</html>
