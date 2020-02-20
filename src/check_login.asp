<!-- #include file="redireciona.asp" -->
<%
Sub check_login()
    If Session("login") = "" Then
        redireciona("/login.asp")
    End If
End Sub
%>