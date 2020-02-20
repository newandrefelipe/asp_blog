<!-- #include file="config/config.asp" -->
<!-- #include file="src/Artigo.asp" -->
<%
Dim objArtigo
Dim artigos
Dim metodo
Dim pagina

Set objArtigo = New Artigo

metodo = Request.ServerVariables("REQUEST_METHOD")

If metodo = "GET" Then
  pagina = Request.QueryString("pagina")
  If Trim(pagina) = "" Then
    pagina = 1
  End If
End If
%>
<!-- #include file="src/html_header.asp" -->
      
      <h1>Blog do André Felipe</h1>
      <p>
            <%
            ' artigos = objArtigo.exibirTodosNoBlog()
            objArtigo.listarPaginado(pagina)
            %>
      </p>
      <p>
            <% objArtigo.mostrarPaginas(pagina) %>
      </p>
      
<!-- #include file="src/html_footer.asp" -->