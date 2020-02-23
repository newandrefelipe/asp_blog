<!-- #include file="../../src/ArticleClass.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim objArticle

Set objArticle = New ArticleClass
%>
<!-- #include file="../../src/html_header.asp" -->
      <h1><a href="../">Administração</a> | Artigos</h1>
      <a href="add-article.asp" class="btn btn-primary mb-2">Adicionar Artigo</a>
      <div class="table-responsive">
            <% objArticle.showAllADM() %>
      </div>
<!-- #include file="../../src/html_footer.asp" -->
