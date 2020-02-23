<!-- #include file="src/password.asp" -->
<!-- #include file="src/Utils.asp" -->
<!-- #include file="src/redirects.asp" -->
<%
' If logged in, redirect to an Administration
If Not Session("login") = "" Then
    redirect("/admin")
End If

Dim method
Dim is_login_ok
Dim login
Dim password

Function performSystemLogin(login, password)
    Dim rs
    Dim sql
    Dim connection
    Dim login_ok
    Dim md5_password
    
    md5_password = Hash("md5", password)
    login_ok = False
    Set connection = openConnection()

    sql = "SELECT * FROM user_ WHERE login_ = '" & login & "' AND password = '" & md5_password & "'"
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open sql, connection

    ' If found user, login is OK
    If Not rs.EOF And Not rs.BOF Then
        login_ok = True
    End If

    rs.Close()
    Set rs = Nothing
    connection.Close()
    Set connection = Nothing

    ' Return
    performSystemLogin = login_ok
End Function

method = Request.ServerVariables("REQUEST_METHOD")

If method = "POST" Then
    login = Request.Form("login")
    password = Request.Form("password")
    is_login_ok = performSystemLogin(login, password)

    If is_login_ok = True Then
        Session("login") = Request.Form("login")
        redirect("/admin")
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
