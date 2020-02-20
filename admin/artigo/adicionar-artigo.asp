<!-- #include file="../../src/Artigo.asp" -->
<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redireciona.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim metodo
Dim objArtigo
Dim objTag

metodo = Request.ServerVariables("REQUEST_METHOD")

If (metodo = "POST") Then
  Set objArtigo = New Artigo
  objArtigo.adicionar Request.Form("titulo"), Request.Form("conteudo"), Request.Form("versiculo"), Request.Form("preview"), Request.Form("tag")

  redireciona("/admin/artigo")
End If

Set objTag = New Tag

%>
<!-- #include file="../../src/html_header.asp" -->
      <h1>Adicionar Artigo</h1>
      <form action="adicionar-artigo.asp" method="post">
        <div class="form-group">
          <label for="titulo">Título do artigo:</label>
          <input type="text" class="form-control" name="titulo" id="titulo" autofocus />
        </div>
        <div class="form-group">
          <label for="preview">Preview do artigo:</label>
          <input type="text" class="form-control" name="preview" id="preview">
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
          ></textarea>
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
          ></textarea>
        </div>

        <div class="form-group">
          <label for="tag">Tag:</label>
          <select id="tag" name="tag" class="form-control">
          <% objTag.getTagsOptions(0) %>
          </select>
        </div>

        <div class="form-group">
          <button class="btn btn-primary mt-2">Publicar Artigo</button>
        </div>
        <div class="form-group">
          <a href="/admin/artigo">Voltar</a>
        </div>
      </form>
<!-- #include file="../../src/html_footer.asp" -->