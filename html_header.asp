<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meu Blog</title>
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/site.css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <script src="https://kit.fontawesome.com/86f8fc9cfe.js" crossorigin="anonymous"></script>
  </head>
  <body>
    <div class="container">
      <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-2 d-flex justify-content-between">
        <div class="float-left">
          <a class="navbar-brand" href="/">Home</a>
          <a class="navbar-brand" href="/article.asp?id=2">Sobre</a>
        </div>
        <%
          If Session("login") = "" Then
        %>
          <div class="float-right">
            <a href="/login.asp" class="text-light">Login</a>
          </div>
        <%
          Else
        %>
          <div class="float-right">
            <a href="admin_default.asp" class="text-light justify-content-">Administração |</a>
            <a href="logout.asp" class="text-light">Logout</a>
          </div>
        <%
          End If
        %>
      </nav>
      <div class="border-blog">
      