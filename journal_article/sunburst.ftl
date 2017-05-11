<script src="http://d3js.org/d3.v3.min.js"></script>
<script>
  var dataURL = "${DataURL.getData()}"; //"http://localhost:4080/documents/55085/0/flare.json/ec5e6134-c562-6686-b41a-3a447d015ee2?download=true"
  var breadcrumb = false;
  <#if getterUtil.getBoolean(Breadcrumb.getData())> breadcrumb = true; </#if>
  var colors = {
    <#if Label.getSiblings()?has_content> <#list Label.getSiblings() as cur_Label> "${cur_Label.getData()}": "${cur_Label.getChild("Color").getData()}", </#list> </#if>
  };
</script>
<script>
$(document).ready(function(){
  var width = 750;
  var height = 600;
   var   radius = Math.min(width, height) / 2;

  // Total size of all segments; we set this later, after loading the data.
  var totalSize = 0; 

  var x = d3.scale.linear()
      .range([0, 2 * Math.PI]);

  var y = d3.scale.linear()
      .range([0, radius]);

  var color = d3.scale.category20c();
  // Breadcrumb dimensions: width, height, spacing, width of tip/tail.
  var b = {
    w: 200, h: 30, s: 3, t: 10
  };

  var svg = d3.select("#sunburst").append("svg")
      .attr("width", width)
      .attr("height", height)
      .attr("id", "container")
      .append("g")
      .attr("transform", "translate(" + width / 2 + "," + (height / 2 + 10) + ")");

svg.append("svg:circle")
        .attr("r", radius)
        .style("opacity", 0);


  var partition = d3.layout.partition()
      .value(function(d) { return d.size; });

  var arc = d3.svg.arc()
      .startAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x))); })
      .endAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx))); })
      .innerRadius(function(d) { return Math.max(0, y(d.y)); })
      .outerRadius(function(d) { return Math.max(0, y(d.y + d.dy)); });

  d3.json("http://localhost:4080/documents/55085/0/flare.json/ec5e6134-c562-6686-b41a-3a447d015ee2?download=true", function(error, root) {
    var g = svg.selectAll("g")
        .data(partition.nodes(root))
      .enter().append("g");
    
    var path = g.append("path")
      .attr("d", arc)
      .attr("fill-rule", "evenodd")
      .style("fill", function(d) { return d.depth ? colors[d.name] : "transparent" })
      .on("click", click)
      .on("mouseover",mouseover);


    /*var text = g.append("text")
      .attr("transform", function(d) { return "rotate(" + computeTextRotation(d) + ")"; })
      .attr("x", function(d) { return y(d.y); })
      .attr("dx", "6") // margin
      .attr("dy", ".35em") // vertical-align
      .text(function(d) { return d.name; });*/

    function click(d) {
      // fade out all text elements
      //text.transition().attr("opacity", 0);

      path.transition()
        .duration(750)
        .attrTween("d", arcTween(d))
        .each("end", function(e, i) {
            // check if the animated element's data e lies within the visible angle span given in d
            /*if (e.x >= d.x && e.x < (d.x + d.dx)) {
              // get a selection of the associated text element
              var arcText = d3.select(this.parentNode).select("text");
              // fade in the text element and recalculate positions
              arcText.transition().duration(750)
                .attr("opacity", 1)
                .attr("transform", function() { return "rotate(" + computeTextRotation(e) + ")" })
                .attr("x", function(d) { return y(d.y); });
            }*/
        });
    } 

    // Basic setup of page elements.
    initializeBreadcrumbTrail();
    drawLegend();
    d3.select("#togglelegend").on("click", toggleLegend);
       
    // Add the mouseleave handler to the bounding circle.
    d3.select("#container").on("mouseleave", mouseleave);

    // Get total size of the tree = value of root node from partition.
    totalSize = path.node().__data__.value;
  });

  d3.select(self.frameElement).style("height", height + "px");

  // Interpolate the scales!
  function arcTween(d) {
    var xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
        yd = d3.interpolate(y.domain(), [d.y, 1]),
        yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
    return function(d, i) {
      return i
          ? function(t) { return arc(d); }
          : function(t) { x.domain(xd(t)); y.domain(yd(t)).range(yr(t)); return arc(d); };
    };
  }

  function computeTextRotation(d) {
    return (x(d.x + d.dx / 2) - Math.PI / 2) / Math.PI * 180;
  }

  // Fade all but the current sequence, and show it in the breadcrumb trail.
  function mouseover(d) {

    var percentage = (100 * d.value / totalSize).toPrecision(3);
    var percentageString = percentage + "%";
    if (percentage < 0.1) {
      percentageString = "< 0.1%";
    }

    d3.select("#percentage")
        .text(percentageString);

    d3.select("#explanation")
        .style("visibility", "");

    var sequenceArray = getAncestors(d);
    updateBreadcrumbs(sequenceArray, percentageString);

    // Fade all the segments.
    d3.selectAll("path")
        .style("opacity", 0.3);

    // Then highlight only those that are an ancestor of the current segment.
    d3.selectAll("path")
        .filter(function(node) {
                  return (sequenceArray.indexOf(node) >= 0);
                })
        .style("opacity", 1);
  }

    // Given a node in a partition layout, return an array of all of its ancestor
  // nodes, highest first, but excluding the root.
  function getAncestors(node) {
    var path = [];
    var current = node;
    while (current.parent) {
      path.unshift(current);
      current = current.parent;
    }
    return path;
  }

function initializeBreadcrumbTrail() {
    // Add the svg area.
    var trail = d3.select("#sequence").append("svg:svg")
        .attr("width", width)
        .attr("height", 50)
        .attr("id", "trail");
    // Add the label at the end, for the percentage.
    trail.append("svg:text")
      .attr("id", "endlabel")
      .style("fill", "#000");
  }

  // Generate a string that describes the points of a breadcrumb polygon.
  function breadcrumbPoints(d, i) {
    var points = [];
    points.push("0,0");
    points.push(b.w + ",0");
    points.push(b.w + b.t + "," + (b.h / 2));
    points.push(b.w + "," + b.h);
    points.push("0," + b.h);
    if (i > 0) { // Leftmost breadcrumb; don't include 6th vertex.
      points.push(b.t + "," + (b.h / 2));
    }
    return points.join(" ");
  }

  // Update the breadcrumb trail to show the current sequence and percentage.
  function updateBreadcrumbs(nodeArray, percentageString) {

    // Data join; key function combines name and depth (= position in sequence).
    var g = d3.select("#trail")
        .selectAll("g")
        .data(nodeArray, function(d) { return d.name + d.depth; });

    // Add breadcrumb and label for entering nodes.
    var entering = g.enter().append("svg:g");

    entering.append("svg:polygon")
        .attr("points", breadcrumbPoints)
        .style("fill", function(d) { return colors[d.name]; });

    entering.append("svg:text")
        .attr("x", (b.w + b.t) / 2)
        .attr("y", b.h / 2)
        .attr("dy", "0.35em")
        .attr("text-anchor", "middle")
        .text(function(d) { return d.name; });

    // Set position for entering and updating nodes.
    g.attr("transform", function(d, i) {
      return "translate(" + i * (b.w + b.s) + ", 0)";
    });

    // Remove exiting nodes.
    g.exit().remove();

    // Now move and update the percentage at the end.
    d3.select("#trail").select("#endlabel")
        .attr("x", (nodeArray.length + 0.5) * (b.w + b.s))
        .attr("y", b.h / 2)
        .attr("dy", "0.35em")
        .attr("text-anchor", "middle")
        .text(percentageString);

    // Make the breadcrumb trail visible, if it's hidden.
    d3.select("#trail")
        .style("visibility", "");

  }

   // Restore everything to full opacity when moving off the visualization.
  function mouseleave(d) {

    // Hide the breadcrumb trail
    d3.select("#trail")
        .style("visibility", "hidden");

    // Deactivate all segments during transition.
    d3.selectAll("path").on("mouseover", null);

    // Transition each segment to full opacity and then reactivate it.
    d3.selectAll("path")
        .transition()
        .duration(1000)
        .style("opacity", 1)
        .each("end", function() {
                d3.select(this).on("mouseover", mouseover);
              });

    d3.select("#explanation")
        .style("visibility", "hidden");
  }

  function drawLegend() {

    // Dimensions of legend item: width, height, spacing, radius of rounded rect.
    var li = {
      w: 200, h: 30, s: 3, r: 3
    };

    var legend = d3.select("#legend").append("svg:svg")
        .attr("width", li.w)
        .attr("height", d3.keys(colors).length * (li.h + li.s));

    var g = legend.selectAll("g")
        .data(d3.entries(colors))
        .enter().append("svg:g")
        .attr("transform", function(d, i) {
                return "translate(0," + i * (li.h + li.s) + ")";
             });

    g.append("svg:rect")
        .attr("rx", li.r)
        .attr("ry", li.r)
        .attr("width", li.w)
        .attr("height", li.h)
        .style("fill", function(d) { return d.value; });

    g.append("svg:text")
        .attr("x", li.w / 2)
        .attr("y", li.h / 2)
        .attr("dy", "0.35em")
        .attr("text-anchor", "middle")
        .text(function(d) { return d.key; });
  }

  function toggleLegend() {
    var legend = d3.select("#legend");
    if (legend.style("visibility") == "hidden") {
      legend.style("visibility", "");
    } else {
      legend.style("visibility", "hidden");
    }
  }

});
</script>

<style>


#main {
  float: left;
  width: 750px;
}

#sidebar {
  float: right;
  width: auto;
}

#sequence {
  width: 600px;
  height: 70px;
}

#legend {
  padding: 10px 0 0 3px;
}

#sequence text, #legend text {
  font-weight: 600;
  fill: #fff;
}

#chart {
  position: relative;
}

#chart path {
  stroke: #fff;
}

#explanation {
    position: absolute;
    right: 15%;
    top: 2em;
    color: #666;
    z-index: -1;
    float: right;
}

#percentage {
  font-size: 2.5em;
}
</style>

 <div id="main">
    <div id="sequence"></div>
    <div id="sunburst">        
      <div id="explanation" style="visibility: hidden;">
        <span id="percentage"></span><br/>
        of tranfers
      </div>
    </div>
  </div>
  <div id="sidebar">
    <input type="checkbox" id="togglelegend"> Legend<br/>
    <div id="legend" style="visibility: hidden;"></div>
  </div>
