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
  objTag.adicionar Request.Form("nome")

  redireciona("/admin/tag")
End If
%>
<!-- #include file="../../src/html_header.asp" -->
      <h1>Adicionar Tag</h1>
      <form action="adicionar-tag.asp" method="post">
        <div class="form-group">
          <label for="nome">Nome da Tag:</label>
          <input type="text" class="form-control" name="nome" id="nome" autofocus />
        </div>
        <div class="form-group">
          <button class="btn btn-primary mt-2">Inserir Tag</button>
        </div>
        <div class="form-group">
          <a href="/admin/tag">Voltar</a>
        </div>
      </form>
<!-- #include file="../../src/html_footer.asp" -->
