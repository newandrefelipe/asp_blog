<!-- #include file="ArticleClass.asp" -->
<!-- #include file="check_login.asp" -->
<%
check_login()

Dim objArticle

Set objArticle = New ArticleClass
%>
<!-- #include file="html_header.asp" -->
      <h1><a href="admin_default.asp">Administração</a></h1>
      <h2 class="title-article">Artigos</h2>
      <a href="admin_article_add.asp" class="btn btn-primary mb-2">Adicionar Artigo</a>
      <div class="table-responsive">
            <% objArticle.showAllADM() %>
      </div>
<!-- #include file="html_footer.asp" -->
