<!-- #include file="TagClass.asp" -->
<!-- #include file="check_login.asp" -->
<%
check_login()

Dim objTag

Set objTag = New TagClass
%>
<!-- #include file="html_header.asp" -->
      <h1><a href="admin_default.asp">Administração</a></h1>
      <h2 class="title-article">Tags</h2>
      <a href="admin_tag_add.asp" class="btn btn-primary mb-2">Adicionar Tag</a>
      <div class="table-responsive">
            <% objTag.showAllADM() %>
      </div>
<!-- #include file="html_footer.asp" -->
