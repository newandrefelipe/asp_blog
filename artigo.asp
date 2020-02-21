<!-- #include file="src/Artigo.asp" -->
<!-- #include file="src/Tag.asp" -->
<!-- #include file="src/redireciona.asp" -->
<%
Dim objArtigo
Dim objArtigoShow
Dim tags

Set objArtigo = New Artigo
Set objArtigoShow = objArtigo.encontrarPorId(Request.QueryString("id"))

If objArtigoShow("id") = "NOK" Then
    redireciona404("/404.asp")
End If

%>
<!-- #include file="src/html_header.asp" -->
<h1><a href="/" class="link-titulo-blog">Blog do André Felipe</a></h1>
<div class="border-artigo">
    <h2 class="titulo-artigo"><%=objArtigoShow("titulo")%></h2>
    <p><%=objArtigoShow("conteudo")%></p>
    <p>
    <%
        objArtigo.buscarTagsDoArtigo(Request.QueryString("id"))
    %>
    </p>
    <% If Not IsNull(objArtigoShow("versiculo")) And Not objArtigoShow("versiculo") = "<br>" Then %>
    <div class="box-versiculo">
        <p><%=objArtigoShow("versiculo")%></p>
    </div>
    <% End If %>
</div>
<button onclick="goBack()" class="btn btn-primary mt-2">Voltar</button>
<!-- #include file="src/html_footer.asp" -->
