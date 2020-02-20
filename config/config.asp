<%
Function openConnection()
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open("DRIVER=SQLite3 ODBC Driver;Database=C:\dev\work\asp_blog\database\blog.sqlite;LongNames=0;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;")
    Set openConnection = conn
End Function
%>