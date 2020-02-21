<!-- #include file="../../config/config.asp" -->
<!-- #include file="../../src/Artigo.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim objArtigo
Dim artigos

Set objArtigo = New Artigo
%>
<!-- #include file="../../src/html_header.asp" -->
      <h1><a href="../">Administração</a> | Artigos</h1>
      <a href="adicionar-artigo.asp" class="btn btn-primary mb-2">Adicionar Artigo</a>
      <div class="table-responsive">
            <% objArtigo.exibirTodosADM() %>
      </div>
<!-- #include file="../../src/html_footer.asp" -->
