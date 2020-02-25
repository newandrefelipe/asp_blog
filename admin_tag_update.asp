<!-- #include file="TagClass.asp" -->
<!-- #include file="redirects.asp" -->
<!-- #include file="check_login.asp" -->
<%
check_login()

Dim method
Dim objTag
Dim objTagShow

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objTag = New TagClass
  objTag.update Request.Form("id"), Request.Form("name")

  redirect("admin_tag_default.asp")
End If

Set objTag = New TagClass
Set objTagShow = objTag.findById(Request.QueryString("id"))
%>
<!-- #include file="html_header.asp" -->
  <h1>Editar Tag</h1>
  <div id="error-messages" class="alert alert-danger d-none" role="alert">
    Atenção: existem campos obrigatórios que não foram preenchidos.
  </div>
  <form action="admin_tag_update.asp" method="post">
    <div class="form-group">
      <label for="name">Nome da Tag*:</label>
      <input type="text" class="form-control" name="name" id="name" value="<%=objTagShow("name")%>" autofocus />
    </div>
    <div class="form-group">
      <input type="hidden" name="id" value="<%=objTagShow("id")%>" />
      <button id="btn-cadastrar" class="btn btn-primary mt-2">Editar Tag</button>
    </div>
    <div class="form-group">
      <a href="admin_tag_default.asp">Voltar</a>
    </div>
  </form>
  <script>
    let btnCadastrar = document.querySelector("#btn-cadastrar");
    let errorMessages = document.querySelector("#error-messages");

    btnCadastrar.addEventListener("click", function(e) {
      let formNome = document.querySelector("#name").value;

      if (formNome.trim() == "") {
        e.preventDefault();
        errorMessages.classList.remove("d-none");
        window.scrollTo(0, 0);
        return;
      }  
    });
  </script>
<!-- #include file="html_footer.asp" -->
