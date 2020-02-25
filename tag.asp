<!-- #include file="TagClass.asp" -->
<%
Dim objTag
Dim id_tag

Set objTag = New TagClass
id_tag = Request.QueryString("id")
%>
<!-- #include file="html_header.asp" -->
    <h1><a href="/" class="link-blog-title"><%=Application("SiteName")%></a></h1>
    <p><% objTag.displayTagArticles(id_tag) %></p>
<!-- #include file="html_footer.asp" -->