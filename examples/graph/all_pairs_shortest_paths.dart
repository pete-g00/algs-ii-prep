import 'package:classes/graph.dart' show WeightedGraph;

void main(List<String> args) {
  final weightMatrix = [
    [null, -5, null, null],
    [null, null, 2, null],
    [null, null, null, null],
    [3, -1, 3, null]
  ];
  final graph = WeightedGraph(weightMatrix);
  
  // perform the all-pairs-shortest-paths using the Floyd-Warshall algorithm
  graph.floydWarshall();
  // get the shortest paths between the vertices (as a matrix like the weighted matrix)
  print(graph.shortestPaths);
  // gets the predecessor vertex between the vertices (as a matrix)
  print(graph.predecessors);
}
