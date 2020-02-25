<!-- #include file="Utils.asp" -->
<%
Class ArticleClass
    Private p_Connection
    Private TOTAL_PER_PAGE ' Total articles shown per page
    
    Private Sub Class_Initialize()
        Set p_Connection = openConnection()
        TOTAL_PER_PAGE = 10
    End Sub

    Private Sub Class_Terminate()
        p_Connection.Close()
        Set p_Connection = Nothing
    End Sub

    Public Sub create(title, content, verse, preview, tag)
        Dim sql
        Dim sql_insert
        Dim last_number

        sql = "INSERT INTO article (title, content, verse, preview, creation_date) VALUES('" & title & "', '" & content & "', '" & verse & "', '" & preview & "', NOW())"
        p_Connection.Execute(sql)

        last_number = findLastNumber()

        ' If article has tag
        If Not Trim(tag) = "" Then
            insertArticleToTag last_number, tag
        End If

    End Sub

    Private Function findLastNumber()
        Dim sql
        Dim rs
        Dim last_number

        sql = "SELECT id FROM article ORDER BY id DESC LIMIT 1"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        last_number = rs("id")

        rs.Close()
        Set rs = Nothing

        ' Return
        findLastNumber = last_number
    End Function

    Public Sub showAllADM()
        Dim rs
        Dim sql
        Dim strResponse

        sql = "SELECT * FROM article ORDER BY id DESC"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection
        
        strResponse = "<table class='table table-bordered table-striped table-hover'>"
        strResponse = strResponse & "<thead>"
        strResponse = strResponse & "<tr><th>Id</th><th>Título</th><th>Criação</th><th>Atualização</th><th></th></tr>"
        strResponse = strResponse & "</thead>"
        strResponse = strResponse & "<tbody>"
        Do While Not rs.EOF
            strResponse = strResponse & "<tr>"
            strResponse = strResponse & "<td>" & rs("id") & "</td>"
            strResponse = strResponse & "<td><a href='admin_article_update.asp?id=" & rs("id") & "'>" & rs("title") & "</a></td>"
            strResponse = strResponse & "<td>" & Mid(rs("creation_date"), 1, 10) & "</td>"
            strResponse = strResponse & "<td>" & Mid(rs("update_date"), 1, 10) & "</td>"
            strResponse = strResponse & "<td>" & "<a href='admin_article_delete.asp?id=" & rs("id") & "' class='btn btn-danger'>Remover</a>" & "</td>"
            strResponse = strResponse & "</tr>"
            rs.MoveNext
        Loop
        strResponse = strResponse & "</tbody>"
        strResponse = strResponse & "</table>"
        Response.Write strResponse

        rs.Close()
        Set rs = Nothing

    End Sub

    ' Deprecated: use listPaged method
    Public Sub showAllHomePage()
        Dim rs
        Dim sql
        Dim strResponse

        sql = "SELECT id, title, preview FROM article order by id desc"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection
        strResponse = ""

        Do While Not rs.EOF
            strResponse = strResponse & "<div class='article-border mb-4'>"
            strResponse = strResponse & "<h2>"
            strResponse = strResponse & "<a href='article.asp?id=" & rs("id") & "'>"
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

    Public Function findById(id)

        Dim rs
        Dim rs_tag
        Dim sql
        Dim sql_tag
        Dim articleFound
        Dim recordFound

        sql = "SELECT id, title, content, verse, preview, creation_date FROM article WHERE id = " & id

        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        Set articleFound = Server.CreateObject("Scripting.Dictionary")

        recordFound = False

        Do While Not rs.EOF
            recordFound = True
            articleFound("id") = rs("id")
            articleFound("title") = rs("title")
            articleFound("content") = rs("content")
            articleFound("verse") = rs("verse")
            articleFound("preview") = rs("preview")
            articleFound("creation_date") = rs("creation_date")

            sql_tag = "SELECT t.id FROM tag t, article_tag at WHERE at.article_id = " & id & " AND t.id = at.tag_id"
            Set rs_tag = Server.CreateObject("ADODB.recordset")
            rs_tag.Open sql_tag, p_Connection

            Do While Not rs_tag.EOF
                articleFound("tag") = rs_tag("id")
                rs_tag.MoveNext
            Loop
            rs.MoveNext
        Loop
        
        If recordFound = True Then
            ' Return
            Set findById = articleFound
        Else
            ' If not found
            articleFound("id") = "NOK"
            ' Return
            Set findById = articleFound
        End If

        rs.Close()
        Set rs = Nothing
        Set articleFound = Nothing
    End Function

    Public Sub update(id, title, content, verse, preview, tag)
        Dim sql
        Dim sql_insert_tag

        sql = "UPDATE article SET title = '" & title & "', content = '" & content & "', verse = '" & verse & "', preview = '" & preview & "', update_date = NOW() WHERE id = " & id
        p_Connection.Execute(sql)

        ' Removes all tags from the article
        removeTagsFromArticle(id)

        ' If article has tag
        If Not Trim(tag) = "" Then
            insertArticleToTag id, tag
        End If
    End Sub

    Private Sub insertArticleToTag(id_article, id_tag)
        Dim sql_insert_tag

        sql_insert_tag = "INSERT INTO article_tag (article_id, tag_id) VALUES(" & id_article & ", " & id_tag & ")"
        p_Connection.Execute(sql_insert_tag)
    End Sub

    Private Sub removeTagsFromArticle(id_article)
        Dim sql

        sql = "DELETE FROM article_tag WHERE article_id = " & id_article
        p_Connection.Execute(sql)
    End Sub

    Public Sub delete(id)
        Dim sql
        sql = "DELETE FROM article WHERE id = " & id
        p_Connection.Execute(sql)
        sql = "DELETE FROM article_tag WHERE article_id = " & id
        p_Connection.Execute(sql)
    End Sub

    Public Sub searchArticleTags(idarticle)
        Dim sql
        Dim rs
        
        sql = "SELECT t.id as tag_id, t.name as tag_name FROM article_tag at, tag t WHERE at.article_id = " & idarticle & " AND at.tag_id = t.id"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        Do While Not rs.EOF
            Response.Write "<a href='tag.asp?id=" & rs("tag_id") & "'>"
            Response.Write "<span class='badge badge-primary'>" & rs("tag_name") & "</span>"
            Response.Write "</a>"
            rs.MoveNext
        Loop

        rs.Close()
        Set rs = Nothing
    End Sub

    Public Sub listPaged(page)
        Dim rs
        Dim sql
        Dim initialPage
        Dim strResponse

        ' Pagination
        page = page - 1
        initialPage = TOTAL_PER_PAGE * page

        Set rs = Server.CreateObject("ADODB.RecordSet")
        sql = "SELECT id, title, preview FROM article ORDER BY id DESC LIMIT " & initialPage & ", " & TOTAL_PER_PAGE
        rs.Open sql, p_Connection

        strResponse = ""
        
        Do While Not rs.EOF
            strResponse = strResponse & "<div class='article-border mb-4'>"
            strResponse = strResponse & "<h2>"
            strResponse = strResponse & "<a href='article.asp?id=" & rs("id") & "'>"
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

        rs.Close
        Set rs = Nothing
    End Sub

    Public Sub showPages(currentPage)
        Dim rs
        Dim sql
        Dim totalRecords
        Dim quantityPages
        Dim rest ' Rest of Division
        Dim classCurrentPage

        sql = "SELECT COUNT(id) AS total FROM article"
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open sql, p_Connection

        totalRecords = CInt(rs("total"))

        quantityPages = totalRecords / TOTAL_PER_PAGE
        rest = totalRecords Mod TOTAL_PER_PAGE
        
        If rest <> 0 Then
            quantityPages = CInt(quantityPages) + 1
        End if

        For i = 1 To quantityPages
            If i = CInt(currentPage) Then
                classCurrentPage = "current-page"
            End If
            Response.Write "<a href='/?page=" & i & "' class='badge badge-pill badge-primary " & classCurrentPage & "'>" & i & "</a>&nbsp;"
            classCurrentPage = ""
        Next

        rs.Close
        Set rs = Nothing
    End Sub

    Public Function getTotalArticles()
        Dim rs
        Dim sql
        Dim count
        count = 0

        sql = "SELECT COUNT(id) AS total FROM article"
        Set rs = Server.CreateObject("ADODB.RecordSet")

        rs.Open sql, p_Connection

        If Not rs.BOF And Not rs.BOF Then
            count = rs("total")
        End If

        rs.Close()
        Set rs = Nothing

        ' Return
        getTotalArticles = count
    End Function

End Class
%>