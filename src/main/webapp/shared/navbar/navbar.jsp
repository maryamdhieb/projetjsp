<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./libraries/bootstrap/bootstrap.min.css" rel="stylesheet" >
</head>
<script src="./libraries/bootstrap/bootstrap.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<body>

<%
    String name = (String) session.getAttribute("name");
%>
<nav class="navbar navbar-light bg-light p-3">
<a class="navbar-brand" href="/servlet-jsp-gr3/home">
    <img src="/servlet-jsp-gr3/assets/img/logo111.png"
         alt="sport"
         height="45"
         width="auto"></a>
 <a class="navbar-brand" href="/servlet-jsp-gr3/categories"><b>Categories</b></a>
  <a class="navbar-brand" href="/servlet-jsp-gr3/promotions"><b>Sales</b></a>

 <a class="nav-link" href="cart">
            cart
     <span class="badge bg-danger">
         <%= (session.getAttribute("cartCount") != null) ? session.getAttribute("cartCount") : 0 %>
     </span>
 </a>
<% if (name != null) { %>
  <span class="navbar-text"><b><%= name %></b></span>
  <% } %>
</nav>
</body>
</html>
