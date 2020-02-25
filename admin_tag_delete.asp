<!-- #include file="TagClass.asp" -->
<!-- #include file="redirects.asp" -->
<!-- #include file="check_login.asp" -->
<%
check_login()

Dim method
Dim objTag

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objTag = New TagClass
  objTag.delete Request.Form("id")

  redirect("admin_tag_default.asp")
End If
%>
<!-- #include file="html_header.asp" -->
<p>Confirma a exclusão da tag?</p>
<form method="post" action="admin_tag_delete.asp">
    <div class="form-group">
      <input type="hidden" name="id" value="<%=Request.QueryString("id")%>">
      <button class="btn btn-primary">Remover</button>
    </div>
    <div class="form-group">
      <a href="admin_tag_default.asp">Voltar</a>
    </div>
</form>
<!-- #include file="html_footer.asp" -->
