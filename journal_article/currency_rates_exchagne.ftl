<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
    var currencyController = null;

    var initExchange = function(data) {
        var base = data.base;
        var rates = data.rates;
        var dataArray = new Array();
        currencyController.empty();
        currencyController.append("<li class='active'><a>" + base + "</a></li>");
        dataArray.push(["Currency", "Rate", { role: "style" } ]);
        
        for (var key in rates) {
          if (rates.hasOwnProperty(key)) {
            dataArray.push([key, rates[key], "color: #6a708b"])
            currencyController.append("<li><a href='#' onclick='return reloadExchanges(\""+key+"\");' >" + key + "</a></li>");
          }
        }
        
        google.charts.load("current", {packages:["corechart"]});
        google.charts.setOnLoadCallback(drawChart);
        
        function drawChart() {
          var data = google.visualization.arrayToDataTable(dataArray);

          var view = new google.visualization.DataView(data);
          view.setColumns([0, 1,
                           { calc: "stringify",
                             sourceColumn: 1,
                             type: "string",
                             role: "annotation" },
                           2]);

          var options = {
            width: 750,
            height: 200,
            bar: {groupWidth: "25%"},
            legend: { position: "none" },
            animation:{
                duration: 1000,
                easing: 'out',
                startup: true,
            },
          };
          var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
          chart.draw(view, options);
        }
    }
    

    function reloadExchanges(currency){
        $.getJSON("http://api.fixer.io/latest?symbols=USD,GBP,EUR,BRL&base=" + currency, initExchange);
        return false;
    }

    $(document).ready(function(){
        currencyController = $('#curency_list');    
        $.getJSON("http://api.fixer.io/latest?symbols=USD,GBP,EUR,BRL&base=GBP", initExchange);

    });
</script>

<div class="row row-spacing">
    <div class="col-md-2">
        <ul id="curency_list" class="nav nav-pills nav-stacked"></ul>
    </div>
    <div class="col-md-10" id="barchart_values" ></div>
</div>