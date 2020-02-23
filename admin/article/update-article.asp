<!-- #include file="../../src/ArticleClass.asp" -->
<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redirects.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim method
Dim objTag
Dim objArticle
Dim objArticleShow

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objArticle = New ArticleClass
  objArticle.update Request.Form("id"), Request.Form("title"), Request.Form("conteudo"), Request.Form("versiculo"), Request.Form("preview"), Request.Form("tag")

  redirect("/admin/article")
End If

Set objArticle = New ArticleClass
Set objArticleShow = objArticle.findById(Request.QueryString("id"))
Set objTag = New Tag
%>
<!-- #include file="../../src/html_header.asp" -->
  <h1>Editar Artigo</h1>
  <div id="error-messages" class="alert alert-danger d-none" role="alert">
    Atenção: existem campos obrigatórios que não foram preenchidos.
  </div>
  <form action="update-article.asp" method="post">
    <div class="form-group">
      <label for="title">Título do artigo*:</label>
      <input type="text" class="form-control" name="title" id="title" value="<%=objArticleShow("title")%>" autofocus />
    </div>
    <div class="form-group">
      <label for="preview">Preview do artigo*:</label>
      <input type="text" class="form-control" name="preview" id="preview" value="<%=objArticleShow("preview")%>">
    </div>
    <div class="form-group">
      <label for="conteudo">Conteúdo do artigo:</label>
      <textarea
        type="text"
        class="form-control"
        name="conteudo"
        id="conteudo"
        rows="10"
        cols="100"
      ><%=objArticleShow("content")%></textarea>
    </div>

    <div class="form-group">
      <label for="versiculo">Versículo do artigo:</label>
      <textarea
        type="text"
        class="form-control"
        name="versiculo"
        id="versiculo"
        rows="7"
        cols="100"
      ><%=objArticleShow("verse")%></textarea>
    </div>

    <div class="form-group">
      <label for="tag">Tag:</label>
      <select id="tag" name="tag" class="form-control">
      <% objTag.getTagsOptions(objArticleShow("tag")) %>
      </select>
    </div>

    <div class="form-group">
      <input type="hidden" name="id" value="<%=objArticleShow("id")%>" />
      <button id="btn-publish" class="btn btn-primary mt-2">Editar Artigo</button>
    </div>
    <div class="form-group">
      <a href="/admin/article">Voltar</a>
    </div>
  </form>
  <script>
    let btnPublish = document.querySelector("#btn-publish");
    let errorMessages = document.querySelector("#error-messages");

    btnPublish.addEventListener("click", function(e) {
      let formTitle = document.querySelector("#title").value;
      let formPreview = document.querySelector("#preview").value;

      if (formTitle.trim() == "" || formPreview.trim() == "") {
        e.preventDefault();
        errorMessages.classList.remove("d-none");
        window.scrollTo(0, 0);
        return;
      }  
    });
  </script>
<!-- #include file="../../src/html_footer.asp" -->
