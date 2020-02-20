<!-- #include file="../../src/Artigo.asp" -->
<!-- #include file="../../src/redireciona.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim metodo
Dim objArtigo

metodo = Request.ServerVariables("REQUEST_METHOD")

If (metodo = "POST") Then
  Set objArtigo = New Artigo
  objArtigo.remover Request.Form("id")

  redireciona("/admin/artigo")
End If
%>
<!-- #include file="../../src/html_header.asp" -->
<p>Confirma a exclusão do artigo?</p>
<form method="post" action="excluir-artigo.asp">
    <div class="form-group">
      <input type="hidden" name="id" value="<%=Request.QueryString("id")%>">
      <button class="btn btn-primary">Remover</button>
    </div>
    <div class="form-group">
      <a href="/admin/artigo">Voltar</a>
    </div>
</form>
<!-- #include file="../../src/html_footer.asp" -->
