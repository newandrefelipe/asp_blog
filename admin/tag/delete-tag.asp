<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redirects.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim method
Dim objTag

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objTag = New Tag
  objTag.delete Request.Form("id")

  redirect("/admin/tag")
End If
%>
<!-- #include file="../../src/html_header.asp" -->
<p>Confirma a exclusão da tag?</p>
<form method="post" action="delete-tag.asp">
    <div class="form-group">
      <input type="hidden" name="id" value="<%=Request.QueryString("id")%>">
      <button class="btn btn-primary">Remover</button>
    </div>
    <div class="form-group">
      <a href="/admin/tag">Voltar</a>
    </div>
</form>
<!-- #include file="../../src/html_footer.asp" -->
