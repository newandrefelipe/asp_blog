<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redireciona.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim metodo
Dim objTag

metodo = Request.ServerVariables("REQUEST_METHOD")

If (metodo = "POST") Then
  Set objTag = New Tag
  objTag.remover Request.Form("id")

  redireciona("/admin/tag")
End If
%>
<!-- #include file="../../src/html_header.asp" -->
<p>Confirma a exclusão da tag?</p>
<form method="post" action="excluir-tag.asp">
    <div class="form-group">
      <input type="hidden" name="id" value="<%=Request.QueryString("id")%>">
      <button class="btn btn-primary">Remover</button>
    </div>
    <div class="form-group">
      <a href="/admin/tag">Voltar</a>
    </div>
</form>
<!-- #include file="../../src/html_footer.asp" -->
