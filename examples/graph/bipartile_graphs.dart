import 'package:classes/graph.dart' show Vertex, BipartileGraph;

void main(List<String> args) {
  final v0 = Vertex();
  final v1 = Vertex();
  final v2 = Vertex();
  final v3 = Vertex();
  final v4 = Vertex();
  
  final v5 = Vertex();
  final v6 = Vertex();
  final v7 = Vertex();
  final v8 = Vertex();
  final v9 = Vertex();

  v0.addUndirectedEdge(v5);
  v0.addUndirectedEdge(v6);
  v1.addUndirectedEdge(v5);
  v1.addUndirectedEdge(v7);
  v2.addUndirectedEdge(v5);
  v2.addUndirectedEdge(v7);
  v2.addUndirectedEdge(v8);
  v3.addUndirectedEdge(v6);
  v3.addUndirectedEdge(v7);
  v3.addUndirectedEdge(v9);
  v4.addUndirectedEdge(v8);
  
  final leftVertices = [v0, v1, v2, v3, v4];
  final bipartileGraph = BipartileGraph(leftVertices);
  
  // find the maximum matching for the bipartile graph
  print(bipartileGraph.match());
  // find the mate edge for v1 
  print(v1.mateEdge);
}
