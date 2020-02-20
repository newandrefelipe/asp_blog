<!-- #include file="../config/config.asp" -->
<%
Class Tag

    Private conexao

    Private Sub Class_Initialize()
        Set conexao = openConnection()
    End Sub

    Private Sub Class_Terminate()
        conexao.Close()
    End Sub

    Public Sub adicionar(nome)
        Dim sql
        sql = "INSERT INTO tag (nome) VALUES('" & nome & "')"
        conexao.Execute(sql)
    End Sub

    Public Sub editar(id, nome)
        Dim sql
        sql = "UPDATE tag SET nome = '" & nome & "' WHERE id = " & id
        conexao.Execute(sql)
    End Sub

    Public Sub remover(id)
        Dim sql
        sql = "DELETE FROM tag WHERE id = " & id
        conexao.Execute(sql)
    End Sub

    Public Sub exibirTodosADM()
        Dim rs
        Dim sql

        sql = "SELECT * FROM tag ORDER BY id DESC"
        Set rs = conexao.Execute(sql)
        
        Response.Write "<table class='table table-bordered table-striped table-hover'>"
        Do While Not rs.EOF
            Response.Write "<tr>"
            Response.Write "<td>" & rs("id") & "</td>"
            Response.Write "<td><a href='editar-tag.asp?id=" & rs("id") & "'>" & rs("nome") & "</a></td>"
            Response.Write "<td>" & "<a href='excluir-tag.asp?id=" & rs("id") & "' class='btn btn-danger'>Remover</a>" & "</td>"
            Response.Write "</tr>"
            rs.MoveNext
        Loop
        Response.Write "</table>"
    End Sub

    Public Function encontrarPorId(id)

        Dim rs
        Dim sql
        Dim tagEncontrada

        sql = "SELECT id, nome FROM tag WHERE id = " & id

        rs = conexao.Execute(sql)
        Set tagEncontrada = Server.CreateObject("Scripting.Dictionary")
        tagEncontrada("id") = rs("id")
        tagEncontrada("nome") = rs("nome")

        Set encontrarPorId = tagEncontrada

    End Function

    Public Sub getTagsOptions(id_selecionado)

        Dim sql
        Dim rs
        Dim selected

        sql = "SELECT id, nome FROM tag ORDER BY nome ASC"
        Set rs = conexao.Execute(sql)

        Response.Write "<option value=''>Selecione...</option>"
        Do While Not rs.EOF
            If rs("id") = id_selecionado Then
                selected = "selected"
            End If

            Response.Write "<option value='" & rs("id") & "' " & selected & ">" & rs("nome") & "</option>"
            selected = ""
            rs.MoveNext
        Loop
    End Sub

    Public Sub exibirArtigosDaTag(id_tag)
        Dim rs
        Dim sql

        sql = "SELECT a.id as id_artigo, a.titulo, a.preview FROM artigo a, artigo_tag at WHERE at.tag_id = " & id_tag & " AND at.artigo_id = a.id ORDER BY id_artigo DESC"

        Set rs = conexao.Execute(sql)
        
        Do While Not rs.EOF
            Response.Write "<div class='border-artigo mb-4'>"
            Response.Write "<h2>"
            Response.Write "<a href='artigo.asp?id=" & rs("id_artigo") & "'>"
            Response.Write rs("titulo")
            Response.Write "</a>"
            Response.Write "</h2>"
            Response.Write "<p>"
            Response.Write rs("preview")
            Response.Write "</p>"
            Response.Write "</div>"
            rs.MoveNext
        Loop
    End Sub

End Class
%>
