<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./libraries/bootstrap/bootstrap.min.css" rel="stylesheet" >
</head>
<script src="./libraries/bootstrap/bootstrap.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<body>
<% String fullname = (String) session.getAttribute("fullname"); %>

<nav class="navbar navbar-light bg-light p-3">
<a class="navbar-brand" href="/servlet-jsp-gr3/home">
    <img src="/servlet-jsp-gr3/assets/img/logo111.png"
         alt="sport"
         height="45"
         width="auto"></a>
 <a class="navbar-brand" href="/servlet-jsp-gr3/categories"><b>Categories</b></a>
 <a class="nav-link" href="cart">
            cart
     <span class="badge bg-danger">
         <%= (session.getAttribute("cartCount") != null) ? session.getAttribute("cartCount") : 0 %>
     </span>
 </a>
<% if (fullname != null) { %>
  <span class="navbar-text"><b><%= fullname %></b></span>
  <% } %>
</nav>
</body>
</html>
