<!-- #include file="LoginClass.asp" -->
<!-- #include file="redirects.asp" -->
<%
' If logged in, redirect to Administration page
If Not Session("login") = "" Then
    redirect("admin_default.asp")
End If

Dim method
Dim is_login_ok
Dim login
Dim password
Dim objLogin

method = Request.ServerVariables("REQUEST_METHOD")

If method = "POST" Then
    login = Request.Form("login")
    password = Request.Form("password")
    Set objLogin = New LoginClass
    is_login_ok = objLogin.performSystemLogin(login, password)

    If is_login_ok = True Then
        Session("login") = Request.Form("login")
        redirect("admin_default.asp")
    Else
        Sleep 5
    End If
End If

%>
<!-- #include file="html_header.asp" -->
<h1><%=Application("SiteName")%></h1>
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
<!-- #include file="html_footer.asp" -->
