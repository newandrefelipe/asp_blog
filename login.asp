<!-- #include file="src/senha.asp" -->
<!-- #include file="config/config.asp" -->
<!-- #include file="src/redireciona.asp" -->
<%
' Se esta logado, redireciona para a Administracao
If Not Session("login") = "" Then
    redireciona("/admin")
End If

Dim metodo
Dim is_login_ok
Dim login
Dim senha

Function efetuarLogin(login, senha)
    Dim rs
    Dim sql
    Dim conexao
    Dim login_ok
    Dim senha_md5

    senha_md5 = Hash("md5", senha)
    login_ok = False
    Set conexao = openConnection()

    sql = "SELECT * FROM usuario WHERE login_ = '" & login & "' AND senha = '" & senha_md5 & "'"
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open sql, conexao

    ' Se encontrou usuario, o login esta OK
    If Not rs.EOF And Not rs.BOF Then
        login_ok = True
    End If

    rs.Close()
    Set rs = Nothing
    conexao.Close()
    Set conexao = Nothing

    ' Return
    efetuarLogin = login_ok
End Function

metodo = Request.ServerVariables("REQUEST_METHOD")

If metodo = "POST" Then
    login = Request.Form("login")
    senha = Request.Form("password")
    is_login_ok = efetuarLogin(login, senha)

    If is_login_ok = True Then
        Session("login") = Request.Form("login")
        redireciona("/admin")
    Else
        Sleep 5
    End If
End If

%>
<!-- #include file="src/html_header.asp" -->
<div class="center-content">
    <div class="form-login">
        <form action="login.asp" method="post">
            <div class="form-group">
                <label for="login">Email:</label>
                <input type="text" name="login" id="login" class="form-control" autofocus>
            </div>
            <div class="form-group">
                <label for="password">Senha:</label>
                <input type="password" name="password" id="password" class="form-control">
            </div>
            <button id="btn-login" class="btn btn-primary">Login</button>
        </form>
    </div>
</div>
<script>
    let btnLogin = document.querySelector("#btn-login");
    let form = document.querySelector("form");
    btnLogin.addEventListener('click', (e) => {
        btnLogin.disabled = true;
        form.submit();
    });
</script>
<!-- #include file="src/html_footer.asp" -->
