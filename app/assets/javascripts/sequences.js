// Dimensions of sunburst.
var width = 530;
var height = 470;
var radius = 200;//Math.min(width, height) / 2;
var fixed_number = false;
var product = null;
var legend_height = 10;
// Breadcrumb dimensions: width, height, spacing, width of tip/tail.length
var b = {
  w: 95, h: 30, s: 5, t: 10, l:10
};

// Mapping of step names to colors.
//var colors = {
//  "analytics": "#5687d1",
//  "cluster": "#7b615c",
//  "search": "#de783b",
//  "account": "#6ab975",
//  "other": "#a173d1",
//  "end": "#bbbbbb"
//};

// Total size of all segments; we set this later, after loading the data.
var totalSize = 0; 

var vis = d3.select("#chart").append("svg:svg")
    .attr("width", width)
    .attr("height", height)
    .append("svg:g")
    .attr("id", "container")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

var partition = d3.layout.partition()
    .size([2 * Math.PI, radius * radius])
    .value(function(d) { return d.size; });

var arc = d3.svg.arc()
    .startAngle(function(d) { return d.x; })
    .endAngle(function(d) { return d.x + d.dx; })
    .innerRadius(function(d) { return Math.sqrt(d.y); })
    .outerRadius(function(d) { return Math.sqrt(d.y + d.dy); });

// Use d3.text and d3.csv.parseRows so that we do not need to have a header
// row, and can receive the csv as an array of arrays.
/*d3.text("visit-sequences.csv", function(text) {
  var csv = d3.csv.parseRows(text);
  var json = buildHierarchy(csv);
  createVisualization(json);
});*/
//var dta = '{ "name": "flare", "children": [  {   "name": "analytics",   "children": [    {     "name": "cluster",     "children": [      {"name": "AgglomerativeCluster", "size": 3938},      {"name":"CommunityStructure", "size": 3812},      {"name": "HierarchicalCluster", "size": 6714},      {"name":"MergeEdge", "size": 743}     ]    },    {     "name": "graph",     "children": [      {"name":"BetweennessCentrality", "size": 3534},      {"name": "LinkDistance", "size": 5731},      {"name":"MaxFlowMinCut", "size": 7840},      {"name": "ShortestPaths", "size": 5914},      {"name": "SpanningTree","size": 3416}     ]    },    {     "name": "optimization",     "children": [      {"name":"AspectRatioBanker", "size": 7074}     ]    }   ]  },  {   "name": "animate",   "children": [    {"name": "Easing", "size": 17010},    {"name": "FunctionSequence", "size": 5842},    {     "name":"interpolate",     "children": [      {"name": "ArrayInterpolator", "size": 1983},      {"name":"ColorInterpolator", "size": 2047},      {"name": "DateInterpolator", "size": 1375},      {"name":"Interpolator", "size": 8746},      {"name": "MatrixInterpolator", "size": 2202},      {"name":"NumberInterpolator", "size": 1382},      {"name": "ObjectInterpolator", "size": 1629},      {"name":"PointInterpolator", "size": 1675},      {"name": "RectangleInterpolator", "size": 2042}     ]    },   {"name": "ISchedulable", "size": 1041},    {"name": "Parallel", "size": 5176},    {"name": "Pause", "size": 449},    {"name": "Scheduler", "size": 5593},    {"name": "Sequence", "size": 5534},    {"name": "Transition","size": 9201},    {"name": "Transitioner", "size": 19975},    {"name": "TransitionEvent", "size":1116},    {"name": "Tween", "size": 6006}   ]  },  {   "name": "data",   "children": [    {     "name":"converters",     "children": [      {"name": "Converters", "size": 721},      {"name":"DelimitedTextConverter", "size": 4294},      {"name": "GraphMLConverter", "size": 9800},      {"name":"IDataConverter", "size": 1314},      {"name": "JSONConverter", "size": 2220}     ]    },    {"name":"DataField", "size": 1759},    {"name": "DataSchema", "size": 2165},    {"name": "DataSet", "size": 586},    {"name": "DataSource", "size": 3331},    {"name": "DataTable", "size": 772},    {"name": "DataUtil","size": 3322}   ]  },  {   "name": "display",   "children": [    {"name": "DirtySprite", "size": 8833},    {"name": "LineSprite", "size": 1732},    {"name": "RectSprite", "size": 3623},    {"name": "TextSprite","size": 10066}   ]  },  {   "name": "flex",   "children": [    {"name": "FlareVis", "size": 4116}   ]  },  {   "name": "physics",   "children": [    {"name": "DragForce", "size": 1082},    {"name": "GravityForce","size": 1336},    {"name": "IForce", "size": 319},    {"name": "NBodyForce", "size": 10498},   {"name": "Particle", "size": 2822},    {"name": "Simulation", "size": 9983},    {"name": "Spring", "size": 2213},    {"name": "SpringForce", "size": 1681}   ]  },  {   "name": "query",   "children": [    {"name":"AggregateExpression", "size": 1616},    {"name": "And", "size": 1027},    {"name": "Arithmetic","size": 3891},    {"name": "Average", "size": 891},    {"name": "BinaryExpression", "size": 2893},   {"name": "Comparison", "size": 5103},    {"name": "CompositeExpression", "size": 3677},    {"name": "Count","size":781},    {"name": "DateUtil", "size": 4141},    {"name": "Distinct", "size": 933},    {"name":"Expression", "size": 5130},    {"name": "ExpressionIterator", "size": 3617},    {"name": "Fn", "size":3240},    {"name": "If", "size": 2732},    {"name": "IsA", "size": 2039},    {"name": "Literal", "size":1214},    {"name": "Match", "size": 3748},    {"name": "Maximum", "size": 843},    {     "name": "methods",     "children": [      {"name": "add", "size": 593},      {"name": "and", "size": 330},      {"name":"average", "size": 287},      {"name": "count", "size": 277},      {"name": "distinct", "size": 292},     {"name": "div", "size": 595},      {"name": "eq", "size": 594},      {"name": "fn", "size": 460},      {"name":"gt", "size": 603},      {"name": "gte", "size": 625},      {"name": "iff", "size": 748},      {"name":"isa", "size": 461},      {"name": "lt", "size": 597},      {"name": "lte", "size": 619},      {"name":"max", "size": 283},      {"name": "min", "size": 283},      {"name": "mod", "size": 591},      {"name":"mul", "size": 603},      {"name": "neq", "size": 599},      {"name": "not", "size": 386},      {"name":"or", "size": 323},      {"name": "orderby", "size": 307},      {"name": "range", "size": 772},     {"name": "select", "size": 296},      {"name": "stddev", "size": 363},      {"name": "sub", "size": 600},     {"name": "sum", "size": 280},      {"name": "update", "size": 307},      {"name": "variance", "size": 335},     {"name": "where", "size": 299},      {"name": "xor", "size": 354},      {"name": "_", "size": 264}     ]    },   {"name": "Minimum", "size": 843},    {"name": "Not", "size": 1554},    {"name": "Or", "size": 970},    {"name":"Query", "size": 13896},    {"name": "Range", "size": 1594},    {"name": "StringUtil", "size": 4130},   {"name": "Sum", "size": 791},    {"name": "Variable", "size": 1124},    {"name": "Variance", "size": 1876},   {"name": "Xor", "size": 1101}   ]  },  {   "name": "scale",   "children": [    {"name": "IScaleMap", "size": 2105},    {"name": "LinearScale", "size": 1316},    {"name": "LogScale", "size": 3151},    {"name": "OrdinalScale","size": 3770},    {"name": "QuantileScale", "size": 2435},    {"name": "QuantitativeScale", "size":4839},    {"name": "RootScale", "size": 1756},    {"name": "Scale", "size": 4268},    {"name": "ScaleType","size": 1821},    {"name": "TimeScale", "size": 5833}   ]  },  {   "name": "util",   "children": [    {"name": "Arrays", "size": 8258},    {"name": "Colors", "size": 10001},    {"name": "Dates", "size": 8217},   {"name": "Displays", "size": 12555},    {"name": "Filter", "size": 2324},    {"name": "Geometry", "size": 10993},    {     "name": "heap",     "children": [      {"name": "FibonacciHeap", "size": 9354},      {"name":"HeapNode", "size": 1233}     ]    },    {"name": "IEvaluable", "size": 335},    {"name": "IPredicate","size": 383},    {"name": "IValueProxy", "size": 874},    {     "name": "math",     "children": [      {"name": "DenseMatrix", "size": 3165},      {"name": "IMatrix", "size": 2815},      {"name": "SparseMatrix","size": 3366}     ]    },    {"name": "Maths", "size": 17705},    {"name": "Orientation", "size":1486},    {     "name": "palette",     "children": [      {"name": "ColorPalette", "size": 6367},     {"name": "Palette", "size": 1229},      {"name": "ShapePalette", "size": 2059},      {"name": "SizePalette","size":2291}     ]    },    {"name": "Property", "size": 5559},    {"name": "Shapes", "size": 19118},    {"name": "Sort", "size": 6887},    {"name": "Stats", "size": 6557},    {"name": "Strings", "size": 22026}   ]  },  {   "name": "vis",   "children": [    {     "name": "axis",     "children": [      {"name": "Axes","size": 1302},      {"name": "Axis", "size": 24593},      {"name": "AxisGridLine", "size": 652},     {"name": "AxisLabel", "size": 636},      {"name": "CartesianAxes", "size": 6703}     ]    },    {     "name":"controls",     "children": [      {"name": "AnchorControl", "size": 2138},      {"name":"ClickControl", "size": 3824},      {"name": "Control", "size": 1353},      {"name": "ControlList", "size":4665},      {"name": "DragControl", "size": 2649},      {"name": "ExpandControl", "size": 2832},     {"name": "HoverControl", "size": 4896},      {"name": "IControl", "size": 763},      {"name": "PanZoomControl","size": 5222},      {"name": "SelectionControl", "size": 7862},      {"name": "TooltipControl","size": 8435}     ]    },    {     "name": "data",     "children": [      {"name": "Data", "size":20544},      {"name": "DataList", "size": 19788},      {"name": "DataSprite", "size": 10349},      {"name":"EdgeSprite", "size": 3301},      {"name": "NodeSprite", "size": 19382},      {       "name": "render",       "children": [        {"name": "ArrowType", "size": 698},        {"name": "EdgeRenderer", "size":5569},        {"name": "IRenderer", "size": 353},        {"name": "ShapeRenderer", "size": 2247}       ]      },      {"name": "ScaleBinding", "size": 11275},      {"name": "Tree", "size": 7147},      {"name":"TreeBuilder", "size": 9930}     ]    },    {     "name": "events",     "children": [      {"name":"DataEvent", "size": 2313},      {"name": "SelectionEvent", "size": 1880},      {"name":"TooltipEvent", "size": 1701},      {"name": "VisualizationEvent", "size": 1117}     ]    },    {     "name": "legend",     "children": [      {"name": "Legend", "size": 20859},      {"name": "LegendItem","size": 4614},      {"name": "LegendRange", "size": 10530}     ]    },    {     "name": "operator",     "children": [      {       "name": "distortion",       "children": [        {"name":"BifocalDistortion", "size": 4461},        {"name": "Distortion", "size": 6314},        {"name":"FisheyeDistortion", "size": 3444}       ]      },      {       "name": "encoder",       "children": [        {"name": "ColorEncoder", "size": 3179},        {"name": "Encoder", "size": 4060},        {"name":"PropertyEncoder", "size": 4138},        {"name": "ShapeEncoder", "size": 1690},        {"name":"SizeEncoder", "size": 1830}       ]      },      {       "name": "filter",       "children": [        {"name": "FisheyeTreeFilter", "size": 5219},        {"name": "GraphDistanceFilter", "size": 3165},       {"name": "VisibilityFilter", "size": 3509}       ]      },      {"name": "IOperator", "size": 1286},      {       "name": "label",       "children": [        {"name": "Labeler", "size": 9956},        {"name":"RadialLabeler", "size": 3899},        {"name": "StackedAreaLabeler", "size": 3202}       ]      },      {       "name": "layout",       "children": [        {"name": "AxisLayout", "size": 6725},        {"name":"BundledEdgeRouter", "size": 3727},        {"name": "CircleLayout", "size": 9317},        {"name":"CirclePackingLayout", "size": 12003},        {"name": "DendrogramLayout", "size": 4853},        {"name":"ForceDirectedLayout", "size": 8411},        {"name": "IcicleTreeLayout", "size": 4864},        {"name":"IndentedTreeLayout", "size": 3174},        {"name": "Layout", "size": 7881},        {"name":"NodeLinkTreeLayout", "size": 12870},        {"name": "PieLayout", "size": 2728},        {"name":"RadialTreeLayout", "size": 12348},        {"name": "RandomLayout", "size": 870},        {"name":"StackedAreaLayout", "size": 9121},        {"name": "TreeMapLayout", "size": 9191}       ]      },     {"name": "Operator", "size": 2490},      {"name": "OperatorList", "size": 5248},      {"name": "OperatorSequence","size": 4190},      {"name": "OperatorSwitch", "size": 2581},      {"name": "SortOperator","size": 2023}     ]    },    {"name": "Visualization", "size": 16540}   ]  } ]}';
//var json = JSON.parse(dta);
//createVisualization(json);


// Main function to draw and set up the visualization, once we have the data.
function createVisualization(json) {

  // Basic setup of page elements.
  initializeBreadcrumbTrail();
  drawLegend();
  d3.select("#togglelegend").attr("checked","checked");
  toggleLegend();
  d3.select("#togglelegend").on("click", toggleLegend);

  // Bounding circle underneath the sunburst, to make it easier to detect
  // when the mouse leaves the parent g.
  vis.append("svg:circle")
      .attr("r", radius)
      .style("opacity", 0);

  // For efficiency, filter nodes to keep only those large enough to see.
  var nodes = partition.nodes(json)
      .filter(function(d) {
      return (d.dx > 0.005); // 0.005 radians = 0.29 degrees
      });

  var path = vis.data([json]).selectAll("path")
      .data(nodes)
      .enter().append("svg:path")
      .attr("display", function(d) { return d.depth ? null : "none"; })
      .attr("d", arc)
      .attr("fill-rule", "evenodd")
      .style("fill", function(d) { return colors[d.name]; })
      .style("opacity", 1)
      .on("mouseover", mouseover);

  // Add the mouseleave handler to the bounding circle.
  d3.select("#container").on("mouseleave", mouseleave);

  // Get total size of the tree = value of root node from partition.
  totalSize = path.node().__data__.value;
 };

// Fade all but the current sequence, and show it in the breadcrumb trail.
function mouseover(d) {

  var percentage = d.value;
  var percentageString = null;
  if(fixed_number == true)
  {
    percentageString = parseFloat(percentage).toFixed(2);// + "%";
  }
  else
  {
     percentageString = percentage;// + "%";
  }

  d3.select("#percentage")
      .text(percentageString);

    d3.select("#percentage")
        .style("position","relative")
        .style("top",-35 +"px")
        .style("left",-112 +"px");


  //d3.select("#percentage").attr()
      //.attr("transform", "translate(" + 0 + "," + 0 + ")" );

  d3.select("#explanation")
      .style("visibility", "");

  var sequenceArray = getAncestors(d);
  updateBreadcrumbs(sequenceArray,percentageString);

    d3.select("#product")
        .text(sequenceArray[sequenceArray.length - 1].name);

    d3.select("#product")
        .style("position","relative")
        .style("top",-35 +"px")
        .style("left",-110 +"px");

  // Fade all the segments.
  d3.selectAll("path")
      .style("opacity", 0.3);

  // Then highlight only those that are an ancestor of the current segment.
  vis.selectAll("path")
      .filter(function(node) {
                return (sequenceArray.indexOf(node) >= 0);
              })
      .style("opacity", 1);
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
  points.push(b.w  + ",0");
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
      .text(function(d) {
          product = nodeArray[nodeArray.length - 1];
          return d.name.length < 11 ? d.name : ( d.name.substring(0,8) + "..." );
      });

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

function drawLegend() {

  // Dimensions of legend item: width, height, spacing, radius of rounded rect.
  var li = {
    w: 120, h: 30, s: 3, r: 3
  };
  legend_height = d3.keys(colors).length * (li.h + li.s);
  var legend = d3.select("#legend").append("svg:svg")
      .attr("height",legend_height);

  var max_width = 0;
  var g = legend.selectAll("g")
      .data(d3.entries(colors))
      .enter().append("svg:g")
      .attr("transform", function(d, i) {
              return "translate(0," + i * (li.h + li.s) + ")";
           });

  g.append("svg:rect")
      .attr("rx", li.r)
      .attr("ry", li.r)
      .attr("width", function(d) {
          var length_b = d.key.length * 7;
          if(max_width < length_b)max_width = length_b;
          return  length_b;
      })
      .attr("height", li.h).transition().duration(3000)
      .style("fill", function(d) { return d.value; }).attr("width", max_width);

  g.append("svg:text")
      .attr("x", function(d) { return (d.key.length * 7) / 2 ; } )
      .attr("y", li.h / 2)
      .attr("dy", "0.35em")
      .attr("text-anchor", "middle")
      .text(function(d) { return d.key; }).transition().duration(3000)
      .attr("x", max_width / 2 );

  legend.attr("width", max_width);
}

function toggleLegend() {
  var legend = d3.select("#legend");
  if (legend.style("visibility") == "hidden") {
      var l = d3.select("#legend").select("svg");
      l.transition().duration(1900).attr("height",legend_height);
    legend.style("visibility", "");
  }
  else {
    var lx = d3.select("#legend").select("svg");
        lx.transition().duration(1900).attr("height",height);
    legend.style("visibility", "hidden");
  }
}

// Take a 2-column CSV and transform it into a hierarchical structure suitable
// for a partition layout. The first column is a sequence of step names, from
// root to leaf, separated by hyphens. The second column is a count of how 
// often that sequence occurred.
function buildHierarchy(csv) {
  var root = {"name": "root", "children": []};
  for (var i = 0; i < csv.length; i++) {
    var sequence = csv[i][0];
    var size = +csv[i][1];
    if (isNaN(size)) { // e.g. if this is a header row
      continue;
    }
    var parts = sequence.split("-");
    var currentNode = root;
    for (var j = 0; j < parts.length; j++) {
      var children = currentNode["children"];
      var nodeName = parts[j];
      var childNode;
      if (j + 1 < parts.length) {
   // Not yet at the end of the sequence; move down the tree.
 	var foundChild = false;
 	for (var k = 0; k < children.length; k++) {
 	  if (children[k]["name"] == nodeName) {
 	    childNode = children[k];
 	    foundChild = true;
 	    break;
 	  }
 	}
  // If we don't already have a child node for this branch, create it.
 	if (!foundChild) {
 	  childNode = {"name": nodeName, "children": []};
 	  children.push(childNode);
 	}
 	currentNode = childNode;
      } else {
 	// Reached the end of the sequence; create a leaf node.
 	childNode = {"name": nodeName, "size": size};
 	children.push(childNode);
      }
    }
  }
  return root;
};
