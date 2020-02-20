<!-- #include file="../../config/config.asp" -->
<!-- #include file="../../src/Tag.asp" -->
<!-- #include file="../../src/check_login.asp" -->
<%
check_login()

Dim objTag
Dim tags

Set objTag = New Tag
%>
<!-- #include file="../../src/html_header.asp" -->
      <h1><a href="../">Administração</a> | Tags</h1>
      <a href="/admin/tag/adicionar-tag.asp" class="btn btn-primary mb-2">Adicionar Tag</a>
      <% objTag.exibirTodosADM() %>
<!-- #include file="../../src/html_footer.asp" -->
