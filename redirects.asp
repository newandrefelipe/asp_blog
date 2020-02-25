<%
Sub redirect(url)
    Response.Redirect(url)
    Response.End
End Sub

Sub redirect404()
    Response.Status = "404 File Not Found"
    Response.Redirect("/404.asp")
    Response.End
End Sub
%>