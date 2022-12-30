import 'package:classes/hard.dart' show ColouredGraph;

void main(List<String> args) {
  // adjacency matrix denotes whether two vertices have an edge to each other
  final adjacencyMatrix = [
    [false, false, true, true, false], // v0 has an edge to v2 and v3
    [false, false, true, false, true], 
    [true, true, false, true, true],
    [true, false, true, false, false],
    [false, true, true, false, false]
  ];
  final colouredGraph = ColouredGraph(adjacencyMatrix);
  // if we can colour the graph using 2 colours, print the colours for each of the vertices
  if (colouredGraph.colour(2)) {
    print('Can colour using 2 colours!');
    print(colouredGraph.colours);
  } else {
    print('Cannot colour using 2 colours!');
  }
  // if we can colour the graph using 3 colours, print the colours for each of the vertices
  if (colouredGraph.colour(3)) {
    print('Can colour using 3 colours!');
    print(colouredGraph.colours);
  } else {
    print('Cannot colour using 3 colours!');
  }
}
