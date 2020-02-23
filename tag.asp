<!-- #include file="src/Tag.asp" -->
<%
Dim objTag
Dim id_tag

Set objTag = New Tag
id_tag = Request.QueryString("id")
%>
<!-- #include file="src/html_header.asp" -->
    <h1><a href="/" class="link-blog-title"><%=Application("SiteName")%></a></h1>
    <p><% objTag.displayTagArticles(id_tag) %></p>
<!-- #include file="src/html_footer.asp" -->