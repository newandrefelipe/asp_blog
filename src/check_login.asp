<!-- #include file="redirects.asp" -->
<%
Sub check_login()
    If Session("login") = "" Then
        redirect("/login.asp")
    End If
End Sub
%>