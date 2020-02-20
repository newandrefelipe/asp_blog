<!-- #include file="config/config.asp" -->
<!-- #include file="src/Tag.asp" -->
<%
Dim objTag
Dim id_tag

Set objTag = New Tag
id_tag = Request.QueryString("id")
%>
<!-- #include file="src/html_header.asp" -->
    <h1><a href="/" class="link-titulo-blog">Blog do André Felipe</a></h1>
    <p><% objTag.exibirArtigosDaTag(id_tag) %></p>
<!-- #include file="src/html_footer.asp" -->