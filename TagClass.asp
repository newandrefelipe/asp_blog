<!-- #include file="Utils.asp" -->
<%
Class TagClass

    Private p_Connection

    Private Sub Class_Initialize()
        Set p_Connection = openConnection()
    End Sub

    Private Sub Class_Terminate()
        p_Connection.Close()
        Set p_Connection = Nothing
    End Sub

    Public Sub create(name)
        Dim sql
        sql = "INSERT INTO tag (name) VALUES('" & name & "')"
        p_Connection.Execute(sql)
    End Sub

    Public Sub update(id, name)
        Dim sql
        sql = "UPDATE tag SET name = '" & name & "' WHERE id = " & id
        p_Connection.Execute(sql)
    End Sub

    Public Sub delete(id)
        Dim sql
        sql = "DELETE FROM tag WHERE id = " & id
        p_Connection.Execute(sql)
        sql = "DELETE FROM article_tag WHERE tag_id = " & id
        p_Connection.Execute(sql)
    End Sub

    Public Sub showAllADM()
        Dim rs
        Dim sql
        Dim strResponse

        sql = "SELECT * FROM tag ORDER BY id DESC"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection
        
        strResponse = "<table class='table table-bordered table-striped table-hover'>"
        strResponse = strResponse & "<thead>"
        strResponse = strResponse & "<tr><th>Id</th><th>Nome</th><th></th></tr>"
        strResponse = strResponse & "</thead>"
        strResponse = strResponse & "<tbody>"
        Do While Not rs.EOF
            strResponse = strResponse & "<tr>"
            strResponse = strResponse & "<td>" & rs("id") & "</td>"
            strResponse = strResponse & "<td><a href='admin_tag_update.asp?id=" & rs("id") & "'>" & rs("name") & "</a></td>"
            strResponse = strResponse & "<td>" & "<a href='admin_tag_delete.asp?id=" & rs("id") & "' class='btn btn-danger'>Remover</a>" & "</td>"
            strResponse = strResponse & "</tr>"
            rs.MoveNext
        Loop
        strResponse = strResponse & "</tbody>"
        strResponse = strResponse & "</table>"
        Response.Write strResponse

        rs.Close()
        Set rs = Nothing
    End Sub

    Public Function findById(id)
        Dim rs
        Dim sql
        Dim tagFound

        sql = "SELECT id, name FROM tag WHERE id = " & id

        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        Set tagFound = Server.CreateObject("Scripting.Dictionary")
        tagFound("id") = rs("id")
        tagFound("name") = rs("name")

        rs.Close()
        Set rs = Nothing

        ' Return
        Set findById = tagFound

        Set tagFound = Nothing
    End Function

    Public Sub getTagsOptions(selected_id)

        Dim sql
        Dim rs
        Dim selected

        sql = "SELECT id, name FROM tag ORDER BY name ASC"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        Response.Write "<option value=''>Selecione...</option>"
        Do While Not rs.EOF
            If rs("id") = selected_id Then
                selected = "selected"
            End If

            Response.Write "<option value='" & rs("id") & "' " & selected & ">" & rs("name") & "</option>"
            selected = ""
            rs.MoveNext
        Loop

        rs.Close()
        Set rs = Nothing
    End Sub

    Public Sub displayTagArticles(id_tag)
        Dim rs
        Dim sql
        Dim strResponse

        sql = "SELECT a.id as id_article, a.title, a.preview FROM article a, article_tag at WHERE at.tag_id = " & id_tag & " AND at.article_id = a.id ORDER BY id_article DESC"

        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection
        
        strResponse = ""
        Do While Not rs.EOF
            strResponse = strResponse & "<div class='article-border mb-4'>"
            strResponse = strResponse & "<h2>"
            strResponse = strResponse & "<a href='article.asp?id=" & rs("id_article") & "'>"
            strResponse = strResponse & rs("title")
            strResponse = strResponse & "</a>"
            strResponse = strResponse & "</h2>"
            strResponse = strResponse & "<p>"
            strResponse = strResponse & rs("preview")
            strResponse = strResponse & "</p>"
            strResponse = strResponse & "</div>"
            rs.MoveNext
        Loop
        Response.Write strResponse

        rs.Close()
        Set rs = Nothing
    End Sub

    Public Function getTotalTags()
        Dim rs
        Dim sql
        Dim count
        count = 0

        sql = "SELECT COUNT(id) AS total FROM tag"
        Set rs = Server.CreateObject("ADODB.RecordSet")

        rs.Open sql, p_Connection

        If Not rs.BOF And Not rs.BOF Then
            count = rs("total")
        End If

        rs.Close()
        Set rs = Nothing

        ' Return
        getTotalTags = count
    End Function

    Public Sub generateTagsChart()
        Dim rs
        Dim sql
        Dim strResponse

        sql = "SELECT count(t.id) AS total, t.name FROM tag t INNER JOIN article_tag at ON at.tag_id = t.id INNER JOIN article a ON a.id = at.article_id group by t.id"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        strResponse = "["
        Do While Not rs.EOF
            strResponse = strResponse & "[ """ & rs("name") & """, "
            strResponse = strResponse & rs("total") & "],"
            rs.MoveNext
        Loop
        strResponse = strResponse & "]"
        Response.Write strResponse

        rs.Close()
        Set rs = Nothing
    End Sub

    Public Sub generateVersesChart()
        Dim rs
        Dim sql
        Dim strResponse

        sql = "SELECT 'Não possui' AS 'Objeto', COUNT(a.id) AS 'Total' FROM article a WHERE a.verse = '<br>' UNION SELECT 'Possui', COUNT(a2.id) FROM article a2 WHERE NOT a2.verse = '<br>'"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        strResponse = "["
        Do While Not rs.EOF
            strResponse = strResponse & "[ """ & rs("Objeto") & """, "
            strResponse = strResponse & rs("Total") & "],"
            rs.MoveNext
        Loop
        strResponse = strResponse & "]"
        Response.Write strResponse

        rs.Close()
        Set rs = Nothing
    End Sub

End Class
%>
