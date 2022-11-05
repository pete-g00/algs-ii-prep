library graph;

import 'dart:collection';
import 'package:quiver/core.dart';
import 'dart:math' show min;

part 'graph/bipartile_graph.dart';
part 'graph/network_flow.dart';

void main(List<String> args) {
  // final v0 = NetworkVertex();
  // final v1 = NetworkVertex();
  // final v2 = NetworkVertex();
  // final v3 = NetworkVertex();

  // v0.addEdge(v1, 2);
  // v0.addEdge(v2, 3);
  // v1.addEdge(v2, 1);
  // v1.addEdge(v3, 3);
  // v2.addEdge(v3, 2);

  // final graph = NetworkGraph(v0);
  // graph.maxFlow();

  final v0 = NetworkVertex();
  final v1 = NetworkVertex();
  final v2 = NetworkVertex();
  final v3 = NetworkVertex();
  final v4 = NetworkVertex();
  final v5 = NetworkVertex(true);

  v0.addEdge(v1, 2);
  v0.addEdge(v2, 4);
  v1.addEdge(v3, 1);
  v1.addEdge(v4, 3);
  v2.addEdge(v3, 3);
  v2.addEdge(v4, 1);
  v3.addEdge(v5, 2);
  v4.addEdge(v2, 1);
  v4.addEdge(v5, 4);

  final graph = NetworkGraph(v0);
  graph.maxFlow();
}
