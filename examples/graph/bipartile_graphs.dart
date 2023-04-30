import 'package:classes/graph.dart' show LeftVertex, RightVertex, BipartileGraph;

void main(List<String> args) {
  final v0 = LeftVertex<void, void>(null);
  final v1 = LeftVertex<void, void>(null);
  final v2 = LeftVertex<void, void>(null);
  final v3 = LeftVertex<void, void>(null);
  final v4 = LeftVertex<void, void>(null);
  
  final v5 = RightVertex<void, void>(null);
  final v6 = RightVertex<void, void>(null);
  final v7 = RightVertex<void, void>(null);
  final v8 = RightVertex<void, void>(null);
  final v9 = RightVertex<void, void>(null);

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
  final bipartileGraph = BipartileGraph<void, void>(leftVertices);
  
  // find the maximum matching for the bipartile graph
  print(bipartileGraph.match());
  // find the mate edge for v1 
  print(v1.mateEdge);
}
