<!-- #include file="../../src/ArticleClass.asp" -->
<!-- #include file="../../src/redirects.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim method
Dim objArticle

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objArticle = New ArticleClass
  objArticle.delete Request.Form("id")

  redirect("/admin/article")
End If
%>
<!-- #include file="../../src/html_header.asp" -->
<p>Confirma a exclusão do artigo?</p>
<form method="post" action="delete-article.asp">
    <div class="form-group">
      <input type="hidden" name="id" value="<%=Request.QueryString("id")%>">
      <button class="btn btn-primary">Remover</button>
    </div>
    <div class="form-group">
      <a href="/admin/article">Voltar</a>
    </div>
</form>
<!-- #include file="../../src/html_footer.asp" -->
