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
<a class="navbar-brand" href="/servlet-jsp-gr3/home.jsp"><b>IIT Store</b></a>
<a class="navbar-brand" href="/servlet-jsp-gr3/categories"><b>Categories</b></a>
<% if (fullname != null) { %>
  <span class="navbar-text"><b><%= fullname %></b></span>
  <% } %>
</nav>
</body>
</html>
