<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redireciona.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim metodo
Dim objTag
Dim objTagShow

metodo = Request.ServerVariables("REQUEST_METHOD")

If (metodo = "POST") Then
  Set objTag = New Tag
  objTag.editar Request.Form("id"), Request.Form("nome")

  redireciona("/admin/tag")
End If

Set objTag = New Tag
Set objTagShow = objTag.encontrarPorId(Request.QueryString("id"))
%>
<!-- #include file="../../src/html_header.asp" -->
  <h1>Editar Tag</h1>
  <form action="editar-tag.asp" method="post">
    <div class="form-group">
      <label for="nome">Nome da Tag:</label>
      <input type="text" class="form-control" name="nome" id="nome" value="<%=objTagShow("nome")%>" autofocus />
    </div>
    <div class="form-group">
      <input type="hidden" name="id" value="<%=objTagShow("id")%>" />
      <button class="btn btn-primary mt-2">Editar Tag</button>
    </div>
    <div class="form-group">
      <a href="/admin/tag">Voltar</a>
    </div>
  </form>
<!-- #include file="../../src/html_footer.asp" -->
