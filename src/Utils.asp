<%
Function openConnection()
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open(Application("ConnectionStringMySQL"))
    Set openConnection = conn
End Function
%>