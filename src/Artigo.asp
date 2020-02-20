<!-- #include file="../config/config.asp" -->
<%
Class Artigo
    Private conexao
    
    Private Sub Class_Initialize()
        Set conexao = openConnection()
    End Sub

    Private Sub Class_Terminate()
        conexao.Close()
    End Sub

    Public Sub adicionar(titulo, conteudo, versiculo, preview, tag)
        Dim sql
        Dim sql_insert
        Dim ultimo_numero

        sql = "INSERT INTO artigo (titulo, conteudo, versiculo, preview) VALUES('" & titulo & "', '" & conteudo & "', '" & versiculo & "', '" & preview & "')"
        conexao.Execute(sql)

        ultimo_numero = buscaUltimoNumero()

        ' Se artigo possui tag
        ' TODO: Extrair para uma funcao
        If Not Trim(tag) = "" Then
            sql_insert = "INSERT INTO artigo_tag (artigo_id, tag_id) VALUES(" & ultimo_numero & ", " & tag & ")"
            conexao.Execute(sql_insert)
        End If

    End Sub

    Private Function buscaUltimoNumero()
        Dim sql
        Dim rs
        Dim ultimo_numero

        sql = "SELECT id FROM artigo ORDER BY id DESC LIMIT 1"
        rs = conexao.Execute(sql)

        ultimo_numero = rs("id")

        ' Return
        buscaUltimoNumero = ultimo_numero
    End Function

    Public Function exibirTodosADM()
        Dim rs
        Dim sql

        sql = "SELECT * FROM artigo ORDER BY id DESC"
        Set rs = conexao.Execute(sql)
        
        Response.Write "<table class='table table-bordered table-striped table-hover'>"
        Do While Not rs.EOF
            Response.Write "<tr>"
            Response.Write "<td>" & rs("id") & "</td>"
            Response.Write "<td><a href='editar-artigo.asp?id=" & rs("id") & "'>" & rs("titulo") & "</a></td>"
            Response.Write "<td>" & "<a href='excluir-artigo.asp?id=" & rs("id") & "' class='btn btn-danger'>Remover</a>" & "</td>"
            Response.Write "</tr>"
            rs.MoveNext
        Loop
        Response.Write "</table>"

    End Function

    Public Sub exibirTodosNoBlog()
        Dim rs
        Dim sql

        sql = "SELECT id, titulo, preview FROM artigo order by id desc"
        Set rs = conexao.Execute(sql)
        
        Do While Not rs.EOF
            Response.Write "<div class='border-artigo mb-4'>"
            Response.Write "<h2>"
            Response.Write "<a href='artigo.asp?id=" & rs("id") & "'>"
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

    Public Function encontrarPorId(id)

        Dim rs
        Dim rs_tag
        Dim sql
        Dim sql_tag
        Dim artigoEncontrado

        sql = "SELECT id, titulo, conteudo, versiculo, preview FROM artigo WHERE id = " & id

        rs = conexao.Execute(sql)
        Set artigoEncontrado = Server.CreateObject("Scripting.Dictionary")
        artigoEncontrado("id") = rs("id")
        artigoEncontrado("titulo") = rs("titulo")
        artigoEncontrado("conteudo") = rs("conteudo")
        artigoEncontrado("versiculo") = rs("versiculo")
        artigoEncontrado("preview") = rs("preview")

        sql_tag = "SELECT t.id FROM tag t, artigo_tag at WHERE at.artigo_id = " & id & " AND t.id = at.tag_id"
        Set rs_tag = Server.CreateObject("ADODB.recordset")
        rs_tag.Open sql_tag, conexao

        Do While Not rs_tag.EOF
            artigoEncontrado("tag") = rs_tag("id")
            rs_tag.MoveNext
        Loop

        Set encontrarPorId = artigoEncontrado

    End Function

    Public Sub editar(id, titulo, conteudo, versiculo, preview, tag)
        Dim sql
        Dim sql_insert_tag

        sql = "UPDATE artigo SET titulo = '" & titulo & "', conteudo = '" & conteudo & "', versiculo = '" & versiculo & "', preview = '" & preview & "' WHERE id = " & id
        conexao.Execute(sql)

        ' Remove todas as tags do artigo
        removeTagsDoArtigo(id)

        ' Se artigo possui tag
        If Not Trim(tag) = "" Then
            relacionaArtigoTag id, tag
        End If
    End Sub

    Private Sub relacionaArtigoTag(id_artigo, id_tag)
        Dim sql_insert_tag

        sql_insert_tag = "INSERT INTO artigo_tag (artigo_id, tag_id) VALUES(" & id_artigo & ", " & id_tag & ")"
        conexao.Execute(sql_insert_tag)
    End Sub

    Private Sub removeTagsDoArtigo(id_artigo)
        Dim sql

        sql = "DELETE FROM artigo_tag WHERE artigo_id = " & id_artigo
        conexao.Execute(sql)
    End Sub

    Public Sub remover(id)
        Dim sql
        sql = "DELETE FROM artigo WHERE id = " & id
        conexao.Execute(sql)
    End Sub

    Public Sub buscarTagsDoArtigo(idArtigo)

        Dim sql
        Dim rs
        
        sql = "SELECT t.id as tag_id, t.nome as tag_nome FROM artigo_tag at, tag t WHERE at.artigo_id = " & idArtigo & " AND at.tag_id = t.id"
        ' Response.Write sql & "<br>"
        Set rs = conexao.Execute(sql)

        Do While Not rs.EOF
            Response.Write "<a href='tag.asp?id=" & rs("tag_id") & "'>"
            Response.Write "<span class='badge badge-primary'>" & rs("tag_nome") & "</span>"
            Response.Write "</a>"
            rs.MoveNext
        Loop

    End Sub

End Class
%>