import 'package:classes/graph.dart' show NetworkVertex, NetworkGraph;

void main(List<String> args) {
  // construct network vertices
  final v0 = NetworkVertex();
  final v1 = NetworkVertex();
  final v2 = NetworkVertex();
  final v3 = NetworkVertex();
  final v4 = NetworkVertex();
  final v5 = NetworkVertex();
  final v6 = NetworkVertex();
  final v7 = NetworkVertex(true);

  // add edges from a vertex to another one with flow capacity
  v0.addEdge(v1, 4);
  v0.addEdge(v3, 2);
  v0.addEdge(v5, 2);
  v1.addEdge(v2, 3);
  v1.addEdge(v4, 4);
  v2.addEdge(v7, 1);
  v3.addEdge(v2, 3);
  v3.addEdge(v4, 2);
  v4.addEdge(v6, 3);
  v4.addEdge(v7, 5);
  v5.addEdge(v3, 3);
  v6.addEdge(v5, 1);
  v6.addEdge(v7, 2);

  // construct the network graph with source v0
  final graph = NetworkGraph(v0);
  // compute the max flow
  graph.maxFlow();

  // print data about edges for v0 (capacity and flow)
  for (var i = 0; i < v0.edges.length; i++) {
    print(v0.edges[i]);
  }
}
