<!-- #include file="password.asp" -->
<!-- #include file="Utils.asp" -->
<!-- #include file="redirects.asp" -->
<%
Class LoginClass

    Private p_Connection

    Private Sub Class_Initialize()
        Set p_Connection = openConnection()
    End Sub

    Private Sub Class_Terminate()
        p_Connection.Close()
        Set p_Connection = Nothing
    End Sub

    Function performSystemLogin(login, password)
        Dim rs
        Dim sql
        Dim login_ok
        Dim md5_password
        
        md5_password = Hash("md5", password)
        login_ok = False

        sql = "SELECT * FROM user_ WHERE login_ = '" & login & "' AND password = '" & md5_password & "'"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        ' If found user, login is OK
        If Not rs.EOF And Not rs.BOF Then
            login_ok = True
        End If

        rs.Close()
        Set rs = Nothing

        ' Return
        performSystemLogin = login_ok
    End Function
End Class
%>