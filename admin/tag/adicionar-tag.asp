<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/redireciona.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim metodo
Dim objTag

metodo = Request.ServerVariables("REQUEST_METHOD")

If (metodo = "POST") Then
  Set objTag = New Tag
  objTag.adicionar Request.Form("nome")

  redireciona("/admin/tag")
End If
%>
<!-- #include file="../../src/html_header.asp" -->
      <h1>Adicionar Tag</h1>
      <div id="error-messages" class="alert alert-danger d-none" role="alert">
        Atenção: existem campos obrigatórios que não foram preenchidos.
      </div>
      <form action="adicionar-tag.asp" method="post">
        <div class="form-group">
          <label for="nome">Nome da Tag:</label>
          <input type="text" class="form-control" name="nome" id="nome" autofocus />
        </div>
        <div class="form-group">
          <button id="btn-cadastrar" class="btn btn-primary mt-2">Inserir Tag</button>
        </div>
        <div class="form-group">
          <a href="/admin/tag">Voltar</a>
        </div>
      </form>
      <script>
        let btnCadastrar = document.querySelector("#btn-cadastrar");
        let errorMessages = document.querySelector("#error-messages");

        btnCadastrar.addEventListener("click", function(e) {
          let formNome = document.querySelector("#nome").value;

          if (formNome.trim() == "") {
            e.preventDefault();
            errorMessages.classList.remove("d-none");
            window.scrollTo(0, 0);
            return;
          }  
        });
      </script>      
<!-- #include file="../../src/html_footer.asp" -->
