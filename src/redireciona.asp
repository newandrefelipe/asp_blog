<%
Sub redireciona(url)
    Response.Redirect(url)
    Response.End
End Sub

Sub redireciona404(url)
    Response.Redirect(url)
    Response.Status = "404 File Not Found"
    Response.End
End Sub
%>