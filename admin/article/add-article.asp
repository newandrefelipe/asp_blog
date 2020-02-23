<!-- #include file="../../src/ArticleClass.asp" -->
<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redirects.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim method
Dim objArticle
Dim objTag

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objArticle = New ArticleClass
  objArticle.create Request.Form("title"), Request.Form("content"), Request.Form("verse"), Request.Form("preview"), Request.Form("tag")

  redirect("/admin/article")
End If

Set objTag = New Tag

%>
<!-- #include file="../../src/html_header.asp" -->
      <h1>Adicionar Artigo</h1>
      <div id="error-messages" class="alert alert-danger d-none" role="alert">
        Atenção: existem campos obrigatórios que não foram preenchidos.
      </div>
      <form action="add-article.asp" method="post">
        <div class="form-group">
          <label for="title">Título do artigo*:</label>
          <input type="text" class="form-control" name="title" id="title" autofocus />
        </div>
        <div class="form-group">
          <label for="preview">Preview do artigo*:</label>
          <input type="text" class="form-control" name="preview" id="preview">
        </div>
        <div class="form-group">
          <label for="content">Conteúdo do artigo:</label>
          <textarea
            type="text"
            class="form-control"
            name="content"
            id="content"
            rows="10"
            cols="100"
          ></textarea>
        </div>

        <div class="form-group">
          <label for="verse">Versículo do artigo:</label>
          <textarea
            type="text"
            class="form-control"
            name="verse"
            id="verse"
            rows="7"
            cols="100"
          ></textarea>
        </div>

        <div class="form-group">
          <label for="tag">Tag:</label>
          <select id="tag" name="tag" class="form-control">
          <% objTag.getTagsOptions(0) %>
          </select>
        </div>

        <div class="form-group">
          <button id="btn-publish" class="btn btn-primary mt-2">Publicar Artigo</button>
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
