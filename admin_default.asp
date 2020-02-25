<!-- #include file="check_login.asp" -->
<!-- #include file="ArticleClass.asp" -->
<!-- #include file="TagClass.asp" -->
<% check_login() %>
<%
Dim objArticle
Dim objTag

Set objArticle = New ArticleClass
Set objTag = New TagClass

%>
<!-- #include file="html_header.asp" -->
<h1>Administração</h1>
<div>
  <div class="row">
    <div class="col-xl-4 col-lg-4 mb-4">
      <div class="card-body">
        <div class="list-group">
          <a
            href="admin_article_default.asp"
            class="list-group-item list-group-item-action"
            >Artigos</a
          >
          <a
            href="admin_tag_default.asp"
            class="list-group-item list-group-item-action"
            >Tags</a
          >
          <a href="#" class="list-group-item list-group-item-action">Imagens</a>
        </div>
      </div>
    </div>

    <div class="col-xl-4 col-lg-4 mb-4 mt-4">
      <div class="card text-white bg-primary" style="max-width: 18rem;">
        <div class="card-body">
          <div class="row">
            <div class="col">
              <i class="far fa-newspaper fa-5x"></i>
            </div>
            <div class="col">
              <p class="card-text">
                <span class="display-1">
                  <%=objArticle.getTotalArticles%>
                </span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-xl-4 col-lg-4 mb-4 mt-4">
      <div class="card text-white bg-success" style="max-width: 18rem;">
        <div class="card-body">
          <div class="row">
            <div class="col">
              <i class="fas fa-tags fa-5x"></i>
            </div>
            <div class="col">
              <p class="card-text">
                <span class="display-1">
                  <%=objTag.getTotalTags%>
                </span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- #include file="html_footer.asp" -->
