<!-- #include file="../../src/Artigo.asp" -->
<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redireciona.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim metodo
Dim objTag
Dim objArtigo
Dim objArtigoShow

metodo = Request.ServerVariables("REQUEST_METHOD")

If (metodo = "POST") Then
  Set objArtigo = New Artigo
  objArtigo.editar Request.Form("id"), Request.Form("titulo"), Request.Form("conteudo"), Request.Form("versiculo"), Request.Form("preview"), Request.Form("tag")

  redireciona("/admin/artigo")
End If

Set objArtigo = New Artigo
Set objArtigoShow = objArtigo.encontrarPorId(Request.QueryString("id"))
Set objTag = New Tag
%>
<!-- #include file="../../src/html_header.asp" -->
  <h1>Editar Artigo</h1>
  <div id="error-messages" class="alert alert-danger d-none" role="alert">
    Atenção: existem campos obrigatórios que não foram preenchidos.
  </div>
  <form action="editar-artigo.asp" method="post">
    <div class="form-group">
      <label for="titulo">Título do artigo:</label>
      <input type="text" class="form-control" name="titulo" id="titulo" value="<%=objArtigoShow("titulo")%>" autofocus />
    </div>
    <div class="form-group">
      <label for="preview">Preview do artigo:</label>
      <input type="text" class="form-control" name="preview" id="preview" value="<%=objArtigoShow("preview")%>">
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
      ><%=objArtigoShow("conteudo")%></textarea>
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
      ><%=objArtigoShow("versiculo")%></textarea>
    </div>

    <div class="form-group">
      <label for="tag">Tag:</label>
      <select id="tag" name="tag" class="form-control">
      <% objTag.getTagsOptions(objArtigoShow("tag")) %>
      </select>
    </div>

    <div class="form-group">
      <input type="hidden" name="id" value="<%=objArtigoShow("id")%>" />
      <button id="btn-publicar" class="btn btn-primary mt-2">Editar Artigo</button>
    </div>
    <div class="form-group">
      <a href="/admin/artigo">Voltar</a>
    </div>
  </form>
  <script>
    let btnPublicar = document.querySelector("#btn-publicar");
    let errorMessages = document.querySelector("#error-messages");

    btnPublicar.addEventListener("click", function(e) {
      let formTitulo = document.querySelector("#titulo").value;
      let formPreview = document.querySelector("#preview").value;

      if (formTitulo.trim() == "" || formPreview.trim() == "") {
        e.preventDefault();
        errorMessages.classList.remove("d-none");
        window.scrollTo(0, 0);
        return;
      }  
    });
  </script>
<!-- #include file="../../src/html_footer.asp" -->
