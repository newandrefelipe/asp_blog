<!-- #include file="../config/config.asp" -->
<%
Class Artigo
    Private conexao
    Private TOTAL_POR_PAGINA ' Total de artigos mostrados por pagina
    
    Private Sub Class_Initialize()
        Set conexao = openConnection()
        TOTAL_POR_PAGINA = 10
    End Sub

    Private Sub Class_Terminate()
        conexao.Close()
    End Sub

    Public Sub adicionar(titulo, conteudo, versiculo, preview, tag)
        Dim sql
        Dim sql_insert
        Dim ultimo_numero

        sql = "INSERT INTO artigo (titulo, conteudo, versiculo, preview, data_criacao) VALUES('" & titulo & "', '" & conteudo & "', '" & versiculo & "', '" & preview & "', NOW())"
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

        sql = "SELECT id, titulo, conteudo, versiculo, preview, data_criacao FROM artigo WHERE id = " & id

        ' rs = conexao.Execute(sql)
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, conexao

        Set artigoEncontrado = Server.CreateObject("Scripting.Dictionary")

        registroEncontrado = False

        Do While Not rs.EOF
            registroEncontrado = True
            artigoEncontrado("id") = rs("id")
            artigoEncontrado("titulo") = rs("titulo")
            artigoEncontrado("conteudo") = rs("conteudo")
            artigoEncontrado("versiculo") = rs("versiculo")
            artigoEncontrado("preview") = rs("preview")
            artigoEncontrado("data_criacao") = rs("data_criacao")

            sql_tag = "SELECT t.id FROM tag t, artigo_tag at WHERE at.artigo_id = " & id & " AND t.id = at.tag_id"
            Set rs_tag = Server.CreateObject("ADODB.recordset")
            rs_tag.Open sql_tag, conexao

            Do While Not rs_tag.EOF
                artigoEncontrado("tag") = rs_tag("id")
                rs_tag.MoveNext
            Loop
            rs.MoveNext
        Loop
        
        If registroEncontrado = True Then
            ' Return
            Set encontrarPorId = artigoEncontrado
        Else
            ' Se nao encontrado
            artigoEncontrado("id") = "NOK"
            Set encontrarPorId = artigoEncontrado
        End If
    End Function

    Public Sub editar(id, titulo, conteudo, versiculo, preview, tag)
        Dim sql
        Dim sql_insert_tag

        sql = "UPDATE artigo SET titulo = '" & titulo & "', conteudo = '" & conteudo & "', versiculo = '" & versiculo & "', preview = '" & preview & "', data_atualizacao = NOW() WHERE id = " & id
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
        Set rs = conexao.Execute(sql)

        Do While Not rs.EOF
            Response.Write "<a href='tag.asp?id=" & rs("tag_id") & "'>"
            Response.Write "<span class='badge badge-primary'>" & rs("tag_nome") & "</span>"
            Response.Write "</a>"
            rs.MoveNext
        Loop

    End Sub

    Public Sub listarPaginado(pagina)
        Dim rs
        Dim sql
        Dim paginaInicial

        ' Paginacao
        pagina = pagina - 1
        paginaInicial = TOTAL_POR_PAGINA * pagina

        Set rs = Server.CreateObject("ADODB.RecordSet")
        sql = "SELECT id, titulo, preview FROM artigo ORDER BY id DESC LIMIT " & paginaInicial & ", " & TOTAL_POR_PAGINA
        rs.Open sql, conexao
        
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
        rs.Close
    End Sub

    Public Sub mostrarPaginas(paginaAtual)
        Dim rs
        Dim sql
        Dim totalRegistros
        Dim quantidadePaginas
        Dim possuiPaginaExtra ' Se Total Registros / Total por Pagina <> 0
        Dim resto
        Dim classePaginaAtual

        sql = "SELECT COUNT(id) AS total FROM artigo"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, conexao

        totalRegistros = CInt(rs("total"))

        quantidadePaginas = totalRegistros / TOTAL_POR_PAGINA
        resto = totalRegistros Mod TOTAL_POR_PAGINA
        
        If resto <> 0 Then
            quantidadePaginas = CInt(quantidadePaginas) + 1
        End if

        For i = 1 To quantidadePaginas
            If i = CInt(paginaAtual) Then
                classePaginaAtual = "pagina-atual"
            End If
            Response.Write "<a href='/?pagina=" & i & "' class='badge badge-pill badge-primary " & classePaginaAtual & "'>" & i & "</a>&nbsp;"
            classePaginaAtual = ""
        Next

        rs.Close
    End Sub

End Class
%>