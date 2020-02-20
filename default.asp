<!-- #include file="config/config.asp" -->
<!-- #include file="src/Artigo.asp" -->
<%
Dim objArtigo
Dim artigos
Set objArtigo = New Artigo
%>
<!-- #include file="src/html_header.asp" -->
      
      <h1>Blog do André Felipe</h1>
      <p><% artigos = objArtigo.exibirTodosNoBlog() %></p>
      
<!-- #include file="src/html_footer.asp" -->