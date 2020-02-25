<!-- #include file="ArticleClass.asp" -->
<!-- #include file="redirects.asp" -->
<%
Dim objArticle
Dim objArticleShow

Set objArticle = New ArticleClass
Set objArticleShow = objArticle.findById(Request.QueryString("id"))

' TODO: substituir esse tratamento por IsEmpty(objArticleShow("id"))
If objArticleShow("id") = "NOK" Then
    redirect404()
End If

%>
<!-- #include file="html_header.asp" -->
<h1><a href="/" class="link-blog-title"><%=Application("SiteName")%></a></h1>
<div class="article-border">
    <h2 class="title-article"><%=objArticleShow("title")%></h2>
    <p><span class="badge badge-secondary">Publicado em: <%=Mid(objArticleShow("creation_date"), 1, 10)%></span></p>
    <p><%=objArticleShow("content")%></p>
    <p>
    <%
        objArticle.searchArticleTags(Request.QueryString("id"))
    %>
    </p>
    <% If Not IsNull(objArticleShow("verse")) And Not objArticleShow("verse") = "<br>" Then %>
    <div class="verse-box">
        <p><%=objArticleShow("verse")%></p>
    </div>
    <% End If %>
</div>
<button onclick="goBack()" class="btn btn-primary mt-2">Voltar</button>
<!-- #include file="html_footer.asp" -->
