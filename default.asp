<!-- #include file="ArticleClass.asp" -->
<%
Dim objArticle
Dim method
Dim page

Set objArticle = New ArticleClass

method = Request.ServerVariables("REQUEST_METHOD")

If method = "GET" Then
  page = Request.QueryString("page")
  If Trim(page) = "" Then
    page = 1
  End If
End If
%>
<!-- #include file="html_header.asp" -->
    <h1><%=Application("SiteName")%></h1>
    <p>
    <%
        ' objArticle.showAllHomePage()
        objArticle.listPaged(page)
    %>
    </p>
    <p>
    <% objArticle.showPages(page) %>
    </p>
<!-- #include file="html_footer.asp" -->