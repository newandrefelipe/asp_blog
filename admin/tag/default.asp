<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim objTag

Set objTag = New Tag
%>
<!-- #include file="../../src/html_header.asp" -->
      <h1><a href="../">Administração</a> | Tags</h1>
      <a href="/admin/tag/add-tag.asp" class="btn btn-primary mb-2">Adicionar Tag</a>
      <div class="table-responsive">
            <% objTag.showAllADM() %>
      </div>
<!-- #include file="../../src/html_footer.asp" -->
