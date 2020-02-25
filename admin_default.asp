<!-- #include file="check_login.asp" -->
<!-- #include file="ArticleClass.asp" -->
<!-- #include file="TagClass.asp" -->
<% check_login() %>
<%
Dim objArticle
Dim objTag

Set objArticle = New ArticleClass
Set objTag = New TagClass

%>
<!-- #include file="html_header.asp" -->
<!--Load the AJAX API-->
<script
  type="text/javascript"
  src="https://www.gstatic.com/charts/loader.js"
></script>
<script type="text/javascript">
  // Load the Visualization API and the corechart package.
  google.charts.load("current", { packages: ["corechart"] });

  // Set a callback to run when the Google Visualization API is loaded.
  google.charts.setOnLoadCallback(drawChartArticlesPerTag);
  google.charts.setOnLoadCallback(drawChartArticlesWithVerse);

  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
  function drawChartArticlesPerTag() {
    // Create the data table.
    var data = new google.visualization.DataTable();
    data.addColumn("string", "Tag");
    data.addColumn("number", "Total");
    data.addRows(<%=objTag.generateTagsChart%>);

    // Set chart options
    var options = {
      title: "Artigos por Tag",
      width: 500,
      height: 400
    };

    // Instantiate and draw our chart, passing in some options.
    var chart = new google.visualization.PieChart(
      document.getElementById("chart_articles_per_tag")
    );
    chart.draw(data, options);
  }


  function drawChartArticlesWithVerse() {
    var data = new google.visualization.DataTable();
    data.addColumn("string", "Objeto");
    data.addColumn("number", "Total");
    data.addRows(<%=objTag.generateVersesChart%>);

    var options = {
      title: "Artigos com Versículo",
      width: 500,
      height: 400
    };

    var chart = new google.visualization.PieChart(
      document.getElementById("chart_articles_with_verse")
    );
    chart.draw(data, options);
  }
</script>
<h1>Administração</h1>
<h2 class="title-article">Dashboard</h2>
<div>
  <div class="row">
    <div class="col-xl-4 col-lg-4 mb-4">
      <div class="card-body">
        <div class="list-group">
          <a
            href="admin_article_default.asp"
            class="list-group-item list-group-item-action"
            >Artigos</a
          >
          <a
            href="admin_tag_default.asp"
            class="list-group-item list-group-item-action"
            >Tags</a
          >
          <a href="#" class="list-group-item list-group-item-action">Imagens</a>
        </div>
      </div>
    </div>
    <div class="col-xl-4 col-lg-4 mb-4 mt-4">
      <div class="card text-white bg-primary" style="max-width: 18rem;">
        <div class="card-body">
          <div class="row">
            <div class="col">
              <i class="far fa-newspaper fa-5x"></i>
            </div>
            <div class="col">
              <p class="card-text">
                <span class="display-1">
                  <%=objArticle.getTotalArticles%>
                </span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-xl-4 col-lg-4 mb-4 mt-4">
      <div class="card text-white bg-success" style="max-width: 18rem;">
        <div class="card-body">
          <div class="row">
            <div class="col">
              <i class="fas fa-tags fa-5x"></i>
            </div>
            <div class="col">
              <p class="card-text">
                <span class="display-1">
                  <%=objTag.getTotalTags%>
                </span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-xl-6 col-lg-6 mb-4">
      <div class="card">
        <div class="card-header">Artigos por Tag</div>
        <div class="card-body d-flex justify-content-center">
          <div id="chart_articles_per_tag"></div>
        </div>
      </div>
    </div>
    <div class="col-xl-6 col-lg-6 mb-4">
      <div class="card">
        <div class="card-header">Artigos com Versículo</div>
        <div class="card-body d-flex justify-content-center">
          <div id="chart_articles_with_verse"></div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- #include file="html_footer.asp" -->
