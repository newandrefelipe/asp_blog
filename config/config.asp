<%
Function openConnection()
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    
    ' Sqlite
    ' conn.Open("DRIVER=SQLite3 ODBC Driver;Database=C:\dev\work\asp_blog\database\sqlite\blog.sqlite;LongNames=0;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;")

    ' MySQL
    conn.Open("Driver={MySQL ODBC 8.0 ANSI Driver};Server=localhost;Database=asp_blog;User=root;Password=root;Option=3;")
    Set openConnection = conn
End Function
%>