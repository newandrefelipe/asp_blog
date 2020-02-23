<!-- #include file="../src/Utils.asp" -->
<%
Class Tag

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
        sql = "INSERT INTO tag (nome) VALUES('" & name & "')"
        p_Connection.Execute(sql)
    End Sub

    Public Sub update(id, name)
        Dim sql
        sql = "UPDATE tag SET nome = '" & name & "' WHERE id = " & id
        p_Connection.Execute(sql)
    End Sub

    Public Sub delete(id)
        Dim sql
        sql = "DELETE FROM tag WHERE id = " & id
        p_Connection.Execute(sql)
        sql = "DELETE FROM artigo_tag WHERE tag_id = " & id
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
            strResponse = strResponse & "<td><a href='update-tag.asp?id=" & rs("id") & "'>" & rs("nome") & "</a></td>"
            strResponse = strResponse & "<td>" & "<a href='delete-tag.asp?id=" & rs("id") & "' class='btn btn-danger'>Remover</a>" & "</td>"
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

        sql = "SELECT id, nome FROM tag WHERE id = " & id

        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        Set tagFound = Server.CreateObject("Scripting.Dictionary")
        tagFound("id") = rs("id")
        tagFound("name") = rs("nome")

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

        sql = "SELECT id, nome FROM tag ORDER BY nome ASC"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        Response.Write "<option value=''>Selecione...</option>"
        Do While Not rs.EOF
            If rs("id") = selected_id Then
                selected = "selected"
            End If

            Response.Write "<option value='" & rs("id") & "' " & selected & ">" & rs("nome") & "</option>"
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

        sql = "SELECT a.id as id_artigo, a.titulo, a.preview FROM artigo a, artigo_tag at WHERE at.tag_id = " & id_tag & " AND at.artigo_id = a.id ORDER BY id_artigo DESC"

        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection
        
        strResponse = ""
        Do While Not rs.EOF
            strResponse = strResponse & "<div class='article-border mb-4'>"
            strResponse = strResponse & "<h2>"
            strResponse = strResponse & "<a href='article.asp?id=" & rs("id_artigo") & "'>"
            strResponse = strResponse & rs("titulo")
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

End Class
%>
