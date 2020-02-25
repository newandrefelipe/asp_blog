<!-- #include file="TagClass.asp" -->
<!-- #include file="redirects.asp" -->
<!-- #include file="check_login.asp" -->
<%
check_login()

Dim method
Dim objTag

method = Request.ServerVariables("REQUEST_METHOD")

If (method = "POST") Then
  Set objTag = New TagClass
  objTag.create Request.Form("name")

  redirect("admin_tag_default.asp")
End If
%>
<!-- #include file="html_header.asp" -->
      <h1>Adicionar Tag</h1>
      <div id="error-messages" class="alert alert-danger d-none" role="alert">
        Atenção: existem campos obrigatórios que não foram preenchidos.
      </div>
      <form action="admin_tag_add.asp" method="post">
        <div class="form-group">
          <label for="name">Nome da Tag*:</label>
          <input type="text" class="form-control" name="name" id="name" autofocus />
        </div>
        <div class="form-group">
          <button id="btn-register" class="btn btn-primary mt-2">Inserir Tag</button>
        </div>
        <div class="form-group">
          <a href="admin_tag_default.asp">Voltar</a>
        </div>
      </form>
      <script>
        let btnRegister = document.querySelector("#btn-register");
        let errorMessages = document.querySelector("#error-messages");

        btnRegister.addEventListener("click", function(e) {
          let formName = document.querySelector("#name").value;

          if (formName.trim() == "") {
            e.preventDefault();
            errorMessages.classList.remove("d-none");
            window.scrollTo(0, 0);
            return;
          }  
        });
      </script>      
<!-- #include file="html_footer.asp" -->
