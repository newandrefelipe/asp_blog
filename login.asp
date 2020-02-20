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

    login_ok = "NOK"
    Set conexao = openConnection()

    sql = "SELECT * FROM usuario WHERE login_ = '" & login & "' AND senha = '" & senha & "'"
    rs = conexao.Execute(sql)

    If Not IsNull(rs("id")) Then
        login_ok = "OK"
    End If

    ' rs.Close()
    conexao.Close()

    ' Return
    efetuarLogin = login_ok
End Function

metodo = Request.ServerVariables("REQUEST_METHOD")

If metodo = "POST" Then
    login = Request.Form("login")
    senha = Request.Form("password")
    is_login_ok = efetuarLogin(login, senha)

    If is_login_ok = "OK" Then
        Session("login") = Request.Form("login")
        Response.Redirect("/admin")
        Response.End
    End If
End If

%>
<!-- #include file="src/html_header.asp" -->
<div class="center-content">
    <div class="form-login">
        <form action="login.asp" method="post">
            <div class="form-group">
                <label for="login">Email:</label>
                <input type="text" name="login" id="login" class="form-control" value="adm" autofocus>
            </div>
            <div class="form-group">
                <label for="password">Senha:</label>
                <input type="password" name="password" id="password" class="form-control" value="adm">
            </div>
            <button class="btn btn-primary">Login</button>
        </form>
    </div>
</div>
<!-- #include file="src/html_footer.asp" -->
